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
    input = GetInput.get_input(@year, @day)

    Regex.scan(~r/mul\((-?\d+),(-?\d+)\)|do(?:n't)?\(\)/, input)
    |> Enum.reduce({0, :enable}, fn
      ["don't()"], {count, _status} ->
        {count, :disable}

      ["do()"], {count, _status} ->
        {count, :enable}

      [_mul, a, b], {count, :enable} ->
        result = count + String.to_integer(a) * String.to_integer(b)
        {result, :enable}

      [_mul, _a, _b], {count, :disable} ->
        {count, :disable}
    end)
    |> case do
      {result, :disable} -> result
      {result, :enable} -> result
    end
  end
end
