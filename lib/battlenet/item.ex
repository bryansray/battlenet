defmodule Battlenet.Item do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# interface
	###############
	def get(pid, item_id), do: GenServer.call(pid, { :get, item_id })
	def get_item_set(pid, set_id), do: GenServer.call(pid, { :get_item_set, set_id })
	
	###############
	# callbacks
	###############
	def handle_call({ :get, item_id }, _from, _state) do
		response = generate_url("/wow/item/#{item_id}")
		|> Battlenet.API.get!

		{ :reply, response, [] }
	end

	def handle_call({ :get_item_set, set_id }, _from, _state) do
		response = generate_url("/wow/item/set/#{set_id}")
		|> Battlenet.API.get!

		{ :reply, response, [] }
	end

	###############
	# private
	###############
	defp generate_url(url) do
		query_params = Battlenet.URI.query_params([])
		url <> "?" <> query_params
	end
end