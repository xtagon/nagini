defmodule Nagini.Analytics.Router do
  use Commanded.Commands.Router

  alias Nagini.Analytics.{
    Game,
    ReceiveGameStart,
    ReceiveGameMove,
    ReceiveGameEnd
  }

  dispatch [
    ReceiveGameStart,
    ReceiveGameMove,
    ReceiveGameEnd
  ], to: Game, identity: :game_id
end
