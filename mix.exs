defmodule Airtable.Mixfile do
  use Mix.Project

  def project do
    [app: :airtable,
     version: "0.1.0",
     elixir: "~> 1.6",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
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
    [
      {:httpoison, "~> 0.8"},
      {:credo, "~> 0.2", only: [:test,:dev]},
      {:coverex, "~> 1.4", only: :test},
      {:mix_test_watch, ">= 0.0.0", only: [:dev, :test]},
      {:power_assert, ">= 0.0.0"},
      {:exconstructor, ">= 1.0.0"},
      {:poison, "~> 2.2"},
      {:tesla, "~> 1.0.0-beta"},
      {:jason, "~> 1.0.0"},
    ]
  end
end
