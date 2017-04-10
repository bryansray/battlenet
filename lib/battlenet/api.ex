defmodule Battlenet.API do
	def get!(url) do
		Battlenet.API.Base.get!(url, [], [timeout: 10_000])
		|> Map.take([:body])
		|> Map.get(:body)
		|> Map.new
	end
end