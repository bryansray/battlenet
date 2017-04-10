defmodule Battlenet.CharacterClasses do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# interfaces
	###############
	def get(region \\ "us"), do: GenServer.call(__MODULE__, { :get, region })
	
	###############
	# Callbacks
	###############
	def init(_args) do
		{ :ok, [] }
	end

	def handle_call({ :get, region }, _from, _state) do
		response = generate_url(region) |> get!
		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp get!(url), do: Battlenet.API.get!(url)

	defp generate_url(region) do
		query_string = Battlenet.URI.query_params()
		"https://#{region}.api.battle.net/wow/data/character/classes?" <> query_string
	end
end

defmodule Battlenet.Races do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# interfaces
	###############
	def get(region \\ "us"), do: GenServer.call(__MODULE__, { :get, region })
	
	###############
	# Callbacks
	###############
	def init(_args) do
		{ :ok, [] }
	end

	def handle_call({ :get, region }, _from, _state) do
		response = generate_url(region) |> get!
		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp get!(url), do: Battlenet.API.get!(url)

	defp generate_url(region) do
		query_string = Battlenet.URI.query_params()
		"https://#{region}.api.battle.net/wow/data/character/races?" <> query_string
	end
end