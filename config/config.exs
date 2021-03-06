# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :askcode, ecto_repos: [Askcode.Repo]

# Configures the endpoint
config :askcode, Askcode.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4pKINtjISV1BEWENa8sHvumBZDPTvp9kzfAjMBem2Ujcn3RzkN82tLJS0wRIbRxZ",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Askcode.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Askcode.#{Mix.env}",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: to_string(Mix.env),
  serializer: Askcode.GuardianSerializer
