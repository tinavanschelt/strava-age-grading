defmodule Strava do
  @moduledoc """
  An OAuth2 strategy for Strava.
  """
  use OAuth2.Strategy
  alias OAuth2.Strategy.AuthCode

  # Public API

  def client do
    OAuth2.Client.new(
      strategy: __MODULE__,
      client_id: System.get_env("STRAVA_CLIENT_ID"),
      client_secret: System.get_env("STRAVA_CLIENT_SECRET"),
      redirect_uri: System.get_env("REDIRECT_URI"),
      site: "https://www.strava.com",
      authorize_url: "https://www.strava.com/oauth/authorize",
      token_url: "https://www.strava.com/oauth/token"
    )
    |> OAuth2.Client.put_serializer("application/json", Jason)
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], _headers \\ []) do
    OAuth2.Client.get_token!(
      client(),
      Keyword.merge(params, client_secret: client().client_secret)
    )
  end

  # Strategy Callbacks

  @spec authorize_url(
          OAuth2.Client.t(),
          keyword
          | %{
              optional(binary) =>
                binary
                | [binary | [any] | %{optional(binary) => any}]
                | %{optional(binary) => binary | [any] | %{optional(binary) => any}}
            }
        ) :: OAuth2.Client.t()
  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
