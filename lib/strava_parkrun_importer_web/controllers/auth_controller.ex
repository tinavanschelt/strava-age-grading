defmodule StravaParkrunImporterWeb.AuthController do
  use StravaParkrunImporterWeb, :controller
  alias StravaParkrunImporter.Repo
  alias StravaParkrunImporter.Users.User

  def index(conn, _params) do
    redirect(conn, external: Strava.authorize_url!())
  end

  def callback(conn, %{"code" => code}) do
    client = Strava.get_token!(code: code)
    access_token = client.token.access_token
    athlete = client.token.other_params["athlete"]

    IO.puts "yeah"
    activities = OAuth2.Client.get!(client, "/api/v3/activities").body
    filtered_activities = Enum.filter(activities, fn x -> x["type"] == "Run" and x["workout_type"] == 1 end)
    IO.inspect(filtered_activities)

    changeset = User.changeset(%User{},
      %{strava_id: athlete["id"],
        access_token: access_token
      })
    Repo.insert!(changeset)

    conn
      |> put_flash(:info, "Strava connected successfully.")
      |> put_session(:access_token, access_token)
      |> redirect(to: "/")
  end
end
