defmodule NaginiWeb.BattlesnakeController do
  use NaginiWeb, :controller

  alias Nagini.{World,Analytics}

  action_fallback NaginiWeb.FallbackController

  def start(conn, params) do
    world = World.new(params)
    Analytics.dispatch(:start, world)
    json(conn, %{
      color: color(),
      headType: head_type(),
      tailType: tail_type()
    })
  end

  def move(conn, params) do
    world = World.new(params)
    Analytics.dispatch(:move, world)
    move = Nagini.Solver.solve(world, timeout(), max_depth())
    json(conn, %{move: move})
  end

  def _end(_conn, params) do
    world = World.new(params)
    Analytics.dispatch(:end, world)
    :empty_ok
  end

  def ping(_conn, _params), do: :empty_ok

  defp color do
    System.get_env("SNAKE_COLOR")
  end

  defp head_type do
    System.get_env("SNAKE_HEAD")
  end

  defp tail_type do
    System.get_env("SNAKE_TAIL")
  end

  defp timeout do
    case System.get_env("SOLVER_TIMEOUT") do
      nil -> :infinity
      "infinity" -> :infinity
      value when is_binary(value) -> String.to_integer(value)
      value -> value
    end
  end

  defp max_depth do
    case System.get_env("SOLVER_DEPTH") do
      nil -> 0
      value when is_binary(value) -> String.to_integer(value)
      value -> value
    end
  end
end
