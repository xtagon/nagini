defmodule Nagini.World.Snake do
  @fields [:id, :name, :health, :body]
  @derive [
    {Msgpax.Packer, fields: @fields},
    {Jason.Encoder, only: @fields}
  ]
  defstruct @fields

  alias Nagini.World.Coord

  def new(%{
    "id" => id,
    "name" => name,
    "health" => health,
    "body" => body
  }) do
    %__MODULE__{
      id: id,
      name: name,
      health: health,
      body: Enum.map(body, &Coord.new/1)
    }
  end

  def head(%__MODULE__{body: [head | _]}), do: head
  def head(%__MODULE__{}), do: nil
end
