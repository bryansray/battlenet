defmodule Battlenet.Achievement do
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
	def get(pid, achievement_id) do
		GenServer.call(pid, { :get, achievement_id })
	end

	###############
	# Callbacks
	###############
	def handle_call({ :get, achievement_id }, _from, _state) do
		response = generate_url("/wow/achievement/#{achievement_id}") |> Battlenet.API.get!

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