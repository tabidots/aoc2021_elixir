defmodule Aoc2021.D02 do
  def read_instructions(line) do
    [dir, unit] = Regex.run(~r/([[:alnum:]]+) ([-?[:digit:]]+)/, line, capture: :all_but_first)
    {dir, String.to_integer(unit)}
  end

  def part_1(input) do
    Enum.reduce(input, %{horiz: 0, depth: 0}, fn {dir, unit}, submarine ->
      cond do
        dir == "forward" ->
          Map.update!(submarine, :horiz, fn x -> x + unit end)

        dir == "up" ->
          Map.update!(submarine, :depth, fn x -> x - unit end)

        dir == "down" ->
          Map.update!(submarine, :depth, fn x -> x + unit end)
      end
    end)
    |> Map.values()
    |> Kernel.then(fn [a, b] -> a * b end)
  end

  def part_2(input) do
    Enum.reduce(input, %{horiz: 0, depth: 0, aim: 0}, fn {dir, unit}, submarine ->
      cond do
        dir == "forward" ->
          Map.update!(submarine, :horiz, fn x -> x + unit end)
          |> Map.update!(:depth, fn x -> x + submarine[:aim] * unit end)

        dir == "up" ->
          Map.update!(submarine, :aim, fn x -> x - unit end)

        dir == "down" ->
          Map.update!(submarine, :aim, fn x -> x + unit end)
      end
    end)
    |> Map.take([:horiz, :depth])
    |> Map.values()
    |> Kernel.then(fn [a, b] -> a * b end)
  end

  def solutions do
    IO.puts("Day 2: Dive!")

    sample_input = AOC.parse_lines("day02_ex.txt", &read_instructions/1)
    puzzle_input = AOC.parse_lines("day02.txt", &read_instructions/1)

    %{
      part_1: [
        sample: part_1(sample_input),
        puzzle: part_1(puzzle_input)
      ],
      part_2: [
        sample: part_2(sample_input),
        puzzle: part_2(puzzle_input)
      ]
    }
  end
end
