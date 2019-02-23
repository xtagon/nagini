defmodule Nagini.HelperTest do
  use ExUnit.Case, async: true
  import Nagini.Helper

  describe "probability of collision with snake" do
    test "returns 0 probability if I am the only snake that could move into that position" do
      input = %{"board" => %{"food" => [%{"x" => 2, "y" => 3}, %{"x" => 1, "y" => 8}, %{"x" => 5, "y" => 4}, %{"x" => 2, "y" => 18}], "height" => 19, "snakes" => [%{"body" => [%{"x" => 0, "y" => 8}, %{"x" => 0, "y" => 9}, %{"x" => 0, "y" => 10}, %{"x" => 1, "y" => 10}], "health" => 66, "id" => "gs_PJStYfh3ydhpS7PtTX4rFYpH", "name" => "xtagon/Nagini"}, %{"body" => [%{"x" => 2, "y" => 8}, %{"x" => 3, "y" => 8}, %{"x" => 3, "y" => 9}, %{"x" => 3, "y" => 10}, %{"x" => 3, "y" => 11}, %{"x" => 4, "y" => 11}], "health" => 83, "id" => "gs_vYWMMvXJHcPWYmpCd8cfCx3G", "name" => "SynthesizedSoul/D.Va Staging"}, %{"body" => [%{"x" => 2, "y" => 10}, %{"x" => 2, "y" => 11}, %{"x" => 2, "y" => 12}, %{"x" => 3, "y" => 12}, %{"x" => 4, "y" => 12}, %{"x" => 4, "y" => 13}], "health" => 95, "id" => "gs_Dx3GRTXgYrxFp3gg468GkjcX", "name" => "Adnaram/Snakaram"}], "width" => 19}, "game" => %{"id" => "8d748a2c-52a9-4efe-9ca9-ed6b00a9da45"}, "turn" => 50, "you" => %{"body" => [%{"x" => 0, "y" => 8}, %{"x" => 0, "y" => 9}, %{"x" => 0, "y" => 10}, %{"x" => 1, "y" => 10}], "health" => 66, "id" => "gs_PJStYfh3ydhpS7PtTX4rFYpH", "name" => "xtagon/Nagini"}}

      %{"you" => %{"body" => [head | _]}} = input
      target = step(head, "right")

      assert probability_of_collision_with_snake(input, target) == 0
    end
  end
end
