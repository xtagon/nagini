defmodule Nagini.Analytics.GameWorldUpdated do
  @derive Jason.Encoder
  defstruct [:game_id, :world]

  def to_map(%__MODULE__{game_id: game_id, world: world}) do
    %{"game_id" => game_id, "world" => world}
  end

  def from_map(%{"game_id" => game_id, "world" => world}) do
    %__MODULE__{game_id: game_id, world: world}
  end
end
