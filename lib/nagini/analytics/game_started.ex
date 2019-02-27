defmodule Nagini.Analytics.GameStarted do
  @derive Jason.Encoder
  defstruct [:game_id]

  def to_map(%__MODULE__{game_id: game_id}) do
    %{"game_id" => game_id}
  end

  def from_map(%{"game_id" => game_id}) do
    %__MODULE__{game_id: game_id}
  end
end
