defmodule Battlenet.API do
	def get!(url) do
		Battlenet.Cache.URL.get!(url)
		|> Map.take([:body])
		|> Map.get(:body)
		|> Map.new
	end
end