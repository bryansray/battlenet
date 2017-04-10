defmodule Battlenet.Boss do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# Interface
	###############
	def get(pid) do
		GenServer.call(pid, { :get })
	end

	def get(pid, boss_id) do
		GenServer.call(pid, { :get, boss_id })
	end

	###############
	# Callbacks
	###############
	def handle_call({ :get }, _from, _state) do
		response = generate_url("/wow/boss/") |> Battlenet.API.get!

		{ :reply, response, [] }
	end

	def handle_call({ :get, boss_id }, _from, _state) do
		response = generate_url("/wow/boss/#{boss_id}") |> Battlenet.API.get!

		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp generate_url(url) do
		query_params = Battlenet.URI.query_params()
		url <> "?" <> query_params
	end
end