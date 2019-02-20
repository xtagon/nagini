defmodule NaginiWeb.Router do
  use NaginiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NaginiWeb do
    pipe_through :api

    post "/start", BattlesnakeController, :start
    post "/end", BattlesnakeController, :_end
    post "/ping", BattlesnakeController, :ping
    post "/move", BattlesnakeController, :move
  end
end
