defmodule Battlenet.Server do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [], name: :battlenet)
	end

	def init(_) do
		{ :ok, nil }
	end
end
