defmodule Nagini.Analytics.Game do
  @derive Jason.Encoder
  defstruct [:game_id, :last_seen_turn, :running]

  alias Nagini.Analytics.{
    Game,
    ReceiveGameStart,
    ReceiveGameMove,
    ReceiveGameEnd,
    GameStarted,
    GameWorldUpdated,
    GameEnded
  }

  # START
  # =====

  # When the game does not exist yet, start the game and update the game world
  def execute(%Game{game_id: nil, last_seen_turn: nil}, %ReceiveGameStart{game_id: game_id, world: world}) do
    [
      %GameStarted{game_id: game_id},
      %GameWorldUpdated{game_id: game_id, world: world}
    ]
  end

  # When the game already exists but it has already ended
  def execute(%Game{running: false}, %ReceiveGameStart{}), do: {:error, :game_already_ended}

  # When the game already exists but we haven't seen this turn number yet,
  # update the game world just in case we missed a request and it was retried or
  # something. Technically the Battlesnake API docs say that /start can receive
  # a turn number >= 0 so who knows
  def execute(%Game{last_seen_turn: last_seen_turn}, %ReceiveGameStart{game_id: game_id, world: %{"turn" => turn} = world})
  when turn > last_seen_turn do
    %GameWorldUpdated{game_id: game_id, world: world}
  end

  # When the game already exists but we have seen this turn number already
  def execute(%Game{}, %ReceiveGameStart{}), do: {:error, :turn_already_played}

  # MOVE
  # ====

  # When the game does not exist yet, start the game and update the game world
  # just in case we missed the initial /start request
  def execute(%Game{game_id: nil, last_seen_turn: nil}, %ReceiveGameMove{game_id: game_id, world: world}) do
    [
      %GameStarted{game_id: game_id},
      %GameWorldUpdated{game_id: game_id, world: world}
    ]
  end

  # When the game already exists but it has already ended
  def execute(%Game{running: false}, %ReceiveGameMove{}), do: {:error, :game_already_ended}

  # When the game already exists and we haven't seen this turn number yet,
  # update the game world
  def execute(%Game{last_seen_turn: last_seen_turn}, %ReceiveGameMove{game_id: game_id, world: %{"turn" => turn} = world})
  when turn > last_seen_turn do
    %GameWorldUpdated{game_id: game_id, world: world}
  end

  # When the game already exists but we have seen this turn number already
  def execute(%Game{}, %ReceiveGameMove{}), do: {:error, :turn_already_played}

  # END
  # ===

  # When the game does not exist yet, start the game and update the game world
  # and end the game just in case we missed the initial /start request and all
  # the /move requests and somehow the game ended before any of those went
  # through.
  def execute(%Game{game_id: nil, last_seen_turn: nil}, %ReceiveGameEnd{game_id: game_id, world: world}) do
    [
      %GameStarted{game_id: game_id},
      %GameWorldUpdated{game_id: game_id, world: world},
      %GameEnded{game_id: game_id}
    ]
  end

  # When the game already exists but it has already ended
  def execute(%Game{}, %ReceiveGameEnd{}), do: {:error, :game_already_ended}

  # When the game already exists and is still running and we haven't seen this
  # turn number yet, update the game world and end the game
  def execute(%Game{last_seen_turn: last_seen_turn}, %ReceiveGameEnd{game_id: game_id, world: %{"turn" => turn} = world})
  when turn > last_seen_turn do
    [
      %GameWorldUpdated{game_id: game_id, world: world},
      %GameEnded{game_id: game_id}
    ]
  end

  # When the game already exists and is still running but we have seen this turn
  # number already, end the game but do not update the game world again
  def execute(%Game{}, %ReceiveGameMove{game_id: game_id}) do
    %GameEnded{game_id: game_id}
  end

  # APPLY
  # -----

  def apply(%Game{} = game, %GameStarted{game_id: game_id}) do
    %Game{game | game_id: game_id, running: true}
  end

  def apply(%Game{} = game, %GameWorldUpdated{world: %{"turn" => turn}}) do
    %Game{game | last_seen_turn: turn}
  end

  def apply(%Game{} = game, %GameEnded{}) do
    %Game{game | running: false}
  end
end
