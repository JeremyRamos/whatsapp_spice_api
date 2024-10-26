defmodule WhatsappSpiceApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WhatsappSpiceApiWeb.Telemetry,
      WhatsappSpiceApi.Repo,
      {DNSCluster, query: Application.get_env(:whatsapp_spice_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WhatsappSpiceApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WhatsappSpiceApi.Finch},
      # Start a worker by calling: WhatsappSpiceApi.Worker.start_link(arg)
      # {WhatsappSpiceApi.Worker, arg},
      # Start to serve requests, typically the last entry
      WhatsappSpiceApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WhatsappSpiceApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WhatsappSpiceApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
