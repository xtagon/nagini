defmodule NaginiWeb.Router do
  use NaginiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NaginiWeb do
    pipe_through :api
  end
end
