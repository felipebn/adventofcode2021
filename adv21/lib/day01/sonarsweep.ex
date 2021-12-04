defmodule Adv21.Day01.SonarSweep do

  def sweep_file(filename) do
    {_, increments} = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({:none, 0}, fn item, result ->
      case result do
        {:none, 0} -> {item, 0}
        {last, count} when item > last -> {item, count + 1}
        {last, count} -> {item, count}
      end
    end)
    |>IO.inspect()

    increments
  end

  def sweep_file_windowed(filename) do
    # window values, previous window sum, increments
    {_, _, increments} = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({[], 0, 0}, fn item, result ->
      case result do
        {[a,b,c], previous_wsum, count} ->
          wsum = a+b+c
          if wsum > previous_wsum do
            {[b,c, item], wsum, count + 1}
          else
            {[b,c, item], wsum, count}
          end
        {window, previous_wsum, count} ->
          {window ++ [item], previous_wsum, count}
      end
    end)
    |>IO.inspect()

    increments
  end
end
