defmodule Nagini.Analytics.ReceiveGameMove do
  @enforce_keys [:game_id]
  defstruct [:game_id, :world]
end
