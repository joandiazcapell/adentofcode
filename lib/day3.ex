defmodule Day3 do
  Envy.auto_load()
  require KinoAOC

  alias GetInput

  @year "2024"
  @day "3"

  def solve_part1 do
    input = GetInput.get_input(@year, @day)

    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, input, capture: :all_but_first)
    |> Enum.reduce(0, fn [a, b], acc -> acc + String.to_integer(a) * String.to_integer(b) end)
  end

  def solve_part2 do
  end
end
