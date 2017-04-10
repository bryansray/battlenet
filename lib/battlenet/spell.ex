defmodule Battlenet.Spell do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	def get(pid, spell_id) do
		GenServer.call(pid, { :get, spell_id })
	end

	###############
	# Callbacks
	###############
	def init(_state) do
		{ :ok, [] }
	end

	def handle_call({ :get, spell_id }, _from, _state) do
		response = generate_url(spell_id) |> Battlenet.API.get!
		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp generate_url(spell_id) do
		query_string = Battlenet.URI.query_params([])
		"/wow/spell/#{spell_id}?" <> query_string
	end
end