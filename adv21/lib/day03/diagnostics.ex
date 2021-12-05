defmodule Adv21.Day03.Diagnostics do

  def power_consumption(filename) do
    bits_usage = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn bin -> String.split(bin, "", [trim: true]) end)
    |> Enum.reduce([[0,0],[0,0],[0,0],[0,0],[0,0]], fn bits, bits_usage ->
      {usage, _} = bits
        |> Enum.reduce({bits_usage, 0}, fn b, {bus, i} ->
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

    [gamma, epsilon] = bits_usage
      |> Enum.reduce({[],[]}, fn [z, o], {common_bits, least_bits} ->
        if z > o do
          {common_bits ++ [0], least_bits ++ [1]}
        else
          {common_bits ++ [1], least_bits ++ [0]}
        end
      end)
      |> Tuple.to_list()
      |> Enum.map(fn bits -> to_decimal(bits) end)

    IO.inspect(%{:gamma => gamma, :epsilon => epsilon})

    gamma * epsilon
  end

  defp to_decimal(bits) do
    IO.inspect({:bits, bits})
    {decimal, _} = bits
      |> Enum.reduce({0,length(bits) - 1}, fn b, {acc, i} ->
        {acc + (b * :math.pow(2, i)), i - 1}
      end)

    decimal
  end

end
