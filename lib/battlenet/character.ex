defmodule Battlenet.Character do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, :ok, [])
	end

	def stop(pid) do
		GenServer.stop(pid)
	end

	###############
	# interfaces
	###############
	def profile(pid, realm, character_name), 			do: call(pid, realm, character_name)
	def achievements(pid, realm, character_name), do: call(pid, realm, character_name, "achievements")
	def appearance(pid, realm, character_name), 	do: call(pid, realm, character_name, "appearance")
	def feed(pid, realm, character_name), 				do: call(pid, realm, character_name, "feed")
	def guild(pid, realm, character_name), 				do: call(pid, realm, character_name, "guild")
	def items(pid, realm, character_name), 				do: call(pid, realm, character_name, "items")
	def mounts(pid, realm, character_name), 			do: call(pid, realm, character_name, "mounts")
	def pets(pid, realm, character_name), 				do: call(pid, realm, character_name, "pets")
	def pet_slots(pid, realm, character_name), 		do: call(pid, realm, character_name, "petSlots")
	def professions(pid, realm, character_name), 	do: call(pid, realm, character_name, "professions")
	def progression(pid, realm, character_name), 	do: call(pid, realm, character_name, "progression")
	def pvp(pid, realm, character_name), 					do: call(pid, realm, character_name, "pvp")
	def quests(pid, realm, character_name), 			do: call(pid, realm, character_name, "quests")
	def reputation(pid, realm, character_name), 	do: call(pid, realm, character_name, "reputation")
	def statistics(pid, realm, character_name), 	do: call(pid, realm, character_name, "statistics")
	def stats(pid, realm, character_name), 				do: call(pid, realm, character_name, "stats")
	def talents(pid, realm, character_name), 			do: call(pid, realm, character_name, "talents")
	def titles(pid, realm, character_name), 			do: call(pid, realm, character_name, "titles")
	def audit(pid, realm, character_name), 				do: call(pid, realm, character_name, "audit")

	def get(pid, realm, character_name, fields) when is_list(fields) do
		call(pid, realm, character_name, fields)
	end
	def get(pid, realm, character_name, field), do: call(pid, realm, character_name, [field])
	def get(pid, realm, character_name), 				do: call(pid, realm, character_name, [])

	###############
	# callbacks
	###############
	def init(_args) do
		{ :ok, [] }
	end

	def handle_call( { :get, realm, character_name, fields }, _from, _state) do
		response = generate_url(realm, character_name, fields)
		|> Battlenet.API.get!

		{ :reply, response, [] }
	end

	###############
	# Private
	###############
	defp call(pid, realm, character_name, fields) when is_list(fields), do: GenServer.call(pid, { :get, realm, character_name, fields })
	defp call(pid, realm, character_name, field), do: call(pid, realm, character_name, [field])
	defp call(pid, realm, character_name), do: call(pid, realm, character_name, [])

	defp generate_url(realm, character_name, fields) when is_list(fields) do
		query_params = Battlenet.URI.query_params(fields)
		"/wow/character/#{realm}/#{character_name}?" <> query_params
	end
end