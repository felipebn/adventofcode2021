defmodule SubmarineTest do
  use ExUnit.Case
  alias Adv21.Day03.Diagnostics
  doctest Adv21.Day03.Diagnostics

  test "diagnose for example file returns 198" do
    pw = Diagnostics.power_consumption("test/day03/example.txt")
    IO.puts("PW consumption in example file #{pw} ")
    assert pw == 198
  end

  test "diagnose for input file" do
    pw = Diagnostics.power_consumption("lib/day03/input.txt")
    IO.puts("PW consumption in input file #{pw} ")
  end
end
