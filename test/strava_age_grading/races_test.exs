defmodule StravaAgeGrading.RacesTest do
  use StravaAgeGrading.DataCase

  alias StravaAgeGrading.Races

  describe "races" do
    alias StravaAgeGrading.Races.Race

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def race_fixture(attrs \\ %{}) do
      {:ok, race} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Races.create_race()

      race
    end

    test "list_races/0 returns all races" do
      race = race_fixture()
      assert Races.list_races() == [race]
    end

    test "get_race!/1 returns the race with given id" do
      race = race_fixture()
      assert Races.get_race!(race.id) == race
    end

    test "create_race/1 with valid data creates a race" do
      assert {:ok, %Race{} = race} = Races.create_race(@valid_attrs)
    end

    test "create_race/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Races.create_race(@invalid_attrs)
    end

    test "update_race/2 with valid data updates the race" do
      race = race_fixture()
      assert {:ok, %Race{} = race} = Races.update_race(race, @update_attrs)
    end

    test "update_race/2 with invalid data returns error changeset" do
      race = race_fixture()
      assert {:error, %Ecto.Changeset{}} = Races.update_race(race, @invalid_attrs)
      assert race == Races.get_race!(race.id)
    end

    test "delete_race/1 deletes the race" do
      race = race_fixture()
      assert {:ok, %Race{}} = Races.delete_race(race)
      assert_raise Ecto.NoResultsError, fn -> Races.get_race!(race.id) end
    end

    test "change_race/1 returns a race changeset" do
      race = race_fixture()
      assert %Ecto.Changeset{} = Races.change_race(race)
    end
  end
end
