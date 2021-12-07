defmodule Adv21.Day04.Bingo do

  alias Adv21.Day04.BingoBoard

  def get_winner_board_score(filename) do
    initial_board_state = {0, %BingoBoard{}}
    {numbers, boards} = File.stream!(filename)
      |> Enum.reduce({:no_numbers, :no_winner_board, initial_board_state}, fn row , game ->
        case game do
          {:no_numbers, _, current_board} -> {
            row |> String.split(",") |> String.to_integer() |> Enum.reduce({%{}, 0}, fn n, {map, round} -> Map.put(map, n, round) end)
            :no_winner_board,
            current_board
          }
          {numbers, winner_board, {_, board}} ->
            if String.length(row) == 0 do
              best_board = get_winner_board(winner_board, board)
              {numbers, best_board, initial_board_state}
            else
              updated_board = reduce_board_row(row, current_board)
              {numbers, winner_board, updated_board}
            end
        end
      end)
  end

  defp reduce_board_row(row, {i, board}) do
    row
      |> String.split(" ")
      |> String.to_integer()
      |> Enum.reduce({0, b}, fn n, {j, b} ->
        draw_round = Map.get(numbers, n, -1)
        if draw_round > 0 do
          # fix tis
          updated_board = %BingoBoard{b |
            bingo_rows: List.replace_at(r, b.bingo_rows, Enum.at(r, b.bingo_rows) + 1),
            bingo_cols: List.replace_at(r, b.bingo_cols, Enum.at(r, b.bingo_cols) + 1),
          }
          {
            ,
            List.replace_at(c, board_col, Enum.at(r, board_col) + 1),
            s,
            max(mdr, draw_round), # keeps the max round, it will be the round when the board would win if ???
            board_col + 1
          }
        else
          # no drawn, update the sum
          {j + 1, %BingoBoard{b | not_drawn_sum: b.not_draw_sum + 1}}
        end
      end)
  end

  defp get_winner_board(board_a, board_b) do
    cond do
      board_a == :no_winner_board -> board_b
      board_a.bingo_round > board_b.bingo_round -> board_a
      _ -> board_b
    end
  end

end
