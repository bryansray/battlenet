defmodule Battlenet.Application do
	use Application

	def start(_types, _args) do
		Battlenet.Supervisor.start_link
	end
end