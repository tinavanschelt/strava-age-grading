defmodule StravaAgeGradingWeb.PageController do
  use StravaAgeGradingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
