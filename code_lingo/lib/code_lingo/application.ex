defmodule CodeLingo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CodeLingoWeb.Telemetry,
      CodeLingo.Repo,
      {DNSCluster, query: Application.get_env(:code_lingo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CodeLingo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CodeLingo.Finch},
      # Start a worker by calling: CodeLingo.Worker.start_link(arg)
      # {CodeLingo.Worker, arg},
      # Start to serve requests, typically the last entry
      CodeLingoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CodeLingo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CodeLingoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
