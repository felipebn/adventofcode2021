defmodule Adv21.Day03.Diagnostics do

  def power_consumption(filename) do
    bits_usage = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn bin -> String.split(bin, "", [trim: true]) end)
    |> Enum.reduce([[0,0],[0,0],[0,0],[0,0],[0,0]], fn bits, bits_usage ->
      {usage, _} = bits
        |> Enum.reduce({bits_usage, 0}, fn b, {bus, i} ->
          IO.inspect(bus)
          [z, o] = Enum.at(bus, i)
          counts = case b do
            "0" -> [z + 1, o]
            "1" -> [z, o + 1]
          end
          {List.replace_at(bus, i, counts), i + 1}
        end)

      usage
    end)

    IO.inspect(bits_usage)

    bits_usage
      |> Enum.map(fn [z, o] ->
        if z > o do
          0
        else
          1
        end
      end)

    0
  end

end
