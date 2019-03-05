defmodule Nagini.Solver do
  require Logger
  import Nagini.Helper
  alias Nagini.World
  alias Nagini.World.{Board,Snake}

  @directions ~w(up down left right)

  def solve(%World{} = world, timeout), do: solve(world, timeout, 0, 0)

  def solve(%World{} = world, timeout, max_depth), do: solve(world, timeout, max_depth, 0)

  def solve(
    %World{game_id: game_id, turn: turn, you: you} = world,
    timeout,
    max_depth,
    depth
  ) do
    Logger.debug("Solving for turn #{turn} at depth #{depth} (future turn #{turn + depth}) for snake #{you.name} of ID #{you.id} in game #{game_id}")

    # Sorting by multiple fields has to happen in reverse order, so keep that in mind
    solutions = @directions
    |> Enum.map(&(analyze_move(world, &1)))
    |> sort_solutions_by_value

    if depth == 0 do
      Logger.debug("All solutions before considering futures are: #{inspect(solutions)}")
    end

    solutions_that_dont_kill_me = Enum.filter(solutions, &(&1.value.collision_avoidance > -1))
    not_dead_yet = Enum.any?(solutions_that_dont_kill_me)

    solutions = if depth < max_depth && not_dead_yet do
      solutions_with_futures_considered = solutions_that_dont_kill_me
      |> Enum.map(fn solution ->
        Logger.debug("Considering a future in which I move #{solution.direction} on the next turn")

        #did_eat = solution.value.food_seeking >= 1
        did_eat = nil

        future_world = world
        |> simulate_your_move(solution.direction, did_eat)
        |> simulate_opponent_moves()

        best_future_solution = solve(future_world, timeout, max_depth, depth + 1)

        revised_solution = if best_future_solution do
          %{
            direction: solution.direction,
            value: %{
              food_seeking: solution.value.food_seeking,
              #collision_avoidance: best_future_solution.value.collision_avoidance * solution.value.collision_avoidance
              #collision_avoidance: best_future_solution.value.collision_avoidance
              collision_avoidance: best_future_solution.value.collision_avoidance + solution.value.collision_avoidance
            }
          }
        else
          solution
        end

        revised_solution
      end)

      if depth == 0 do
        Logger.debug("All solutions after considering futures are: #{inspect(solutions_with_futures_considered)}")
      end

      solutions_with_futures_considered
    else
      solutions
    end

    solutions = solutions
    |> sort_solutions_by_value

    best_solution = case solutions do
      [solution | _] -> solution
      _ -> nil
    end

    if depth == 0 do
      best_move = case best_solution do
        nil ->
          Logger.debug("No solution found")
          nil
        _ ->
          Logger.debug("Best solution is: #{inspect(best_solution)}")
          best_solution[:direction]
      end

      best_move
    else
      best_solution
    end
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

  defp sort_solutions_by_value(solutions) do
    # NOTE: Sorting by multiple fields has to happen in reverse order
    solutions
    |> Enum.sort_by(&(&1.value.food_seeking))
    |> Enum.sort_by(&(&1.value.collision_avoidance))
    |> Enum.reverse
  end

  defp simulate_your_move(%World{you: you, board: %Board{snakes: snakes} = board} = world, direction, _did_eat) do
    new_head = step(you, direction)
    did_eat = food_at?(world, new_head)

    updated_body = [new_head | Enum.drop(you.body, -1)]
    updated_you = %Snake{you | body: updated_body}

    updated_snakes = Enum.map(snakes, fn snake ->
      if you.id == snake.id and you.body == snake.body do
        updated_you
      else
        snake
      end
    end)

    %World{world | you: updated_you, board: %Board{board | snakes: updated_snakes}}
  end

  defp simulate_opponent_moves(world) do
    world.board.snakes
    |> Enum.reject(&(&1.id == world.you.id && &1.body == world.you.body))
    |> Enum.reduce(world, &(simulate_opponent_move(&2, &1)))
  end

  defp simulate_opponent_move(%World{board: %Board{snakes: snakes} = board} = world, opponent) do
    direction = solve_for_opponent(world, opponent)
    new_head = step(opponent, direction)
    did_eat = food_at?(world, new_head)

    updated_body = [new_head | Enum.drop(opponent.body, -1)]

    updated_body = if did_eat do
      updated_body ++ [Enum.at(updated_body, -1)]
    else
      updated_body
    end

    updated_opponent = %Snake{opponent | body: updated_body}

    updated_snakes = Enum.map(snakes, fn snake ->
      if opponent.id == snake.id and opponent.body == snake.body do
        updated_opponent
      else
        snake
      end
    end)

    %World{world | board: %Board{board | snakes: updated_snakes}}
  end

  defp solve_for_opponent(world, opponent) do
    timeout = :infinity
    max_depth = 0
    opponent_world = %World{world | you: opponent}
    solve(opponent_world, timeout, max_depth)
  end
end
