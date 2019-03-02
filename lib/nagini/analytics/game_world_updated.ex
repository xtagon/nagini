defmodule Nagini.Analytics.GameWorldUpdated do
  @fields [:game_id, :world]
  @derive [
    {Msgpax.Packer, fields: @fields},
    {Jason.Encoder, only: @fields}
  ]
  defstruct @fields

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
