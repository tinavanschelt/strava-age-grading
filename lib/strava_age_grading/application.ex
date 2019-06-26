defmodule StravaAgeGrading.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      StravaAgeGrading.Repo,
      # Start the endpoint when the application starts
      StravaAgeGradingWeb.Endpoint
      # Starts a worker by calling: StravaAgeGrading.Worker.start_link(arg)
      # {StravaAgeGrading.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StravaAgeGrading.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    StravaAgeGradingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
