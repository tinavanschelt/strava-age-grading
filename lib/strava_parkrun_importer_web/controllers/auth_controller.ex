defmodule StravaParkrunImporterWeb.AuthController do
  use StravaParkrunImporterWeb, :controller

  def index(conn, _params) do
    redirect(conn, external: "https://www.strava.com/oauth/authorize")
  end
end
