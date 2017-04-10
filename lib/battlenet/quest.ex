defmodule Battlenet.Quest do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [], [name: __MODULE__])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	def get(quest_id) do
		GenServer.call(__MODULE__, { :get, quest_id })
	end

	###############
	# Callbacks
	###############
	def init(_state) do
		{ :ok, [] }
	end

	def handle_call({ :get, quest_id }, _from, _state) do
		response = generate_url("us", quest_id) |> Battlenet.API.get!
		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp generate_url(region, quest_id) do
		query_string = Battlenet.URI.query_params([])
		"https://#{region}.api.battle.net/wow/quest/#{quest_id}?" <> query_string
	end
end