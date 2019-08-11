defmodule StravaAgeGrading.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :access_token, :string
    field :strava_id, :integer
    field :refresh_token, :string
    field :age, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:access_token, :strava_id, :refresh_token, :age])
    |> validate_required([:access_token, :strava_id])
    |> unique_constraint(:strava_id)
  end
end
