defmodule Battlenet.Supervisor do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, [])
	end

	def init([]) do
		children = [
			worker(Battlenet.Character, []),
			worker(Battlenet.CharacterClasses, []),
			worker(Battlenet.Guild, []),
			worker(Battlenet.Races, []),
			worker(Battlenet.Quest, []),
			worker(Battlenet.RealmStatus, [])
			# worker(Battlenet.Cache, []),
			# worker(Battlenet.Server, [])
		]

		supervise(children, strategy: :one_for_one)
	end
end