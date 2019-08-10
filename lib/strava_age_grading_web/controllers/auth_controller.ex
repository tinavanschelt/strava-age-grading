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

    check = OAuth2.Client.get!(client, "/api/v3/athlete").body
    # IO.inspect(check)

    changeset =
      User.changeset(
        %User{},
        %{
          strava_id: athlete["id"],
          access_token: access_token
        }
      )

    user = Repo.insert!(changeset)
    IO.inspect(athlete)

    conn
    |> put_session(:access_token, access_token)
    |> redirect(
      to: Routes.user_path(conn, :edit, user.id, name: athlete["firstname"], sex: athlete["sex"])
    )
  end
end
