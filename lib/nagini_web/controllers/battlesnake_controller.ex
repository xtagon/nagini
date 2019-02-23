defmodule NaginiWeb.BattlesnakeController do
  use NaginiWeb, :controller

  action_fallback NaginiWeb.FallbackController

  @config Application.get_env(:nagini, :battlesnake)

  def start(conn, _params), do: json(conn, %{color: color()})
  def _end(_conn, _params), do: :empty_ok
  def ping(_conn, _params), do: :empty_ok

  def move(conn, params) do
    move = Nagini.Solver.solve(params, timeout())
    json(conn, %{move: move})
  end

  defp color do
    @config[:color]
  end

  defp timeout do
    case @config[:timeout] do
      nil -> :infinity
      "infinity" -> :infinity
      value when is_binary(value) -> String.to_integer(value)
      value -> value
    end
  end
end
