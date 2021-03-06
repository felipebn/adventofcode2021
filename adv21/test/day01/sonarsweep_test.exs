defmodule SonarSweepTest do
  use ExUnit.Case
  alias Adv21.Day01.SonarSweep
  doctest Adv21.Day01.SonarSweep

  test "sweep example file returns 7" do
    increase_count = SonarSweep.sweep_file("test/day01/example.txt")
    IO.puts("Increase count on Example file #{increase_count} ")
    assert increase_count == 7
  end

  test "sliding window sweep example file returns 5" do
    increase_count = SonarSweep.sweep_file_windowed("test/day01/example.txt")
    IO.puts("(SW) Increase count on Example file #{increase_count} ")
    assert increase_count == 5
  end

  test "sweep input file" do
    increase_count = SonarSweep.sweep_file("lib/day01/input.txt")
    IO.puts("Increase count on Input file #{increase_count} ")
    assert increase_count > 0
  end

  test "sliding window sweep input file" do
    increase_count = SonarSweep.sweep_file_windowed("lib/day01/input.txt")
    IO.puts("(SW) Increase count on Input file #{increase_count} ")
    assert increase_count > 0
  end
end
