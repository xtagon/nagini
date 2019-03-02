defmodule Nagini.Solver do
  require Logger
  import Nagini.Helper
  alias Nagini.World

  @directions ~w(up down left right)

  def solve(%World{game_id: game_id, turn: turn, you: you} = world, _timeout) do
    Logger.debug("Solving for turn #{turn} for snake #{you.name} of ID #{you.id} in game #{game_id}")

    # Sorting by multiple fields has to happen in reverse order, so keep that in mind
    solutions = @directions
    |> Enum.map(&(analyze_move(world, &1)))
    |> Enum.sort_by(&(&1.value.food_seeking))
    |> Enum.sort_by(&(&1.value.collision_avoidance))
    |> Enum.reverse

    Logger.debug("All solutions are: #{inspect(solutions)}")

    [best_solution | _] = solutions

    final_move = case best_solution do
      nil ->
        Logger.debug("No solution found")
        nil
      _ ->
        Logger.debug("Best solution is: #{inspect(best_solution)}")
        best_solution[:direction]
    end

    Logger.debug("Final move is: #{inspect(final_move)}")

    final_move
  end

  defp analyze_move(%World{} = world, direction) do
    %{direction: direction, value: value_of_move(world, direction)}
  end

  defp value_of_move(%World{you: you} = world, direction) do
    target = step(you, direction)

    collision_avoidance = if out_of_bounds?(world, target) do
      Logger.debug("Moving #{direction} would result in wall collision")
      -1
    else
      value = value_of_collision_with_snake(world, target, direction)
      Logger.debug("Value of moving #{direction} is predicted to be #{inspect(value)}")
      value
    end

    %{
      collision_avoidance: collision_avoidance,
      food_seeking: probability_of_eating_food(world, target)
    }
  end
end
