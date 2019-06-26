defmodule StravaAgeGrading.Repo do
  use Ecto.Repo,
    otp_app: :strava_age_grading,
    adapter: Ecto.Adapters.Postgres
end
