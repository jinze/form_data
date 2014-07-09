defmodule FormData.Mixfile do
  use Mix.Project

  def project do
    [app: :form_data,
     version: "0.1.1",
     elixir: "~> 0.14.2",
     name: "FormData",
     description: "Build a multipart/form-data form struct in Elixir.",
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: []]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [ { :mime, github: "dynamo/mime" } ]
  end

  defp package do
  [
    contributors: ["Ze Jin"],
    licenses:      ["MIT"],
    links: [
      { "GitHub", "https://github.com/jinze/form_data" }
    ]
  ]
end
end
