defmodule Aoc2024.Day1 do
  @doc """
  Parses the input data into two lists of integers separating them by odd and even indexes.
  """
  @spec parse_input(String.t()) :: {list(integer()), list(integer())}
  def parse_input(input) do
    {l1, l2} = input
    |> String.split(" ", trim: true)
    |> Enum.flat_map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.split_with(fn {_, i} -> rem(i, 2) == 0 end)

    l2_task = Task.async(fn -> map_first_tuple_value(l2) end)

    {map_first_tuple_value(l1), Task.await(l2_task)}
  end

  @doc """
  Solves the first part of the challenge.
  """
  @spec solve1(String.t()) :: number()
  def solve1(data) do
    {l1, l2} = parse_input(data)

    l2_task = Task.async(fn -> Enum.sort(l2) end)

    {l1, l2} = {Enum.sort(l1), Task.await(l2_task)}

    l1
    |> Enum.zip(l2)
    |> Enum.map(fn {a, b} -> distance_between(a, b) end)
    |> Enum.sum()
  end

  @doc """
  Solves the second part of the challenge.
  """
  @spec solve2(String.t()) :: number()
  def solve2(data) do
    {l1, l2} = parse_input(data)

    l2_freq = Enum.frequencies(l2)

    l1
    |> Enum.map(&similarity(&1, l2_freq))
    |> Enum.sum()
  end

  @doc """
  Calculates the similarity between a number and its frequency.
  """
  @spec similarity(number(), map()) :: number()
  def similarity(x, freq) do
    freq_num = Map.get(freq, x, 0)
    x * freq_num
  end

  @doc """
  Calculates the distance between two numbers.
  """
  @spec distance_between(number(), number()) :: number()
  def distance_between(a, b), do: force_positive(a - b)

  @doc """
  Forces a number to be positive.
  """
  @spec force_positive(number()) :: number()
  def force_positive(n) when n < 0, do: n * -1
  def force_positive(n), do: n

  @doc """
  Maps a enumerable to its first element in each tuple of the list.
  """
  @spec map_first_tuple_value(Enum.t()) :: list(any())
  def map_first_tuple_value(list), do: Enum.map(list, &elem(&1, 0))
end
