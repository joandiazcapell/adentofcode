defmodule Day2 do
  Envy.auto_load()
  require KinoAOC

  alias GetInput

  @year "2024"
  @day "2"

  def solve_part1 do
    all =
      GetInput.get_input(@year, @day)
      |> parse()

    for levels <- all do
      safe?(levels)
    end
    |> Enum.count(& &1)
  end

  def solve_part2 do
    all =
      GetInput.get_input(@year, @day)
      |> parse()

    for levels <- all do
      safe?(levels) || Enum.any?(dump(levels), &safe?/1)
    end
    |> Enum.count(& &1)
  end

  defp safe?(levels) do
    Enum.reduce_while(levels, {nil, nil}, fn next, acc ->
      case acc do
        {nil, _} ->
          {:cont, {next, nil}}

        {current, nil} when abs(next - current) in [1, 2, 3] and next < current ->
          {:cont, {next, :decrease}}

        {current, nil} when abs(next - current) in [1, 2, 3] and next > current ->
          {:cont, {next, :increase}}

        {current, :decrease} when abs(next - current) in [1, 2, 3] and next < current ->
          {:cont, {next, :decrease}}

        {current, :increase} when abs(next - current) in [1, 2, 3] and next > current ->
          {:cont, {next, :increase}}

        _ ->
          {:halt, :invalid}
      end
    end)
    |> case do
      :invalid -> false
      _ -> true
    end
  end

  defp dump(levels) do
    levels
    |> Enum.with_index()
    |> Enum.map(fn {_, i} -> List.delete_at(levels, i) end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
