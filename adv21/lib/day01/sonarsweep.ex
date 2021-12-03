defmodule Adv21.Day01.SonarSweep do

  def sweep_file(filename) do
    {_, increments} = File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.reduce({:none, 0}, fn item, result ->
      case result do
        {:none, 0} -> {item, 0}
        {last, count} when item > last ->
          IO.puts("increase #{last}, #{item} !")
          {item, count + 1}
        it -> it
      end
    end)
    |>IO.inspect()

    increments
  end

end
