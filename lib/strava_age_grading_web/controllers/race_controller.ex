defmodule StravaAgeGradingWeb.RaceController do
  use StravaAgeGradingWeb, :controller

  import Ecto.Changeset
  alias StravaAgeGrading.Races
  alias StravaAgeGrading.Races.Race
  alias StravaAgeGrading.Repo
  alias StravaAgeGrading.Users.User

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, %{"sex" => sex}) do
    access_token = conn |> get_session(:access_token)
    headers = [Authorization: "Bearer #{access_token}"]
    {:ok, response} = HTTPoison.get("https://www.strava.com/api/v3/activities", headers)
    response = Jason.decode!(response.body)
    races = Enum.filter(response, fn x -> x["type"] == "Run" and x["workout_type"] == 1 end)

    {:ok, data} = File.read("data/factors.json")
    data = Jason.decode!(data)
    age = update_user_age(access_token)

    grades =
      Enum.map(races, fn race ->
        distance = Decimal.round(Decimal.div(Decimal.from_float(race["distance"]), 1000), 2)
        label = Decimal.to_string(Decimal.round(Decimal.div(Decimal.from_float(race["distance"]), 1000)))
        time = Decimal.new(race["elapsed_time"])
        record = Decimal.new(data[sex]["Record"]["Km"][label])
        factor = Decimal.new(data[sex][age]["Km"][label])

        result = Decimal.div(Decimal.div(record, factor), time)

        %{
          name: race["name"],
          time: race["elapsed_time"],
          distance: distance,
          label: label,
          age_grading: Decimal.round(Decimal.mult(result, 100), 2)
        }
      end)

    render(conn, "index.html", races: grades, sex: sex,  age: age)
  end

  def new(conn, _params) do
    changeset = Races.change_race(%Race{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"race" => race_params}) do
    case Races.create_race(race_params) do
      {:ok, race} ->
        conn
        |> put_flash(:info, "Race created successfully.")
        |> redirect(to: Routes.race_path(conn, :show, race))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    race = Races.get_race!(id)
    render(conn, "show.html", race: race)
  end

  def edit(conn, %{"id" => id}) do
    race = Races.get_race!(id)
    changeset = Races.change_race(race)
    render(conn, "edit.html", race: race, changeset: changeset)
  end

  def update(conn, %{"id" => id, "race" => race_params}) do
    race = Races.get_race!(id)

    case Races.update_race(race, race_params) do
      {:ok, race} ->
        conn
        |> put_flash(:info, "Race updated successfully.")
        |> redirect(to: Routes.race_path(conn, :show, race))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", race: race, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    race = Races.get_race!(id)
    {:ok, _race} = Races.delete_race(race)

    conn
    |> put_flash(:info, "Race deleted successfully.")
    |> redirect(to: Routes.race_path(conn, :index))
  end

  def update_user_age(access_token) do
    user = Repo.get_by(User, access_token: access_token)
    age = (DateTime.utc_now.year - user.updated_at.year) + user.age
    user
    |> change(%{age: age})
    |> Repo.update()

    age |> Integer.to_string
  end
end
