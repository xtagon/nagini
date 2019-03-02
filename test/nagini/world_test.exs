defmodule Nagini.WorldTest do
  use ExUnit.Case, async: true

  alias Nagini.World
  alias Nagini.World.Snake

  test "implements msgpax pack and unpack for serialization" do
    # 2019-02-23 game 8a0c8ac1-4a29-42b6-b61c-2439aca7c675 turn 24
    # (chosen arbitrarily)
    world = %{"board" => %{"food" => [%{"x" => 7, "y" => 9}, %{"x" => 7, "y" => 10}, %{"x" => 9, "y" => 7}], "height" => 11, "snakes" => [%{"body" => [%{"x" => 0, "y" => 10}, %{"x" => 1, "y" => 10}, %{"x" => 1, "y" => 9}, %{"x" => 0, "y" => 9}], "health" => 79, "id" => "gs_DhYtQhcYhxTRThbdb9CSgbgK", "name" => "codeallthethingz / JamJan"}, %{"body" => [%{"x" => 4, "y" => 10}, %{"x" => 3, "y" => 10}, %{"x" => 2, "y" => 10}], "health" => 76, "id" => "gs_GjVPtyw6SDg6MWjG9q3kf7fV", "name" => "PhoenixProgrammer / PhoenixProgramming"}, %{"body" => [%{"x" => 3, "y" => 7}, %{"x" => 2, "y" => 7}, %{"x" => 2, "y" => 8}, %{"x" => 3, "y" => 8}], "health" => 77, "id" => "gs_f7wXtgQWDXVbHd8XBjqxY8BX", "name" => "xtagon / Nagini"}, %{"body" => [%{"x" => 0, "y" => 6}, %{"x" => 0, "y" => 5}, %{"x" => 0, "y" => 4}, %{"x" => 1, "y" => 4}, %{"x" => 1, "y" => 5}, %{"x" => 2, "y" => 5}, %{"x" => 2, "y" => 6}], "health" => 92, "id" => "gs_FwCRPcWFYDJJWhhCvDFSwTMS", "name" => "RyanBarclay / striper_snek"}, %{"body" => [%{"x" => 4, "y" => 6}, %{"x" => 4, "y" => 5}, %{"x" => 3, "y" => 5}, %{"x" => 3, "y" => 4}, %{"x" => 4, "y" => 4}], "health" => 90, "id" => "gs_3jMTSJGXRbtwCb9Y3wqdcC7S", "name" => "codeallthethingz / d1!"}], "width" => 11}, "game" => %{"id" => "8a0c8ac1-4a29-42b6-b61c-2439aca7c675"}, "turn" => 24, "you" => %{"body" => [%{"x" => 3, "y" => 7}, %{"x" => 2, "y" => 7}, %{"x" => 2, "y" => 8}, %{"x" => 3, "y" => 8}], "health" => 77, "id" => "gs_f7wXtgQWDXVbHd8XBjqxY8BX", "name" => "xtagon / Nagini"}}
    |> World.new

    coord = world.you.body |> Enum.at(0)
    coord_packed = coord |> Msgpax.pack!(iodata: false)
    coord_packed_size = coord_packed |> byte_size
    coord_unpacked = coord_packed |> Msgpax.unpack!(ext: Nagini.World.Unpacker)

    assert coord_unpacked == coord

    snake = world.you
    snake_packed = snake |> Msgpax.pack!(iodata: false)
    snake_packed_size = snake_packed |> byte_size
    snake_unpacked = snake_packed |> Msgpax.unpack!(ext: Nagini.World.Unpacker) |> Snake.new

    assert snake_unpacked == snake

    world_packed = world |> Msgpax.pack!(iodata: false)
    world_packed_size = world_packed |> byte_size
    world_unpacked = world_packed |> Msgpax.unpack!(ext: Nagini.World.Unpacker) |> World.new

    assert world_unpacked == world

    # These were the sizes when this serializer was first implemented. I added
    # them here so that if it changes it'll break the test and we'll know.
    assert coord_packed_size == 4
    assert snake_packed_size == 83
    assert world_packed_size == 667
  end
end
