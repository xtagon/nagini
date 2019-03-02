defmodule Nagini.World do
  @fields [:game_id, :board, :turn, :you]
  @derive [
    {Msgpax.Packer, fields: @fields},
    {Jason.Encoder, only: @fields}
  ]
  defstruct @fields

  alias Nagini.World.{Board,Snake}

  def new(%{
    "game" => %{"id" => game_id},
    "board" => board,
    "turn" => turn,
    "you" => you
  }) do
    %__MODULE__{
      game_id: game_id,
      board: Board.new(board),
      turn: turn,
      you: Snake.new(you)
    }
  end

  def new(%{
    "game_id" => game_id,
    "board" => board,
    "turn" => turn,
    "you" => you
  }) do
    %__MODULE__{
      game_id: game_id,
      board: Board.new(board),
      turn: turn,
      you: Snake.new(you)
    }
  end
end
