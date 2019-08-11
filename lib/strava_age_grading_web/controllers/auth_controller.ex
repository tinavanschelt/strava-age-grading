defmodule StravaAgeGradingWeb.AuthController do
  use StravaAgeGradingWeb, :controller
  alias StravaAgeGrading.Repo
  alias StravaAgeGrading.Users.User

  def index(conn, _params) do
    redirect(conn, external: Strava.authorize_url!())
  end

  def callback(conn, %{"code" => code}) do
    client = Strava.get_token!(code: code)
    access_token = client.token.access_token
    athlete = client.token.other_params["athlete"]

    {:ok, user} = 
      case Repo.get_by(User, strava_id: athlete["id"]) do
        nil  -> %User{} 
        user -> user
      end
      |> User.changeset(%{
          strava_id: athlete["id"],
          access_token: access_token
        })
      |> Repo.insert_or_update

    route = if user.age do
              Routes.race_path(conn, :index, sex: athlete["sex"])
            else
              Routes.user_path(conn, :edit, user.id, name: athlete["firstname"], sex: athlete["sex"])
            end

    conn
    |> put_session(:access_token, access_token)
    |> redirect(to: route)
  end
end
