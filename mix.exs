defmodule DigitalOceanApi.Mixfile do
  use Mix.Project

  def project do
    [ app: :digital_ocean_api,
      version: "0.0.1",
      elixir: "~> 0.12.4",
      deps: deps ]
  end

  def application do
    []
  end

  defp deps do
    [
     { :json, github: "cblage/elixir-json"},
    ]
  end
end
