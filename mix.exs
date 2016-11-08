defmodule Chromecast.Mixfile do
  use Mix.Project

  def project do
    [app: :chromecast,
     version: "0.1.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :ssl, :exprotobuf, :poison]]
  end

  def description do
      """
      A library for controlling and monitoring a Chromecast
      """
  end

  def package do
    [
      name: :chromecast,
      files: ["lib", "proto", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Christopher Steven Coté"],
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/NationalAssociationOfRealtors/chromecast",
          "Docs" => "https://github.com/NationalAssociationOfRealtors/chromecast"}
    ]
  end

  defp deps do
    [
        {:exprotobuf, "~> 1.1.0"},
        {:poison, "~> 2.2.0"},
        {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
