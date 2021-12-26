defmodule Aoc2021.D01 do
  def part_1(input) do
    Enum.zip(input, Enum.drop(input, 1))
    |> Enum.count(fn {a, b} -> b > a end)
  end

  def part_2(input) do
    triples =
      Enum.chunk_every(input, 3, 1, :discard)
      |> Enum.map(fn list -> Enum.sum(list) end)

    Enum.zip(triples, Enum.drop(triples, 1))
    |> Enum.count(fn {a, b} -> b > a end)
  end

  def solutions do
    IO.puts("Day 1: Sonar Sweep")

    sample_input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    puzzle_input = AOC.parse_lines("day01.txt")

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
