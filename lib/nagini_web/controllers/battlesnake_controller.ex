defmodule NaginiWeb.BattlesnakeController do
  use NaginiWeb, :controller

  action_fallback NaginiWeb.FallbackController

  @color Application.get_env(:nagini, :battlesnake)[:color]

  def start(conn, _params), do: json(conn, %{color: @color})
  def _end(_conn, _params), do: :empty_ok
  def ping(_conn, _params), do: :empty_ok

  def move(conn, _params) do
    json(conn, %{move: "up"})
  end
end
