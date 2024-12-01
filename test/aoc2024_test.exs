defmodule Aoc2024Test do
  use ExUnit.Case
  doctest Aoc2024

  test "Day 1 Part One" do
    data = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """
    assert Aoc2024.Day1.solve1(data) == 11
  end

  test "Day 1 Part Two" do
    data = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """
    assert Aoc2024.Day1.solve2(data) == 31
  end

  test "Day 2 Part One" do
    assert true
  end

  test "Day 2 Part Two" do
    assert true
  end
end
