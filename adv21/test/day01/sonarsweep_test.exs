defmodule SonarSweepTest do
  use ExUnit.Case
  alias Adv21.Day01.SonarSweep
  doctest Adv21.Day01.SonarSweep

  test "sweep example file returns 7" do
    assert SonarSweep.sweep_file("test/day01/example.txt") == 7
  end
end
