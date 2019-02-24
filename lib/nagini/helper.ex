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

  def check_collision(you, target, other_snake) do
    you_are_other_snake = you["id"] == other_snake["id"] and you["body"] == other_snake["body"]

    direct_impact = other_snake["body"]
    |> Enum.reject(fn body_part ->
      you_are_other_snake and body_part == Enum.at(you["body"], -1)
    end)
    |> Enum.any?(&(&1 == target))

    other_snake_head = other_snake["body"] |> Enum.at(0)
    possible_head_to_head = (not you_are_other_snake) and adjascent?(other_snake_head, target)

    # TODO: Check to see if it's an impact with the tail, and predict whether
    # the tail will still be there.
    probability = if direct_impact do
      1
    else
      if possible_head_to_head do
        # Assume opponent has a 1 in 3 oppurtunity to collide head to head
        # TODO: Make a smarter prediction of what the other snake will choose
        1/3
      else
        0
      end
    end

    outcome = if direct_impact do
      :lose
    else
      if possible_head_to_head do
        if length(other_snake["body"]) == length(you["body"]) do
          :draw
        else
          if length(other_snake["body"]) < length(you["body"]) do
            :win
          else
            :lose
          end
        end
      else
        :free
      end
    end

    weight = case outcome do
      :win -> 1
      :draw -> -0.5
      :free -> 0
      :lose -> -1
    end

    value = weight * probability

    %{
      other_snake: %{name: other_snake["name"], id: other_snake["id"]},
      outcome: outcome,
      value: value,
      probability: probability
    }
  end

  def value_of_collision_with_snake(%{
    "board" => %{"snakes" => snakes},
    "you" => you
  }, target, direction) do
    collisions = snakes
    |> Enum.map(&(check_collision(you, target, &1)))
    |> Enum.reject(&(&1.outcome == :free))

    if length(collisions) > 0 do
      Logger.debug("Move to #{inspect(target)} would have the following collisions: #{inspect(collisions)}")

      average_value = Enum.reduce(collisions, 0, fn %{value: value}, sum ->
        sum + value
      end) / length(collisions)

      average_value
    else
      Logger.debug("Moving #{direction} to #{inspect(target)} would have no collisions.")
      0
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
    result = (a["x"] == b["x"] and abs(a["y"] - b["y"]) == 1) or (a["y"] == b["y"] and abs(a["x"] - b["x"]) == 1)
  end

  def head_of_snake(%{"body" => [head | _]}), do: head
end
