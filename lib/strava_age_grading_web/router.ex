defmodule StravaAgeGradingWeb.Router do
  use StravaAgeGradingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StravaAgeGradingWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/auth", AuthController, :index
    get "/auth/callback", AuthController, :callback

    resources "/races", RaceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", StravaAgeGradingWeb do
  #   pipe_through :api
  # end
end
