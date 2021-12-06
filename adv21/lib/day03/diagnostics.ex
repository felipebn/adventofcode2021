defmodule Adv21.Day03.Diagnostics do

  def power_consumption(filename) do
    bits_usage = load_file_input_stream(filename)
    |> get_bits_usage()

    IO.inspect(bits_usage)

    [gamma, epsilon] = get_commons_and_least_commons(bits_usage)
      |> Tuple.to_list()
      |> Enum.map(fn bits -> to_decimal(bits) end)

    IO.inspect(%{:gamma => gamma, :epsilon => epsilon})

    gamma * epsilon
  end

  # Naive implementation, using a prefix tree would be better
  # rewriting the get_bits_usage and get_commons would also
  # create more efficient versions
  def life_support_rating(filename) do
    oxygen_bits = load_file_input_stream(filename)
      |> find_input(true, 0)

    IO.inspect({:oxygen, oxygen_bits})

    co2_bits = load_file_input_stream(filename)
      |> find_input(false, 0)

    to_decimal(oxygen_bits) * to_decimal(co2_bits)
  end

  defp find_input(input_list, use_common_bits, index) do
    case input_list do
      [input] -> input
      _ -> input_list |> filter_input(use_common_bits, index) |> find_input(use_common_bits, index + 1)
    end
  end

  defp filter_input(input_list, use_common_bits, index) do
    # TODO get_commons need to handle equal counts (e.g. [z=5, o=5], use 1 or 0 (common or least))
    {commons, least_commons} = input_list
      |> get_bits_usage()
      |> get_commons_and_least_commons(use_common_bits)

    mask = if use_common_bits do
      commons
    else
      least_commons
    end

    input_list
      |> Enum.filter(fn b -> Enum.at(b, index) == Enum.at(mask, index) end)
  end

  defp get_bits_usage(input_list) do
    input_list
      |> Enum.reduce([], fn bits, bits_usage ->
        # trick to make the bit usage count size match the input
        bits_usage = case bits_usage do
          [] -> 0..length(bits) - 1 |> Enum.map(fn _ -> [0,0] end)
          _ -> bits_usage
        end

        {usage, _} = bits
          |> Enum.reduce({bits_usage, 0}, fn b, {bus, i} ->
            [z, o] = Enum.at(bus, i)
            counts = case b do
              0 -> [z + 1, o]
              1 -> [z, o + 1]
            end
            {List.replace_at(bus, i, counts), i + 1}
          end)

        usage
      end)
  end

  def get_commons_and_least_commons(bits_usage, use_common_values \\ nil) do
    bits_usage
      |> Enum.reduce({[],[]}, fn [z, o], {common_bits, least_bits} ->
        cond do
          use_common_values && z == o -> {common_bits ++ [1], least_bits ++ [1]}
          use_common_values != nil && !use_common_values && z == o -> {common_bits ++ [0], least_bits ++ [0]}
          z > o -> {common_bits ++ [0], least_bits ++ [1]}
          true -> {common_bits ++ [1], least_bits ++ [0]}
        end
      end)
  end

  defp load_file_input_stream(filename) do
    File.stream!(filename)
      |> Enum.map(&String.trim/1)
      |> Enum.map(fn bin ->
        String.split(bin, "", [trim: true])
          |> Enum.map(&String.to_integer/1)
      end)
  end

  defp to_decimal(bits) do
    {decimal, _} = bits
      |> Enum.reduce({0,length(bits) - 1}, fn b, {acc, i} ->
        {acc + (b * :math.pow(2, i)), i - 1}
      end)

    decimal
  end

end
