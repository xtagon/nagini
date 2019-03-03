defmodule NaginiWeb.Router do
  use NaginiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_secure_browser_headers
    plug BasicAuth, use_config: {:nagini, :basic_auth}
  end

  scope "/admin", NaginiWeb do
    pipe_through :browser

    get "/*path", AdminController, :index
  end

  scope "/", NaginiWeb do
    pipe_through :api

    post "/start", BattlesnakeController, :start
    post "/end", BattlesnakeController, :_end
    post "/ping", BattlesnakeController, :ping
    post "/move", BattlesnakeController, :move
  end
end
