defmodule Battlenet.Supervisor do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, [])
	end

	def init([]) do
		IO.puts("Starting Battlenet.Supervisor ...")
		children = [
			worker(Battlenet.Cache, []),
			worker(Battlenet.Server, [])
		]

		supervise(children, strategy: :one_for_one)
	end
end