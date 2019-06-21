defmodule StravaParkrunImporter.Repo do
  use Ecto.Repo,
    otp_app: :strava_parkrun_importer,
    adapter: Ecto.Adapters.Postgres
end
