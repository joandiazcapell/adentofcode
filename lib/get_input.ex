defmodule GetInput do
  def get_input(year, day) do
    # Attempt to download the puzzle input for day 1 of the year 2024
    {:ok, puzzle_input} =
      KinoAOC.download_puzzle(year, day, System.get_env("LB_AOC_SESSION"))

    puzzle_input
  end
end
