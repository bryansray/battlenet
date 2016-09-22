defmodule Battlenet.Config do
	def region do
		config[:region] || "us"
	end

	def api_site_url, do: config[:api_site_url] || "https://#{region}.api.battle.net"
	def site_url, do: config[:site_url] || "https://#{region}.battle.net"

	def client_id, do: config[:client_id]
	def api_key, do: config[:api_key]
	def redirect_uri, do: config[:redirect_uri]

	defp config, do: Application.get_all_env(:battlenet)
end