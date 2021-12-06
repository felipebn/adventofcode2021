defmodule Adv21.Day04.Bingo do

  def get_winner_board_score(filename) do
    {numbers, boards} = File.stream!(filename)
      |> Enum.reduce({:no_numbers, []}, fn row , game_input ->
        case game_input do
          {:no_numbers, boards} -> {
            row |> String.split(","),
            boards
          }
          {numbers, boards} -> nil # TODO parse the game boards, if empty row means the board is ready
        end
      end)
  end

end
