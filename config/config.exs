# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :strava_age_grading,
  ecto_repos: [StravaAgeGrading.Repo]

# Configures the endpoint
config :strava_age_grading, StravaAgeGradingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FwkcfXcPE/ruRCiCLedgGo6GYro6o2gzHDlW79E9yxXQA7sNCXgNKlM6WzXFpKSp",
  render_errors: [view: StravaAgeGradingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StravaAgeGrading.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
