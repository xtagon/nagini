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

  describe "2019-02-24 game 8517bd31-f462-41f9-afee-07dd39c3aed9 turn 9" do
    test "should move left because moving up has a 1/3 chance of fatal collision" do
      input = %{"board" => %{"food" => [%{"x" => 4, "y" => 3}, %{"x" => 3, "y" => 9}, %{"x" => 1, "y" => 6}, %{"x" => 0, "y" => 0}], "height" => 11, "snakes" => [%{"body" => [%{"x" => 7, "y" => 0}, %{"x" => 6, "y" => 0}, %{"x" => 5, "y" => 0}, %{"x" => 5, "y" => 1}], "health" => 95, "id" => "gs_PBQYqgFFRqYj9TH96Y3383Gc", "name" => "GregoryPotdevin / Mollusk v0"}, %{"body" => [%{"x" => 9, "y" => 8}, %{"x" => 9, "y" => 9}, %{"x" => 10, "y" => 9}], "health" => 91, "id" => "gs_b9X6wGW6JJt7CVPmqf6DCbVB", "name" => "matthewlehner / The Undersnaker pxu"}, %{"body" => [%{"x" => 5, "y" => 8}, %{"x" => 4, "y" => 8}, %{"x" => 3, "y" => 8}, %{"x" => 3, "y" => 7}], "health" => 96, "id" => "gs_x68Dbp3wK3TgDgG39bV4FMgX", "name" => "SamWheating / Arkantos"}, %{"body" => [%{"x" => 10, "y" => 3}, %{"x" => 10, "y" => 2}, %{"x" => 10, "y" => 1}], "health" => 91, "id" => "gs_WWxTfTMwQ6BRFjMMbfBMVx3D", "name" => "quinlanjager / Jager"}, %{"body" => [%{"x" => 7, "y" => 2}, %{"x" => 7, "y" => 3}, %{"x" => 7, "y" => 4}, %{"x" => 6, "y" => 4}], "health" => 93, "id" => "gs_hW4qpfGVQmkJPmjY67bKqFtS", "name" => "xtagon / Nagini"}, %{"body" => [%{"x" => 8, "y" => 1}, %{"x" => 8, "y" => 2}, %{"x" => 8, "y" => 3}], "health" => 91, "id" => "gs_KGrCHTJxpHW3tSMr6hGT4yTC", "name" => "niclaswue / Danger Nudel"}, %{"body" => [%{"x" => 7, "y" => 8}, %{"x" => 7, "y" => 9}, %{"x" => 6, "y" => 9}, %{"x" => 5, "y" => 9}], "health" => 95, "id" => "gs_TvD4mbtjCW8JqxHHhHCmJPFY", "name" => "codeallthethingz / Unnamed Snake"}, %{"body" => [%{"x" => 0, "y" => 3}, %{"x" => 0, "y" => 2}, %{"x" => 0, "y" => 1}], "health" => 91, "id" => "gs_73RxKDQTJF6YYJqp3TdRyDdd", "name" => "codeallthethingz / d1!"}], "width" => 11}, "game" => %{"id" => "8517bd31-f462-41f9-afee-07dd39c3aed9"}, "turn" => 9, "you" => %{"body" => [%{"x" => 7, "y" => 2}, %{"x" => 7, "y" => 3}, %{"x" => 7, "y" => 4}, %{"x" => 6, "y" => 4}], "health" => 93, "id" => "gs_hW4qpfGVQmkJPmjY67bKqFtS", "name" => "xtagon / Nagini"}}

      solution = solve(input, @move_timeout)
      assert solution == "left"
    end
  end

  describe "2019-02-24 game e96a91dd-306c-4fbd-a661-b6c90ba8e106 turn 210" do
    test "should move down because moving right has a 100% chance of trapping myself" do
      input = %{"board" => %{"food" => [%{"x" => 3, "y" => 6}, %{"x" => 1, "y" => 4}], "height" => 11, "snakes" => [%{"body" => [%{"x" => 9, "y" => 7}, %{"x" => 8, "y" => 7}, %{"x" => 7, "y" => 7}, %{"x" => 6, "y" => 7}, %{"x" => 5, "y" => 7}, %{"x" => 5, "y" => 6}, %{"x" => 6, "y" => 6}, %{"x" => 7, "y" => 6}, %{"x" => 8, "y" => 6}, %{"x" => 9, "y" => 6}, %{"x" => 9, "y" => 5}, %{"x" => 10, "y" => 5}, %{"x" => 10, "y" => 4}, %{"x" => 9, "y" => 4}, %{"x" => 8, "y" => 4}, %{"x" => 8, "y" => 5}, %{"x" => 7, "y" => 5}, %{"x" => 6, "y" => 5}, %{"x" => 5, "y" => 5}, %{"x" => 4, "y" => 5}, %{"x" => 4, "y" => 6}], "health" => 81, "id" => "gs_wR3pGg3kxmdP7GVqK9mvrVkD", "name" => "xtagon / Nagini"}, %{"body" => [%{"x" => 1, "y" => 1}, %{"x" => 2, "y" => 1}, %{"x" => 3, "y" => 1}, %{"x" => 4, "y" => 1}, %{"x" => 4, "y" => 2}, %{"x" => 5, "y" => 2}, %{"x" => 6, "y" => 2}, %{"x" => 7, "y" => 2}], "health" => 53, "id" => "gs_VrrbJFgGtJ87Q349XgHWHWFG", "name" => "griever989 / l|lIl|IlIIIl|lIIIllIlll||lIl 2"}], "width" => 11}, "game" => %{"id" => "e96a91dd-306c-4fbd-a661-b6c90ba8e106"}, "turn" => 210, "you" => %{"body" => [%{"x" => 9, "y" => 7}, %{"x" => 8, "y" => 7}, %{"x" => 7, "y" => 7}, %{"x" => 6, "y" => 7}, %{"x" => 5, "y" => 7}, %{"x" => 5, "y" => 6}, %{"x" => 6, "y" => 6}, %{"x" => 7, "y" => 6}, %{"x" => 8, "y" => 6}, %{"x" => 9, "y" => 6}, %{"x" => 9, "y" => 5}, %{"x" => 10, "y" => 5}, %{"x" => 10, "y" => 4}, %{"x" => 9, "y" => 4}, %{"x" => 8, "y" => 4}, %{"x" => 8, "y" => 5}, %{"x" => 7, "y" => 5}, %{"x" => 6, "y" => 5}, %{"x" => 5, "y" => 5}, %{"x" => 4, "y" => 5}, %{"x" => 4, "y" => 6}], "health" => 81, "id" => "gs_wR3pGg3kxmdP7GVqK9mvrVkD", "name" => "xtagon / Nagini"}}

      solution = solve(input, @move_timeout)
      assert solution == "down"
    end
  end
end
