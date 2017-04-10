defmodule Battlenet.Guild do
	use GenServer

	defstruct [:name, :level, :realm, :side, :achievement_points, :battlegroup, :last_modified]

	def start_link do
		GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
	end

	def stop do
		GenServer.stop(__MODULE__)
	end

	###############
	# interfaces
	###############
	def members(region, realm, guild), 				do: call(region, realm, guild, "members")
	def profile(region, realm, guild),  			do: call(region, realm, guild, "profile")
	def achievements(region, realm, guild), 	do:	call(region, realm, guild, "achievements")
	def news(region, realm, guild), 					do: call(region, realm, guild, "news")
	def challenge(region, realm, guild), 			do: call(region, realm, guild, "challenge")
	
	def get(region, realm, guild, fields) when is_list(fields), do: call(region, realm, guild, fields)
	def get(region, realm, guild, field), 		do: call(region, realm, guild, [field])
	def get(region, realm, guild), 						do: call(region, realm, guild)
	
	###############
	# Callbacks
	###############
	def init(_args) do
		{ :ok, [] }
	end

	def handle_call({ :get, region, realm, guild, fields }, _from, _state) do
		response = find(region, realm, guild, fields)
		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp call(region, realm, guild, fields) when is_list(fields), do: GenServer.call(__MODULE__, { :get, region, realm, guild, fields })
	defp call(region, realm, guild, field), do: call(region, realm, guild, [field])
	defp call(region, realm, guild), 				do: call(region, realm, guild, [])

	defp get!(url), do: Battlenet.API.get!(url)

	defp find(region, realm, guild, fields) when is_list(fields) do
		generate_url(region, realm, guild, fields)
		|> get!
	end
	defp find(region, realm, guild, field), do: find(region, realm, guild, [field])

	defp generate_url(region, realm, guild, fields) when is_list(fields) do
		query_string = Battlenet.URI.query_params(fields)
		"https://#{region}.api.battle.net/wow/guild/#{URI.encode(realm)}/#{URI.encode(guild)}?" <> query_string
	end
end