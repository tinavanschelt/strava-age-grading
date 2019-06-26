defmodule StravaParkrunImporter.Races.Race do
  use Ecto.Schema
  import Ecto.Changeset

  schema "races" do

    timestamps()
  end

  @doc false
  def changeset(race, attrs) do
    race
    |> cast(attrs, [])
    |> validate_required([])
  end
end
