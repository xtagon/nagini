defmodule Nagini.HelperTest do
  use ExUnit.Case, async: true
  import Nagini.Helper

  # Note that these input examples are real scenarios from live games.
  #
  # TODO: Move to fixture files instead of pasting inline.

  describe "probability of collision with snake" do
    test "returns 0 probability if I am the only snake that could move into that position" do
      input = %{"board" => %{"food" => [%{"x" => 2, "y" => 3}, %{"x" => 1, "y" => 8}, %{"x" => 5, "y" => 4}, %{"x" => 2, "y" => 18}], "height" => 19, "snakes" => [%{"body" => [%{"x" => 0, "y" => 8}, %{"x" => 0, "y" => 9}, %{"x" => 0, "y" => 10}, %{"x" => 1, "y" => 10}], "health" => 66, "id" => "gs_PJStYfh3ydhpS7PtTX4rFYpH", "name" => "xtagon/Nagini"}, %{"body" => [%{"x" => 2, "y" => 8}, %{"x" => 3, "y" => 8}, %{"x" => 3, "y" => 9}, %{"x" => 3, "y" => 10}, %{"x" => 3, "y" => 11}, %{"x" => 4, "y" => 11}], "health" => 83, "id" => "gs_vYWMMvXJHcPWYmpCd8cfCx3G", "name" => "SynthesizedSoul/D.Va Staging"}, %{"body" => [%{"x" => 2, "y" => 10}, %{"x" => 2, "y" => 11}, %{"x" => 2, "y" => 12}, %{"x" => 3, "y" => 12}, %{"x" => 4, "y" => 12}, %{"x" => 4, "y" => 13}], "health" => 95, "id" => "gs_Dx3GRTXgYrxFp3gg468GkjcX", "name" => "Adnaram/Snakaram"}], "width" => 19}, "game" => %{"id" => "8d748a2c-52a9-4efe-9ca9-ed6b00a9da45"}, "turn" => 50, "you" => %{"body" => [%{"x" => 0, "y" => 8}, %{"x" => 0, "y" => 9}, %{"x" => 0, "y" => 10}, %{"x" => 1, "y" => 10}], "health" => 66, "id" => "gs_PJStYfh3ydhpS7PtTX4rFYpH", "name" => "xtagon/Nagini"}}

      %{"you" => %{"body" => [head | _]}} = input
      target = step(head, "right")

      assert probability_of_collision_with_snake(input, target) == 0
    end
  end

  describe "probability of eating food" do
    test "returns a probability of 1 it is directly adjacent" do
      input = %{"board" => %{"food" => [%{"x" => 2, "y" => 10}, %{"x" => 0, "y" => 6}, %{"x" => 3, "y" => 6}, %{"x" => 3, "y" => 14}, %{"x" => 11, "y" => 3}], "height" => 19, "snakes" => [%{"body" => [%{"x" => 0, "y" => 5}, %{"x" => 0, "y" => 4}, %{"x" => 0, "y" => 3}], "health" => 95, "id" => "gs_9jCCRb34hk9kWS76mRbgGgfS", "name" => "xtagon/Nagini"}, %{"body" => [%{"x" => 17, "y" => 12}, %{"x" => 17, "y" => 13}, %{"x" => 17, "y" => 14}, %{"x" => 17, "y" => 15}], "health" => 98, "id" => "gs_bd4X6B4pGQK6wyVPYjVcVgBd", "name" => "eyilee/Alpha Snake"}, %{"body" => [%{"x" => 1, "y" => 14}, %{"x" => 0, "y" => 14}, %{"x" => 0, "y" => 15}, %{"x" => 0, "y" => 16}], "health" => 98, "id" => "gs_hYBTxfd3mtbvcbTFBXhSBFKb", "name" => "alecj1240/Alec's Snake"}, %{"body" => [%{"x" => 18, "y" => 5}, %{"x" => 18, "y" => 4}, %{"x" => 17, "y" => 4}, %{"x" => 17, "y" => 3}], "health" => 99, "id" => "gs_6D4QdrMCxWG79bYqBGBvgqcJ", "name" => "joram/jsnek"}, %{"body" => [%{"x" => 4, "y" => 1}, %{"x" => 5, "y" => 1}, %{"x" => 6, "y" => 1}], "health" => 95, "id" => "gs_jryrXQFRBwD3C6gMcVFw3Cf4", "name" => "hobbyquaker/hobbyquaker"}, %{"body" => [%{"x" => 4, "y" => 17}, %{"x" => 5, "y" => 17}, %{"x" => 6, "y" => 17}], "health" => 95, "id" => "gs_kFjBQFXKjbmCM4Jf9vBhKt9W", "name" => "RyanBarclay/striper_snek"}, %{"body" => [%{"x" => 1, "y" => 8}, %{"x" => 0, "y" => 8}, %{"x" => 0, "y" => 7}], "health" => 95, "id" => "gs_VHqmhCT9DwdgH9cG83rQkmmT", "name" => "battlesnake/Training Snake 8"}], "width" => 19}, "game" => %{"id" => "24173c8e-1d7d-49b1-be5b-9be8a50f2422"}, "turn" => 5, "you" => %{"body" => [%{"x" => 0, "y" => 5}, %{"x" => 0, "y" => 4}, %{"x" => 0, "y" => 3}], "health" => 95, "id" => "gs_9jCCRb34hk9kWS76mRbgGgfS", "name" => "xtagon/Nagini"}}

      %{"you" => %{"body" => [head | _]}} = input
      down = step(head, "down")
      right = step(head, "right")

      assert probability_of_eating_food(input, down) == 1
      assert probability_of_eating_food(input, right) == 0.5
    end

    test "does not have an arithmetic error" do
      input = %{
        "board" => %{
          "food" => [],
          "height" => 7,
          "snakes" => [
            %{
              "body" => [
                %{"x" => 4, "y" => 0},
                %{"x" => 3, "y" => 0},
                %{"x" => 3, "y" => 1},
                %{"x" => 2, "y" => 1},
                %{"x" => 2, "y" => 1}
              ],
              "health" => 100,
              "id" => "gs_yPxTtgDpkQ7fVG3kDJCRwM7D",
              "name" => "xtagon/Nagini"
            },
            %{
              "body" => [
                %{"x" => 6, "y" => 2},
                %{"x" => 6, "y" => 3},
                %{"x" => 5, "y" => 3},
                %{"x" => 5, "y" => 4}
              ],
              "health" => 98,
              "id" => "gs_FbSFWyYYTtf8CRH9R66pTkJ7",
              "name" => "DeclanMcIntosh/legless_lizzard"
            },
            %{
              "body" => [
                %{"x" => 1, "y" => 1},
                %{"x" => 1, "y" => 2},
                %{"x" => 1, "y" => 3}
              ],
              "health" => 96,
              "id" => "gs_CyVr89pGQRPSDScxHw74krrJ",
              "name" => "battlesnake/Training Snake 2"
            }
          ],
          "width" => 7
        },
        "game" => %{
          "id" => "697a5c2e-5f25-46ae-9d9f-59a32714ae07"
        },
        "turn" => 4,
        "you" => %{
          "body" => [
            %{"x" => 4, "y" => 0},
            %{"x" => 3, "y" => 0},
            %{"x" => 3, "y" => 1},
            %{"x" => 2, "y" => 1},
            %{"x" => 2, "y" => 1}
          ],
          "health" => 100,
          "id" => "gs_yPxTtgDpkQ7fVG3kDJCRwM7D",
          "name" => "xtagon/Nagini"
        }
      }

      %{"you" => %{"body" => [head | _]}} = input
      target = step(head, "right")

      assert probability_of_eating_food(input, target) == 0
    end
  end
end