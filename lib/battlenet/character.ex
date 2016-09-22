defmodule Battlenet.Character do
	def profile(realm, character_name), do: get(realm, character_name)
	def achievements(realm, character_name), do: get(realm, character_name, "achievements")
	def appearance(realm, character_name), do: get(realm, character_name, "appearance")
	def feed(realm, character_name), do: get(realm, character_name, "feed")
	def guild(realm, character_name), do: get(realm, character_name, "guild")
	def items(realm, character_name), do: get(realm, character_name, "items")
	def mounts(realm, character_name), do: get(realm, character_name, "mounts")
	def pets(realm, character_name), do: get(realm, character_name, "pets")
	def pet_slots(realm, character_name), do: get(realm, character_name, "petSlots")
	def professions(realm, character_name), do: get(realm, character_name, "professions")
	def progression(realm, character_name), do: get(realm, character_name, "progression")
	def pvp(realm, character_name), do: get(realm, character_name, "pvp")
	def quests(realm, character_name), do: get(realm, character_name, "quests")
	def reputation(realm, character_name), do: get(realm, character_name, "reputation")
	def statistics(realm, character_name), do: get(realm, character_name, "statistics")
	def stats(realm, character_name), do: get(realm, character_name, "stats")
	def talents(realm, character_name), do: get(realm, character_name, "talents")
	def titles(realm, character_name), do: get(realm, character_name, "titles")
	def audit(realm, character_name), do: get(realm, character_name, "audit")

	def get(realm, character_name, fields) when is_list(fields) do
		generate_url(realm, character_name, fields)
		|> Battlenet.API.get!
	end
	def get(realm, character_name, field), do: get(realm, character_name, [field])
	def get(realm, character_name), do: get(realm, character_name, [])

	defp generate_url(realm, character_name, fields) when is_list(fields) do
		query_params = Battlenet.URI.query_params(fields)
		"/wow/character/#{realm}/#{character_name}?" <> query_params
	end
end
