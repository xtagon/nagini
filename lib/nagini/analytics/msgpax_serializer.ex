defmodule Nagini.Analytics.MsgpaxSerializer do
  def serialize(term) do
    case term do
      %name{} -> apply(name, :to_map, [term])
      map -> map
    end
    |> Msgpax.pack!(iodata: false)
  end

  def deserialize(binary, config \\ []) do
    unpacked = Msgpax.unpack!(binary)

    case config[:type] do
      nil -> unpacked
      type -> apply(String.to_existing_atom(type), :from_map, [unpacked])
    end
  end
end
