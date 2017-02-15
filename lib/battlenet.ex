defmodule Battlenet.Application do
	use Application

	def start(_types, _args) do
		IO.puts("Starting Battlenet Application ...")
		Battlenet.Supervisor.start_link
	end
end

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

defmodule Battlenet.Cache do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Callbacks
  def init(_) do
  	IO.puts("Initializing Battlenet.Cache ...")
  	{ :ok, nil }
	end

  def get(store, url) do
    Map.get(store, url)
  end
end

defmodule Battlenet.Server do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [], name: :battlenet)
	end

	def init(_) do
		IO.puts("Starting Battlenet.Server ...")
		{ :ok, nil }
	end
end