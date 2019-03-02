defmodule Nagini.Analytics.GameEnded do
  @fields [:game_id]
  @derive [
    {Msgpax.Packer, fields: @fields},
    {Jason.Encoder, only: @fields}
  ]
  defstruct @fields

  def new(%{"game_id" => game_id}) do
    %__MODULE__{game_id: game_id}
  end
end
