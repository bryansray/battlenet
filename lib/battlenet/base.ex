
defmodule Battlenet.API.Base do
	use HTTPoison.Base

	def process_url(url) do
		Battlenet.Config.api_site_url
		|> URI.merge(url)
		|> to_string
	end

	def process_response_body(body) do
		body
		|> Poison.decode!
		# |> Enum.map(&to_atom_key_value/1)
	end

	# defp to_atom_key_value({ key, value }) do
	# 	{ String.to_atom(key), value }
	# end
end