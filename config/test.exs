use Mix.Config

# Configure your database
config :strava_parkrun_importer, StravaParkrunImporter.Repo,
  username: "postgres",
  password: "postgres",
  database: "strava_parkrun_importer_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :strava_parkrun_importer, StravaParkrunImporterWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
