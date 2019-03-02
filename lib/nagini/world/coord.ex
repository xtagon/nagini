defmodule Nagini.World.Coord do
  @fields [:x, :y]
  @derive [{Jason.Encoder, only: @fields}]
  defstruct @fields

  def new(%{"x" => x, "y" => y}) do
    %__MODULE__{x: x, y: y}
  end

  def new(%__MODULE__{} = coord), do: coord

  def pack(%__MODULE__{x: x, y: y}) do
    <<x>> <> <<y>>
  end

  def unpack(<<x>> <> <<y>>) do
    %__MODULE__{x: x, y: y}
  end
end
