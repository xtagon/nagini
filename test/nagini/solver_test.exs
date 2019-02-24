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

  describe "2019-02-23 game 8a0c8ac1-4a29-42b6-b61c-2439aca7c675 turn 24" do
    test "should move down because all other moves result in a collision but down doesn't because the tail will move away" do
      input = %{"board" => %{"food" => [%{"x" => 7, "y" => 9}, %{"x" => 7, "y" => 10}, %{"x" => 9, "y" => 7}], "height" => 11, "snakes" => [%{"body" => [%{"x" => 0, "y" => 10}, %{"x" => 1, "y" => 10}, %{"x" => 1, "y" => 9}, %{"x" => 0, "y" => 9}], "health" => 79, "id" => "gs_DhYtQhcYhxTRThbdb9CSgbgK", "name" => "codeallthethingz / JamJan"}, %{"body" => [%{"x" => 4, "y" => 10}, %{"x" => 3, "y" => 10}, %{"x" => 2, "y" => 10}], "health" => 76, "id" => "gs_GjVPtyw6SDg6MWjG9q3kf7fV", "name" => "PhoenixProgrammer / PhoenixProgramming"}, %{"body" => [%{"x" => 3, "y" => 7}, %{"x" => 2, "y" => 7}, %{"x" => 2, "y" => 8}, %{"x" => 3, "y" => 8}], "health" => 77, "id" => "gs_f7wXtgQWDXVbHd8XBjqxY8BX", "name" => "xtagon / Nagini"}, %{"body" => [%{"x" => 0, "y" => 6}, %{"x" => 0, "y" => 5}, %{"x" => 0, "y" => 4}, %{"x" => 1, "y" => 4}, %{"x" => 1, "y" => 5}, %{"x" => 2, "y" => 5}, %{"x" => 2, "y" => 6}], "health" => 92, "id" => "gs_FwCRPcWFYDJJWhhCvDFSwTMS", "name" => "RyanBarclay / striper_snek"}, %{"body" => [%{"x" => 4, "y" => 6}, %{"x" => 4, "y" => 5}, %{"x" => 3, "y" => 5}, %{"x" => 3, "y" => 4}, %{"x" => 4, "y" => 4}], "health" => 90, "id" => "gs_3jMTSJGXRbtwCb9Y3wqdcC7S", "name" => "codeallthethingz / d1!"}], "width" => 11}, "game" => %{"id" => "8a0c8ac1-4a29-42b6-b61c-2439aca7c675"}, "turn" => 24, "you" => %{"body" => [%{"x" => 3, "y" => 7}, %{"x" => 2, "y" => 7}, %{"x" => 2, "y" => 8}, %{"x" => 3, "y" => 8}], "health" => 77, "id" => "gs_f7wXtgQWDXVbHd8XBjqxY8BX", "name" => "xtagon / Nagini"}}

      solution = solve(input, @move_timeout)
      assert solution == "down"
    end
  end
end
