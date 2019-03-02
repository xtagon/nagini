defmodule NaginiWeb.BattlesnakeController do
  use NaginiWeb, :controller

  alias Nagini.{World,Analytics}

  action_fallback NaginiWeb.FallbackController

  @config Application.get_env(:nagini, :battlesnake)

  def start(conn, params) do
    world = World.new(params)
    Analytics.dispatch(:start, world)
    json(conn, %{
      color: @config[:color],
      headType: @config[:head_type],
      tailType: @config[:tail_type]
    })
  end

  def move(conn, params) do
    world = World.new(params)
    Analytics.dispatch(:move, world)
    move = Nagini.Solver.solve(world, timeout())
    json(conn, %{move: move})
  end

  def _end(_conn, params) do
    world = World.new(params)
    Analytics.dispatch(:end, world)
    :empty_ok
  end

  def ping(_conn, _params), do: :empty_ok

  defp timeout do
    case @config[:timeout] do
      nil -> :infinity
      "infinity" -> :infinity
      value when is_binary(value) -> String.to_integer(value)
      value -> value
    end
  end
end
