defmodule Adv21.Day04.Bingo do

  def get_winner_board_score(filename) do
    bingo_rows = 0..4 |> Enum.map(fn _ -> [] end)
    bingo_cols = 0..4 |> Enum.map(fn _ -> [] end)

    {numbers, boards} = File.stream!(filename)
      |> Enum.reduce({:no_numbers, :no_winner_board, {bingo_rows, bingo_cols, 0, 0, -1}}, fn row , game ->
        case game do
          {:no_numbers, _, current_board} -> {
            row |> String.split(",") |> String.to_integer() |> Enum.reduce({%{}, 0}, fn n, {map, round} -> Map.put(map, n, round) end)
            :no_winner_board,
            current_board
          }
          {numbers, winner_board, current_board} ->
            {bingo_rows, bingo_cols, board_row, not_drawn_sum, max_drawn_round} = current_board
            if String.length(row) == 0 do
              # TODO board change, check bingo!
            else
              updated_board = reduce_board_row(row, current_board)
              {numbers, winner_board, updated_board}
            end
        end
      end)
  end

  defp reduce_board_row(row, current_board) do
    row
      |> String.split(" ")
      |> String.to_integer()
      |> Enum.reduce({bingo_rows, bingo_cols, not_drawn_sum, max_drawn_round, 0}, fn n, {r, c, s, mdr, board_col} ->
        draw_round = Map.get(numbers, n, -1)
        if draw_round > 0 do
          {
            List.replace_at(r, board_row, Enum.at(r, board_row) + 1),
            List.replace_at(c, board_col, Enum.at(r, board_col) + 1),
            s,
            max(mdr, draw_round), # keeps the max round, it will be the round when the board would win if ???
            board_col + 1
          }
        else
          {
            r,
            c,
            s + n, # increase the sum of non matched numbers
            mdr,
            board_col + 1
          }
        end
      end)
  end

end
