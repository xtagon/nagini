# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :nagini, NaginiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7BXYlUkzkFqDz626mxjOFcvJkHMqQjx6ah5P5BMOO1l/TOjg3utCEMoWMrORlO2Z",
  render_errors: [view: NaginiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Nagini.PubSub, adapter: Phoenix.PubSub.PG2],
  instrumenters: [Appsignal.Phoenix.Instrumenter]

# Configures Elixir's Logger

config :logger,
  backends: [:console, {LoggerFileBackend, :debug_log}],
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, :debug_log,
  path: "/tmp/nagini.log",
  level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "battlesnake.exs"
import_config "appsignal.exs"

config :nagini, basic_auth: [
  username: {:system, "ADMIN_USER"},
  password: {:system, "ADMIN_PASS"},
  realm: "Admin"
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
