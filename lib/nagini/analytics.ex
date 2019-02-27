defmodule Nagini.Analytics do
  @environment Mix.env

  @release Mix.Project.config[:version]

  @revision(try do
    {hash, _} = System.cmd("git", ["rev-parse", "HEAD"])
    String.trim(hash)
  rescue
    _ -> nil
  end)

  @metadata %{
    "environment" => @environment,
    "release" => @release,
    "revision" => @revision
  }

  alias Nagini.Analytics.{
    ReceiveGameStart,
    ReceiveGameMove,
    ReceiveGameEnd,
    Router
  }

  def dispatch(route, %{"game" => %{"id" => game_id}} = params)
  when route in [:start, :move, :end] do
    command = build_command(route, game_id, params)

    # Async dispatch helps a lot to keep the response latency low!
    Task.async(fn -> Router.dispatch(command) end)

    :ok
  end

  defp build_command(:start, game_id, params) do
    %ReceiveGameStart{game_id: game_id, world: params}
  end

  defp build_command(:move, game_id, params) do
    %ReceiveGameMove{game_id: game_id, world: params}
  end

  defp build_command(:end, game_id, params) do
    %ReceiveGameEnd{game_id: game_id, world: params}
  end
end
