defmodule Battlenet.URI do
	def query_params(fields) when not is_nil(fields) do
		case Enum.count(fields) do
			0 ->
				%{ locale: "en_US", apikey: Battlenet.Config.api_key }
			_ ->
				%{ fields: Enum.join(fields, ","), locale: "en_US", apikey: Battlenet.Config.api_key }
		end
		|> URI.encode_query
	end

	def query_params(), do: %{ locale: "en_US", apikey: Battlenet.Config.api_key } |> URI.encode_query
end