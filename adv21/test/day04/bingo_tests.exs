defmodule BingoTest do
  use ExUnit.Case
  alias Adv21.Day04.Bingo
  doctest Adv21.Day04.Bingo

  test "winner board returns 4512 in example file" do
    score = Bingo.get_winner_board_score("test/day03/example.txt")
    IO.puts("Winner board score in example file: #{score}")
    assert score == 4512
  end

  test "find winner board score in input file" do
    score = Bingo.get_winner_board_score("lib/day03/input.txt")
    IO.puts("Winner board score in input file: #{score}")
  end
end
