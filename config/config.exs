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
  pubsub: [name: Nagini.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "battlesnake.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
