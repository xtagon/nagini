defmodule Nagini.Analytics.MsgpaxSerializer do
  def serialize(term) do
    Msgpax.pack!(term, iodata: false)
  end

  def deserialize(binary, config \\ []) do
    unpacked = binary
    |> Msgpax.unpack!(ext: Nagini.World.Unpacker)

    case config[:type] do
      nil -> unpacked
      type -> apply(String.to_existing_atom(type), :new, [unpacked])
    end
  end
end
