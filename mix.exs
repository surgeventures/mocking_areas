defmodule MockingAreas.MixProject do
  use Mix.Project

  def project do
    [
      app: :mocking_areas,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env)
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:mox, ">= 0.0.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_),     do: ["lib"]
end
