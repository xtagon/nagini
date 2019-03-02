defmodule Nagini.World.Board do
  @fields [:width, :height, :snakes, :food]
  @derive [
    {Msgpax.Packer, fields: @fields},
    {Jason.Encoder, only: @fields}
  ]
  defstruct @fields

  alias Nagini.World.{Snake,Coord}

  def new(%{
    "width" => width,
    "height" => height,
    "food" => food,
    "snakes" => snakes
  }) do
    %__MODULE__{
      width: width,
      height: height,
      snakes: Enum.map(snakes, &Snake.new/1),
      food: Enum.map(food, &Coord.new/1)
    }
  end
end
