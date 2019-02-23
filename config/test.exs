use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nagini, NaginiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only everything during test (it's useful for now)
config :logger, level: :debug
