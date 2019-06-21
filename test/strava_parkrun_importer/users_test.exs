defmodule StravaParkrunImporter.UsersTest do
  use StravaParkrunImporter.DataCase

  alias StravaParkrunImporter.Users

  describe "users" do
    alias StravaParkrunImporter.Users.User

    @valid_attrs %{access_token: "some access_token", "email.string": "some email.string", refresh_token: "some refresh_token"}
    @update_attrs %{access_token: "some updated access_token", "email.string": "some updated email.string", refresh_token: "some updated refresh_token"}
    @invalid_attrs %{access_token: nil, "email.string": nil, refresh_token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.access_token == "some access_token"
      assert user.email.string == "some email.string"
      assert user.refresh_token == "some refresh_token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.access_token == "some updated access_token"
      assert user.email.string == "some updated email.string"
      assert user.refresh_token == "some updated refresh_token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
