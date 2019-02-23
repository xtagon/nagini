defmodule Nagini.Helper do
  require Logger

  def step(%{"x" => x, "y" => y},    "up"), do: %{"x" => x, "y" => y - 1}
  def step(%{"x" => x, "y" => y},  "down"), do: %{"x" => x, "y" => y + 1}
  def step(%{"x" => x, "y" => y},  "left"), do: %{"x" => x - 1, "y" => y}
  def step(%{"x" => x, "y" => y}, "right"), do: %{"x" => x + 1, "y" => y}

  def out_of_bounds?(_state, %{"y" => y}) when y < 0, do: true
  def out_of_bounds?(_state, %{"x" => x}) when x < 0, do: true

  def out_of_bounds?(%{"board" => %{"height" => h}}, %{"y" => y})
  when y >= h, do: true

  def out_of_bounds?(%{"board" => %{"width" => w}}, %{"x" => x})
  when x >= w, do: true

  def out_of_bounds?(_state, _target), do: false

  def probability_of_collision_with_snake(%{
    "board" => %{"snakes" => snakes},
    "you" => you
  }, target) do
    definitely = snakes
    |> Enum.flat_map(&(&1["body"]))
    |> Enum.any?(&(&1 == target))

    if definitely do
      1
    else
      other_snakes = snakes
      |> Enum.reject(&(&1["id"] == you["id"] && &1["body"] == you["body"]))

      snakes_that_could_collide = other_snakes
      |> Enum.filter(&(adjascent?(&1, target)))

      number_of_snakes_that_could_collide = length(snakes_that_could_collide)

      Logger.debug("Number of snakes that could choose to collide: #{inspect(number_of_snakes_that_could_collide)}")

      snake_names = snakes_that_could_collide
      |> Enum.map(&(&1["name"]))

      Logger.debug("Snakes that could choose to collide: #{inspect(snake_names)}")

      case number_of_snakes_that_could_collide do
        0 ->
          Logger.debug("No snakes could collide")
          0
        _ ->
          # TODO: This should predict whether the snake is likely to move there, not just the blind chance
          # 1/3 just means that the snake must make one of 3 possible moves (assuming it wouldn't move into itself behind its head)
          Logger.debug("There is a 1 in 3 chance that another snake will collide")
          1/3
      end
    end
  end

  def probability_of_eating_food(%{
    "board" => %{"food" => food}
  }, target) do
    nearest_food_distance = food
    |> Enum.map(&(manhattan_distance(&1, target)))
    |> Enum.sort
    |> Enum.at(0)

    case nearest_food_distance do
      nil ->
        Logger.debug("There is no food on the board.")
        0
      0 ->
        Logger.debug("There is food directly adjascent to me.")
        1
      _ ->
        1 / nearest_food_distance
    end
  end

  def manhattan_distance(a, b) do
    x_distance = abs(a["x"] - b["x"])
    y_distance = abs(a["y"] - b["y"])
    x_distance + y_distance
  end

  def adjascent?(a, b) do
    (a["x"] == b["x"] and abs(a["y"] - b["y"]) == 1) or
    (a["y"] == b["y"] and abs(a["x"] - b["x"]) == 1)
  end
end
