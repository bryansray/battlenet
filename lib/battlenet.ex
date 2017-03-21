defmodule Battlenet.Application do
	use Application

	def start(_types, _args) do
		IO.puts("Starting Battlenet Application ...")
		Battlenet.Supervisor.start_link
	end
end