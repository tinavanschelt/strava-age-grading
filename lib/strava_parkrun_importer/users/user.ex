defmodule StravaParkrunImporter.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :access_token, :string
    field :"email.string", :string
    field :refresh_token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:"email.string", :access_token, :refresh_token])
    |> validate_required([:"email.string", :access_token, :refresh_token])
  end
end
