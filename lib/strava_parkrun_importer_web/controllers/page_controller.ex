defmodule StravaParkrunImporterWeb.PageController do
  use StravaParkrunImporterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
