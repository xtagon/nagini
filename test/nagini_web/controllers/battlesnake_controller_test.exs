defmodule NaginiWeb.BattlesnakeControllerTest do
  use NaginiWeb.ConnCase

  @valid_color ~r/^#[0-9a-fA-F]{6}$/
  @valid_moves MapSet.new([nil | ~w(up down left right)])

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "start" do
    test "responds with a color", %{conn: conn} do
      conn = post(conn, "/start")

      %{"color" => color} = json_response(conn, 200)

      assert Regex.match?(@valid_color, color)
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
