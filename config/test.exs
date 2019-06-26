use Mix.Config

# Configure your database
config :strava_age_grading, StravaAgeGrading.Repo,
  username: "postgres",
  password: "postgres",
  database: "strava_age_grading_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :strava_age_grading, StravaAgeGradingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
