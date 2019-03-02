defmodule Nagini.Analytics.ReceiveGameMove do
  @enforce_keys [:game_id]
  defstruct [:game_id, :world]

  alias Nagini.World

  def new(%{
    "game_id" => game_id,
    "world" => world
  }) do
    %__MODULE__{
      game_id: game_id,
      world: World.new(world)
    }
  end
end
