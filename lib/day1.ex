defmodule Day01 do
  Envy.auto_load()
  require KinoAOC

  alias GetInput

  @year "2024"
  @day "1"

  def solve_part1 do
    {left_list, right_list} =
      GetInput.get_input(@year, @day)
      |> String.split("\n", trim: true)
      |> Stream.map(&String.split(&1, " ", trim: true))
      |> Enum.reduce({[], []}, fn [left, right], {left_acc, right_acc} ->
        {left_acc ++ [String.to_integer(left)], right_acc ++ [String.to_integer(right)]}
      end)

    # Sort both lists
    sorted_left = Enum.sort(left_list)
    sorted_right = Enum.sort(right_list)

    # Calculate the total distance
    sorted_left
    |> Stream.zip(sorted_right)
    |> Stream.map(fn {l, r} -> abs(l - r) end)
    |> Enum.sum()
  end

  def solve_part2 do
    {left_list, right_list} =
      GetInput.get_input(@year, @day)
      |> String.split("\n", trim: true)
      |> Stream.map(&String.split(&1, " ", trim: true))
      |> Enum.reduce({[], []}, fn [left, right], {left_acc, right_acc} ->
        {left_acc ++ [String.to_integer(left)], right_acc ++ [String.to_integer(right)]}
      end)

    # {id, #number times it appears}
    Enum.map(left_list, fn x -> {x, Enum.count(right_list, &(&1 == x))} end)
    |> Enum.reduce(0, fn {id, count}, acc -> acc + id * count end)
  end
end
