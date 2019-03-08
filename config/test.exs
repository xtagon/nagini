use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nagini, NaginiWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger,
  level: :error,
  compile_time_purge_level: :error

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: System.get_env("DATA_EVENT_STORE_USER"),
  password: System.get_env("DATA_EVENT_STORE_PASS"),
  hostname: System.get_env("DATA_EVENT_STORE_HOST"),
  database: "gonano",
  pool_size: 10

config :commanded, event_store_adapter: Commanded.EventStore.Adapters.InMemory

config :commanded, Commanded.EventStore.Adapters.InMemory, serializer: Commanded.Serialization.JsonSerializer
