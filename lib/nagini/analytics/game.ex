defmodule Nagini.Analytics.Game do
  @fields [:game_id]
  @derive [
    {Msgpax.Packer, fields: @fields},
    {Jason.Encoder, only: @fields}
  ]
  defstruct @fields

  alias Nagini.World
  alias Nagini.Analytics.{
    Game,
    ReceiveGameStart,
    ReceiveGameMove,
    ReceiveGameEnd,
    GameWorldUpdated,
    GameEnded
  }

  def new(%{"game_id" => game_id}) do
    %__MODULE__{game_id: game_id}
  end

  def execute(%Game{}, %ReceiveGameStart{game_id: game_id, world: %World{} = world}) do
    %GameWorldUpdated{game_id: game_id, world: world}
  end

  def execute(%Game{}, %ReceiveGameMove{game_id: game_id, world: %World{} = world}) do
    %GameWorldUpdated{game_id: game_id, world: world}
  end

  def execute(%Game{}, %ReceiveGameEnd{game_id: game_id, world: %World{} = world}) do
    [
      %GameWorldUpdated{game_id: game_id, world: world},
      %GameEnded{game_id: game_id}
    ]
  end

  def apply(%Game{game_id: nil} = game, %GameWorldUpdated{game_id: game_id}) do
    %Game{game | game_id: game_id}
  end

  def apply(%Game{} = game, %GameWorldUpdated{}), do: game

  def apply(%Game{} = game, %GameEnded{}), do: game
end
