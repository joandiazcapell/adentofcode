defmodule Day3 do
  Envy.auto_load()
  require KinoAOC

  alias GetInput

  @year "2024"
  @day "3"

  def solve_part1 do
    input = GetInput.get_input(@year, @day)

    input
    |> extract_mult_operations()
    |> Stream.map(&compute_product/1)
    |> Enum.sum()
  end

  defp extract_mult_operations(input) do
    regex_mul = ~r/mul\(\d{1,3},\d{1,3}\)/

    Regex.scan(regex_mul, input)
    |> Stream.flat_map(&extract_numbers/1)
  end

  defp extract_numbers([sub_string]) do
    regex_nums = ~r/\d{1,3},\d{1,3}/

    Regex.scan(regex_nums, sub_string)
    |> Stream.map(&parse_and_convert_to_numbers/1)
  end

  defp parse_and_convert_to_numbers([number_pair]) do
    number_pair
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp compute_product(numbers) do
    Enum.reduce(numbers, 1, &Kernel.*/2)
  end
end
