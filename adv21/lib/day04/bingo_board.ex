defmodule Adv01.Day04.BingoBoard do
  defstruct
    bingo_rows: [0,0,0,0,0],
    bingo_cols: [0,0,0,0,0],
    bingo_round: :no_bingo,
    not_drawn_sum: 0
end
