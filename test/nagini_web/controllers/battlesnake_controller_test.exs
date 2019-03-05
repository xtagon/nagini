defmodule NaginiWeb.BattlesnakeControllerTest do
  use NaginiWeb.ConnCase

  @valid_color ~r/^#[0-9a-fA-F]{6}$/

  @valid_head_types MapSet.new([nil | ~w(
    beluga
    bendr
    dead
    evil
    fang
    pixel
    regular
    safe
    sand-worm
    shades
    silly
    smile
    tongue
  )])

  @valid_tail_types MapSet.new([nil | ~w(
    block-bum
    bolt
    curled
    fat-rattle
    freckled
    hook
    pixel
    regular
    round-bum
    sharp
    skinny
    small-rattle
  )])

  @valid_moves MapSet.new([nil | ~w(up down left right)])

  @params %{"board" => %{"food" => [%{"x" => 10, "y" => 0}], "height" => 11, "snakes" => [%{"body" => [%{"x" => 7, "y" => 6}, %{"x" => 8, "y" => 6}, %{"x" => 8, "y" => 5}, %{"x" => 8, "y" => 4}, %{"x" => 8, "y" => 3}, %{"x" => 7, "y" => 3}, %{"x" => 7, "y" => 4}], "health" => 70, "id" => "gs_v9tSx9b7XxC7mJmg6gTxkbDd", "name" => "joram/jsnek"}, %{"body" => [%{"x" => 6, "y" => 7}, %{"x" => 5, "y" => 7}, %{"x" => 5, "y" => 8}, %{"x" => 6, "y" => 8}, %{"x" => 7, "y" => 8}, %{"x" => 8, "y" => 8}, %{"x" => 9, "y" => 8}, %{"x" => 10, "y" => 8}, %{"x" => 10, "y" => 7}, %{"x" => 9, "y" => 7}, %{"x" => 9, "y" => 6}, %{"x" => 9, "y" => 5}, %{"x" => 9, "y" => 4}, %{"x" => 9, "y" => 3}, %{"x" => 10, "y" => 3}], "health" => 91, "id" => "gs_8wp6R93SD7Q4SgmKXJRtVM4H", "name" => "xtagon/Nagini"}], "width" => 11}, "game" => %{"id" => "7c966b43-b1d9-449b-af0e-c1046e887c40"}, "turn" => 97, "you" => %{"body" => [%{"x" => 6, "y" => 7}, %{"x" => 5, "y" => 7}, %{"x" => 5, "y" => 8}, %{"x" => 6, "y" => 8}, %{"x" => 7, "y" => 8}, %{"x" => 8, "y" => 8}, %{"x" => 9, "y" => 8}, %{"x" => 10, "y" => 8}, %{"x" => 10, "y" => 7}, %{"x" => 9, "y" => 7}, %{"x" => 9, "y" => 6}, %{"x" => 9, "y" => 5}, %{"x" => 9, "y" => 4}, %{"x" => 9, "y" => 3}, %{"x" => 10, "y" => 3}], "health" => 91, "id" => "gs_8wp6R93SD7Q4SgmKXJRtVM4H", "name" => "xtagon/Nagini"}}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "start" do
    test "responds with a color", %{conn: conn} do
      conn = post(conn, "/start", @params)

      snake_configuration =  json_response(conn, 200)

      color = snake_configuration["color"]
      headType = snake_configuration["headType"]
      tailType = snake_configuration["tailType"]

      assert color == nil || Regex.match?(@valid_color, color)
      assert Enum.member?(@valid_head_types, headType)
      assert Enum.member?(@valid_tail_types, tailType)
    end
  end

  describe "end" do
    test "responds with empty JSON", %{conn: conn} do
      conn = post(conn, "/end", @params)

      assert json_response(conn, 200) == %{}
    end
  end

  describe "ping" do
    test "responds with empty JSON", %{conn: conn} do
      conn = post(conn, "/ping", @params)

      assert json_response(conn, 200) == %{}
    end
  end

  describe "move" do
    test "responds with a move", %{conn: conn} do
      conn = post(conn, "/move", @params)

      %{"move" => move} = json_response(conn, 200)

      assert Enum.member?(@valid_moves, move)
    end
  end
end
