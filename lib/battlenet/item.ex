
defmodule Battlenet.Item do
	use GenServer

	def start do
		GenServer.start(__MODULE__, nil, name: __MODULE__)
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# interface
	###############
	def item(item_id), do: GenServer.call(__MODULE__, { :get, item_id })
	def item_set(set_id), do: GenServer.call(__MODULE__, { :get_item_set, set_id })
	
	###############
	# callbacks
	###############
	def handle_call({ :get, item_id }, _from, _state) do
		response = generate_url("/wow/item/#{item_id}")
		|> Battlenet.API.get!

		{ :reply, response, nil }
	end

	def handle_call({ :get_item_set, set_id }, _from, _state) do
		response = generate_url("/wow/item/set/#{set_id}")
		|> Battlenet.API.get!

		{ :reply, response, nil }
	end

	def generate_url(url) do
		query_params = Battlenet.URI.query_params([])
		IO.inspect(query_params)
		url <> "?" <> query_params
	end
end