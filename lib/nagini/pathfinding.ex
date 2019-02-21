defmodule Nagini.Pathfinding do
  def safe_move?(%{"you" => %{"body" => [head | _]}} = state, move) do
    not collision?(state, step(head, move))
  end

  def safe_move?(_state, _move), do: false

  def step(%{"x" => x, "y" => y},    "up"), do: %{"x" => x, "y" => y - 1}
  def step(%{"x" => x, "y" => y},  "down"), do: %{"x" => x, "y" => y + 1}
  def step(%{"x" => x, "y" => y},  "left"), do: %{"x" => x - 1, "y" => y}
  def step(%{"x" => x, "y" => y}, "right"), do: %{"x" => x + 1, "y" => y}

  def collision?(state, target) do
    out_of_bounds?(state, target) or collision_with_snake?(state, target)
  end

  def out_of_bounds?(_state, %{"y" => y}) when y < 0, do: true
  def out_of_bounds?(_state, %{"x" => x}) when x < 0, do: true

  def out_of_bounds?(%{"board" => %{"height" => h}}, %{"y" => y})
  when y >= h, do: true

  def out_of_bounds?(%{"board" => %{"width" => w}}, %{"x" => x})
  when x >= w, do: true

  def out_of_bounds?(_state, _target), do: false

  def collision_with_snake?(%{
    "board" => %{"snakes" => snakes},
    "you" => you
  }, target) do
    [you | snakes]
    |> Enum.flat_map(&(&1["body"]))
    |> Enum.any?(&(&1 == target))
  end
end
