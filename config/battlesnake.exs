use Mix.Config

config :nagini, :battlesnake,
  color: System.get_env("BATTLESNAKE_COLOR") || "#FF0000",
  timeout: System.get_env("BATTLESNAKE_TIMEOUT") || 250
