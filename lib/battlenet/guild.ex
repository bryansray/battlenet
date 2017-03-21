defmodule Battlenet.Guild do
	use GenServer

	def start do
		GenServer.start(__MODULE__, nil, name: __MODULE__)
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# interfaces
	###############
	def members(realm, guild_name), do: GenServer.call(__MODULE__, { :get, realm, guild_name, "members" }) #get(realm, guild_name, "members")
	def profile(realm, guild_name),  do: GenServer.call(__MODULE__, { :get, realm, guild_name, "profile" }) #get(realm, guild_name, "challenge")
	def achievements(realm, guild_name), do: GenServer.call(__MODULE__, { :get, realm, guild_name, "achievements" }) #get(realm, guild_name, "achievements")
	def news(realm, guild_name), do: GenServer.call(__MODULE__, { :get, realm, guild_name, "news" }) # get(realm, guild_name, "news")
	def challenge(realm, guild_name), do: GenServer.call(__MODULE__, { :get, realm, guild_name, "challenge" }) # get(realm, guild_name, "challenge")
	def get(realm, guild_name, fields) when is_list(fields), do: GenServer.call(__MODULE__, { :get, realm, guild_name, fields })
	def get(realm, guild_name, field), do: GenServer.call(__MODULE__, { :get, realm, guild_name, [field] })
	def get(realm, guild_name), do: GenServer.call(__MODULE__, { :get, realm, guild_name, [] })
	
	###############
	# Callbacks
	###############
	def init(_args) do
		{ :ok, nil }	
	end

	def handle_call({ :get, realm, guild, fields }, _from, _state) do
		response = find(realm, guild, fields)
		{ :reply, response, nil }
	end

	###############
	# Private
	###############
	defp get!(url), do: Battlenet.API.get!(url)

	defp find(realm, guild_name, fields) when is_list(fields) do
		generate_url(realm, guild_name, fields)
		|> get!
	end
	defp find(realm, guild_name, field), do: find(realm, guild_name, [field])
	# defp find(realm, guild_name), do: find(realm, guild_name, [])


	defp generate_url(realm, guild_name, fields) when is_list(fields) do
		query_string = Battlenet.URI.query_params(fields)
		"/wow/guild/#{realm}/#{guild_name}?" <> query_string
	end

	defp generate_url(realm, guild_name, field), do: generate_url(realm, guild_name, [field])
end