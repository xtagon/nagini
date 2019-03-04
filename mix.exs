defmodule Nagini.MixProject do
  use Mix.Project

  def project do
    [
      app: :nagini,
      version: "0.5.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Nagini.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :appsignal,
        :eventstore
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/fixtures"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.1"},
      {:phoenix_pubsub, "~> 1.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:plug_redirect, "~> 1.0"},
      {:basic_auth, "~> 2.2.2"},
      {:logger_file_backend, "~> 0.0.10"},
      {:appsignal, "~> 1.0"},
      {:commanded, "~> 0.18"},
      {:commanded_eventstore_adapter, "~> 0.5"},
      {:msgpax, "~> 2.0"}
    ]
  end
end
