defmodule Nagini do
  alias Nagini.World.Coord

  # This is designed to automatically register extension type numbers for more
  # modules you add to this list. However, as of this time it's easier to use
  # @derive for most structs, and Coord is special because a lot of bytes can be
  # saved by making an extension for it since coords are repeated so much.
  @ext_types [
    Coord
  ] |> Enum.with_index

  @modules_to_ext_types @ext_types |> Map.new

  @ext_types_to_modules @ext_types |> Enum.map(fn {module, type} ->
    {type, module}
  end) |> Map.new

  def module_to_ext_type(module) do
    Map.get(@modules_to_ext_types, module)
  end

  def ext_type_to_module(type) do
    Map.get(@ext_types_to_modules, type)
  end
end

defimpl Msgpax.Packer, for: [
  Nagini.World.Coord
] do
  def pack(%@for{} = struct) do
    data = @for.pack(struct)

    Nagini.module_to_ext_type(@for)
    |> Msgpax.Ext.new(data)
    |> Msgpax.Packer.pack()
  end
end

defmodule Nagini.World.Unpacker do
  @behaviour Msgpax.Ext.Unpacker

  def unpack(%Msgpax.Ext{type: type, data: data}) do
    module = Nagini.ext_type_to_module(type)
    {:ok, module.unpack(data)}
  end
end
