defmodule Battlenet.Zone do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	def zones(pid), do: GenServer.call(pid, { :get, "zones" })
	def zone(pid, zone_id), do: GenServer.call(pid, { :get, zone_id })

	###############
	# Callbacks
	###############
	def init(_state) do
		{ :ok, [] }
	end

	def handle_call({ :get, "zones" }, _from, _state) do
		response = generate_url("/wow/zone/") |> Battlenet.API.get!
		{ :reply, response, [] }
	end

	def handle_call({ :get, zone_id }, _from, _state) do
		response = generate_url("/wow/zone/#{zone_id}") |> Battlenet.API.get!
		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp generate_url(url) do
		query_string = Battlenet.URI.query_params()
		url <> "?" <> query_string
	end
end