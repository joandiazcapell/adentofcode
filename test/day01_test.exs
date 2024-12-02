defmodule Day01Test do
  use ExUnit.Case, async: true
  alias Day01
  doctest Day01

  test "verification, part 1", do: assert(Day01.solve_part1() == 2_375_403)
  test "verification, part 2", do: assert(Day01.solve_part2() == 23_082_277)
end
