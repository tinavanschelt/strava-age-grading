defmodule StravaParkrunImporter.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :access_token, :string
    field :email, :string
    field :strava_id, :integer
    field :refresh_token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :access_token, :strava_id, :refresh_token])
    |> validate_required([:access_token, :strava_id])
  end
end
