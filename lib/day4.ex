defmodule Day4 do
  Envy.auto_load()
  require KinoAOC

  alias GetInput

  @year "2024"
  @day "4"

  def solve_part1 do
    grid =
      GetInput.get_input(@year, @day)
      |> parse_grid()

    grid
    |> find_char("X")
    |> Enum.map(fn pos ->
      pos
      |> directions()
      |> Enum.count(&(multiple_get(grid, &1) == "MAS"))
    end)
    |> Enum.sum()
  end

  def solve_part2 do
    grid =
      GetInput.get_input(@year, @day)
      |> parse_grid()

    a_positions = find_char(grid, "A")

    Enum.count(a_positions, &xmas?(grid, &1))
  end

  defp parse_grid(input) do
    for {row, y} <- input |> String.split("\n") |> Enum.with_index(),
        {char, x} <- row |> String.graphemes() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, char}
  end

  defp find_char(grid, match) do
    grid
    |> Enum.filter(fn {_, c} -> c == match end)
    |> Enum.map(&elem(&1, 0))
  end

  defp directions({x, y}) do
    [
      [{x + 1, y}, {x + 2, y}, {x + 3, y}],
      [{x - 1, y}, {x - 2, y}, {x - 3, y}],
      [{x, y + 1}, {x, y + 2}, {x, y + 3}],
      [{x, y - 1}, {x, y - 2}, {x, y - 3}],
      [{x + 1, y + 1}, {x + 2, y + 2}, {x + 3, y + 3}],
      [{x - 1, y - 1}, {x - 2, y - 2}, {x - 3, y - 3}],
      [{x - 1, y + 1}, {x - 2, y + 2}, {x - 3, y + 3}],
      [{x + 1, y - 1}, {x + 2, y - 2}, {x + 3, y - 3}]
    ]
  end

  defp multiple_get(grid, positions) do
    Enum.map_join(positions, &Map.get(grid, &1))
  end

  defp xmas?(grid, {x, y}) do
    grid
    |> multiple_get([{x - 1, y - 1}, {x + 1, y - 1}, {x + 1, y + 1}, {x - 1, y + 1}])
    |> Kernel.in(["MMSS", "MSSM", "MSSM", "SSMM", "SMMS"])
  end
end
