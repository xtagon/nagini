defmodule Nagini.Solver do
  require Logger
  import Nagini.Helper

  @directions ~w(up down left right)

  def solve(input, _timeout) when %{} == input do
    # See https://github.com/battlesnakeio/roadmap/issues/258
    Logger.warn("Move API request contained empty params. Unable to solve for this turn.")

    # TODO: In the future, we might be able to solve for the move based on
    # pre-calculated predicted outcomes since the last move. But for now, just
    # give up
    nil
  end

  def solve(input, _timeout) do
    Logger.debug("Solving for turn #{input["turn"]} for snake #{input["you"]["name"]} in game #{input["game"]["id"]}")

    # Sorting by multiple fields has to happen in reverse order, so keep that in mind
    solutions = @directions
    |> Enum.map(&(analyze_move(input, &1)))
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

  defp analyze_move(input, move) do
    %{direction: move, value: value_of_move(input, move)}
  end

  defp value_of_move(input, move) do
    %{"you" => %{"body" => [head | _]}} = input

    target = step(head, move)

    collision_avoidance = if out_of_bounds?(input, target) do
      Logger.debug("Moving #{move} would result in wall collision")
      -1
    else
      value = value_of_collision_with_snake(input, target, move)
      Logger.debug("Value of moving #{move} is predicted to be #{inspect(value)}")
      value
    end

    %{
      collision_avoidance: collision_avoidance,
      food_seeking: probability_of_eating_food(input, target)
    }
  end
end
