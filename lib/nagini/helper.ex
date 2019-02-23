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
      number_of_snakes_that_could_collide = snakes
      |> Enum.reject(&(&1["id"] == you["id"]))
      |> Enum.map(&(Enum.at(&1["body"], 0)))
      |> Enum.filter(&(adjascent?(&1, target)))
      |> length

      Logger.debug("Number of snakes that could choose to collide: #{inspect(number_of_snakes_that_could_collide)}")

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

  def adjascent?(a, b) do
    abs(a["x"] - b["x"]) == 1 or abs(a["y"] - b["y"]) == 1
  end
end
