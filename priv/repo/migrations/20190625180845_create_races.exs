defmodule StravaParkrunImporter.Repo.Migrations.CreateRaces do
  use Ecto.Migration

  def change do
    create table(:races) do

      timestamps()
    end

  end
end
