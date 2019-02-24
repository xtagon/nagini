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

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "start" do
    test "responds with a color", %{conn: conn} do
      conn = post(conn, "/start")

      snake_configuration =  json_response(conn, 200)

      color = snake_configuration["color"]
      headType = snake_configuration["headType"]
      tailType = snake_configuration["tailType"]

      assert Regex.match?(@valid_color, color)
      assert Enum.member?(@valid_head_types, headType)
      assert Enum.member?(@valid_tail_types, tailType)
    end
  end

  describe "end" do
    test "responds with empty JSON", %{conn: conn} do
      conn = post(conn, "/end")

      assert json_response(conn, 200) == %{}
    end
  end

  describe "ping" do
    test "responds with empty JSON", %{conn: conn} do
      conn = post(conn, "/ping")

      assert json_response(conn, 200) == %{}
    end
  end

  describe "move" do
    test "responds with a move", %{conn: conn} do
      conn = post(conn, "/move")

      %{"move" => move} = json_response(conn, 200)

      assert Enum.member?(@valid_moves, move)
    end
  end
end
