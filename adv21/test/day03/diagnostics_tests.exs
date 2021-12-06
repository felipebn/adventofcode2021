defmodule SubmarineTest do
  use ExUnit.Case
  alias Adv21.Day03.Diagnostics
  doctest Adv21.Day03.Diagnostics

  test "diagnose PW for example file returns 198" do
    pw = Diagnostics.power_consumption("test/day03/example.txt")
    IO.puts("PW consumption in example file #{pw} ")
    assert pw == 198
  end

  test "diagnose PW for input file" do
    pw = Diagnostics.power_consumption("lib/day03/input.txt")
    IO.puts("PW consumption in input file #{pw} ")
  end

  test "diagnose LSR for example file returns 230" do
    lsr = Diagnostics.life_support_rating("test/day03/example.txt")
    IO.puts("Life support rating in example file #{lsr} ")
    assert lsr == 230
  end

  test "diagnose LSR for input file" do
    lsr = Diagnostics.life_support_rating("lib/day03/input.txt")
    IO.puts("Life support rating consumption in input file #{lsr} ")
  end
end
