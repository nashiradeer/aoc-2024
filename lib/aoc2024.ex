defmodule Aoc2024 do
  def solve(day, part) do
    day_input = File.read!("input/day#{day}.txt")

    module_name = String.to_existing_atom("Elixir.Aoc2024.Day#{day}")
    function_name = String.to_existing_atom("solve#{part}")

    apply(module_name, function_name, [day_input])
  end
end
