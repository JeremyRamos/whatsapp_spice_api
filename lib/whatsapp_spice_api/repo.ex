defmodule WhatsappSpiceApi.Repo do
  use Ecto.Repo,
    otp_app: :whatsapp_spice_api,
    adapter: Ecto.Adapters.Postgres
end
