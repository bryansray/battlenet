defmodule Battlenet.Guild do
	defstruct [ :realm, :name ]

	# def storage(%Battlenet.Cache{} = cache), do: "#{cache.region}/guilds/#{cache.realm}/#{cache.name}"

	def members(realm, guild_name), do: get(realm, guild_name, "members")
	def profile(realm, guild_name),  do: get(realm, guild_name, "challenge")
	def achievements(realm, guild_name), do: get(realm, guild_name, "achievements")
	def news(realm, guild_name), do: get(realm, guild_name, "news")
	def challenge(realm, guild_name), do: get(realm, guild_name, "challenge")

	def get!(url), do: Battlenet.API.get!(url)

	def get(realm, guild_name, fields) when is_list(fields) do
		generate_url(realm, guild_name, fields)
		|> get!
	end
	def get(realm, guild_name, field), do: get(realm, guild_name, [field])
	def get(realm, guild_name), do: get(realm, guild_name, [])

	defp generate_url(realm, guild_name, fields) when is_list(fields) do
		query_string = Battlenet.URI.query_params(fields)
		"/wow/guild/#{realm}/#{guild_name}?" <> query_string
	end

	defp generate_url(realm, guild_name, field), do: generate_url(realm, guild_name, [field])
end

defmodule Battlenet.Guild.Parser do
	use GenServer

	def start do
		GenServer.start(__MODULE__, nil)
	end

	def parse(pid, realm, guild_name, fields \\ ["members"]) do
		GenServer.cast(pid, { :parse, realm, guild_name, fields })
	end

	# callbacks
	def init(_) do
		{ :ok, nil }
	end

	def handle_cast({ :parse, realm, guild_name, fields }, _) do
		guild = Battlenet.Guild.get(realm, guild_name, fields)

    parse_members(guild.members)

		{ :noreply, nil }
	end

	defp parse_members([ member | members ]) do
		%{ "character" => %{ "realm" => realm, "name" => name } } = member
		IO.puts("#{realm}.#{name}")
	  parse_members(members)
	end

	defp parse_members([]), do: nil
end

defmodule Battlenet.Character.Parser do
	use GenServer

	def start do
		GenServer.start(__MODULE__, nil)
	end

	def stop(pid) do
		GenServer.stop(pid)
	end

	def parse(pid, realm, character_name, fields) do
		GenServer.call(pid, { :parse, realm, character_name, fields })
	end

	# callbacks
	def init(_) do
		{ :ok, nil }
	end

	def handle_call({ :parse, realm, character_name, fields }, _from, _state) do
		IO.puts("Get character #{realm}.#{character_name}. With: #{inspect(fields)}")

		{ :reply, nil }
	end
end

defmodule Battlenet.GuildServer do
	use GenServer

	#########################
	#### interface
	#########################
	def start do
		GenServer.start(__MODULE__, nil)
	end

	def get(server, realm, guild_name, fields) when is_list(fields) do
		GenServer.call(server, { :get, realm, guild_name, fields })
	end

	#########################
	#### handlers
	#########################	
	def init(_) do
		{ :ok, nil }
	end

	def handle_call({ :get, realm, guild_name, fields }, _, state) do
		{ 
			:reply,
			{ :ok, Battlenet.Guild.get(realm, guild_name, fields) },
			state
		}
	end
end

defmodule Battlenet.Testing do
	def test do
		{ :ok, pid } = Battlenet.Guild.Parser.start
		Battlenet.Guild.Parser.parse(pid, "Greymane", "Solution")

		# { :ok, server2 } = Battlenet.Guild.Parser.start
		# Battlenet.Guild.Parser.parse(server2, "Greymane", "Despotism")

		# Battlenet.GuildWorker.get("Greymane", "Solution", [])
		# Battlenet.GuildWorker.get("Greymane", "Despotism", [])
	end
end

# Battlenet.Character.get(Greymane", "Virtualize", [:achievements, :appearance])
