defmodule NaginiWeb.BattlesnakeController do
  use NaginiWeb, :controller

  action_fallback NaginiWeb.FallbackController

  @color Application.get_env(:nagini, :battlesnake)[:color]

  def start(conn, _params), do: json(conn, %{color: @color})
  def _end(_conn, _params), do: :empty_ok
  def ping(_conn, _params), do: :empty_ok

  def move(conn, params) do
    move = Nagini.Strategy.decide(params)
    json(conn, %{move: move})
  end
end
