defmodule Exfuck.Mixfile do
  use Mix.Project

  def project do
    [app: :exfuck,
     version: "0.1.0",
     elixir: "~> 1.1",
     description: "Brainfuck interpreter written in elixir",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  def package do
    [
      maintainers: ["Igor Šarčević (shiroyasha)"],
      links: %{"GitHub": "https://github.com/shiroyasha/exfuck"},
      licenses: ["MIT"]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
