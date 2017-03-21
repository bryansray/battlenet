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
