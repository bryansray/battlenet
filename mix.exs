defmodule Battlenet.Mixfile do
  use Mix.Project

  def project do
    [app: :battlenet,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison],
     mod: {Battlenet.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.9.1"},
     {:poison, "~> 2.2"},
     {:ex_doc, ">= 0.0.0", only: :dev},
     {:mix_test_watch, "~> 0.2.6", only: :dev}]
  end

  defp description do
    """
    Battlenet is an Elixir library that exposes Blizzard's Community Platform API.
    """
  end

  defp package do
    [
      name: :battlenetex,
      maintainers: ["Bryan Ray <bryan@bryanray.net>"],
      licenses: ["GPL-3.0"],
      links: %{ "Github" => "http://github.com/bryansray/battlenet" }]
  end
end
