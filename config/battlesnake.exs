use Mix.Config

config :nagini, :battlesnake,
  timeout: System.get_env("BATTLESNAKE_TIMEOUT") || 250,
  color: System.get_env("BATTLESNAKE_COLOR") || "#ff3d00",
  head_type: System.get_env("BATTLESNAKE_HEAD") || "fang",
  tail_type: System.get_env("BATTLESNAKE_TAIL") || "round-bum"
