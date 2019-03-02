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

  alias Nagini.World
  alias Nagini.Analytics.{
    ReceiveGameStart,
    ReceiveGameMove,
    ReceiveGameEnd,
    Router
  }

  def dispatch(action, %World{game_id: game_id} = world)
  when action in [:start, :move, :end] do
    command = build_command(action, game_id, world)

    # Async dispatch helps a lot to keep the response latency low!
    #
    # TODO: Register a GenServer as a worker and cast to that that instead of
    # creating task per command dispatch
    Task.async(fn ->
      Router.dispatch(command, metadata: @metadata)
    end)

    :ok
  end

  defp build_command(:start, game_id, world) do
    %ReceiveGameStart{game_id: game_id, world: world}
  end

  defp build_command(:move, game_id, world) do
    %ReceiveGameMove{game_id: game_id, world: world}
  end

  defp build_command(:end, game_id, world) do
    %ReceiveGameEnd{game_id: game_id, world: world}
  end
end
