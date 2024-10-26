defmodule WhatsappSpiceApiWeb.WebhooksController do
  use WhatsappSpiceApiWeb, :controller

  def order_complete(conn, _params) do
    data = %{ message: "Hello, world!", status: "success" }
    json(conn, data)
  end
end
