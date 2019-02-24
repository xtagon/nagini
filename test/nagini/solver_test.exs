defmodule Nagini.SolverTest do
  use ExUnit.Case, async: true
  import Nagini.Solver

  @move_timeout :infinity

  # Note that these input examples are real scenarios from live games.
  #
  # TODO: Move to fixture files instead of pasting inline.

  describe "2019-02-23 game 7c966b43-b1d9-449b-af0e-c1046e887c40 turn 97" do
    test "should move up or right because either one has a 1/3 chance of winning a head on collision" do
      input = %{"board" => %{"food" => [%{"x" => 10, "y" => 0}], "height" => 11, "snakes" => [%{"body" => [%{"x" => 7, "y" => 6}, %{"x" => 8, "y" => 6}, %{"x" => 8, "y" => 5}, %{"x" => 8, "y" => 4}, %{"x" => 8, "y" => 3}, %{"x" => 7, "y" => 3}, %{"x" => 7, "y" => 4}], "health" => 70, "id" => "gs_v9tSx9b7XxC7mJmg6gTxkbDd", "name" => "joram/jsnek"}, %{"body" => [%{"x" => 6, "y" => 7}, %{"x" => 5, "y" => 7}, %{"x" => 5, "y" => 8}, %{"x" => 6, "y" => 8}, %{"x" => 7, "y" => 8}, %{"x" => 8, "y" => 8}, %{"x" => 9, "y" => 8}, %{"x" => 10, "y" => 8}, %{"x" => 10, "y" => 7}, %{"x" => 9, "y" => 7}, %{"x" => 9, "y" => 6}, %{"x" => 9, "y" => 5}, %{"x" => 9, "y" => 4}, %{"x" => 9, "y" => 3}, %{"x" => 10, "y" => 3}], "health" => 91, "id" => "gs_8wp6R93SD7Q4SgmKXJRtVM4H", "name" => "xtagon/Nagini"}], "width" => 11}, "game" => %{"id" => "7c966b43-b1d9-449b-af0e-c1046e887c40"}, "turn" => 97, "you" => %{"body" => [%{"x" => 6, "y" => 7}, %{"x" => 5, "y" => 7}, %{"x" => 5, "y" => 8}, %{"x" => 6, "y" => 8}, %{"x" => 7, "y" => 8}, %{"x" => 8, "y" => 8}, %{"x" => 9, "y" => 8}, %{"x" => 10, "y" => 8}, %{"x" => 10, "y" => 7}, %{"x" => 9, "y" => 7}, %{"x" => 9, "y" => 6}, %{"x" => 9, "y" => 5}, %{"x" => 9, "y" => 4}, %{"x" => 9, "y" => 3}, %{"x" => 10, "y" => 3}], "health" => 91, "id" => "gs_8wp6R93SD7Q4SgmKXJRtVM4H", "name" => "xtagon/Nagini"}}

      solution = solve(input, @move_timeout)
      assert solution == "up" || solution == "right"
    end
  end
end
