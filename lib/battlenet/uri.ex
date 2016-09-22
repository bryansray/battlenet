defmodule Battlenet.URI do
	def query_params(fields) do
		%{ fields: Enum.join(fields, ","), locale: "en_US", apikey: Battlenet.Config.api_key }
		|> URI.encode_query
	end
end