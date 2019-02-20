defmodule NaginiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use NaginiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(NaginiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, :empty_ok) do
    json(conn, %{})
  end
end
