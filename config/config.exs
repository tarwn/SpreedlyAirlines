# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :spreedly_airlines,
  ecto_repos: [SpreedlyAirlines.Repo]

# Configures the endpoint
config :spreedly_airlines, SpreedlyAirlines.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PS2gxZacxMdxbLF2b74NEBJDDCEWsILdEvdavf9z0yOb0Rdb4+PwAWLgeLsl6o9r",
  render_errors: [view: SpreedlyAirlines.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SpreedlyAirlines.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
