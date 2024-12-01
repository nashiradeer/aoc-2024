defmodule Aoc2024.Day1 do
  def parse_input(input) do
    {l1, l2} = input
    |> String.split(" ", trim: true)
    |> Enum.flat_map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.split_with(fn {_, i} -> rem(i, 2) == 0 end)

    l1_task = Task.async(fn -> remove_index(l1) end)
    l2_task = Task.async(fn -> remove_index(l2) end)

    {Task.await(l1_task), Task.await(l2_task)}
  end

  def solve1(data) do
    {l1, l2} = parse_input(data)

    l1_task = Task.async(fn -> Enum.sort(l1) end)
    l2_task = Task.async(fn -> Enum.sort(l2) end)

    Task.await(l1_task)
    |> Enum.zip(Task.await(l2_task))
    |> Enum.map(fn {a, b} -> difference(a, b) end)
    |> Enum.sum()
  end

  def solve2(data) do
    {l1, l2} = parse_input(data)

    l2_freq = Enum.frequencies(l2)

    l1
    |> Enum.map(&similarity(&1, l2_freq))
    |> Enum.sum()
  end

  def similarity(x, freq) do
    freq_num = Map.get(freq, x, 0)
    x * freq_num
  end

  def difference(a, b), do: force_positive(a - b)

  def force_positive(n) when n < 0, do: n * -1
  def force_positive(n), do: n

  def remove_index(list), do: Enum.map(list, &elem(&1, 0))
end
