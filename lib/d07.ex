defmodule Aoc2021.D07 do
  require Integer

  def median(items) do
    count = Enum.count(items)

    if Integer.is_odd(count) do
      Enum.sort(items) |> Enum.at(floor(count / 2))
    else
      {head, tail} = Enum.sort(items) |> Enum.split(div(count, 2))
      (Enum.at(head, -1) + Enum.at(tail, 0)) / 2
    end
  end

  def part_1(crabs) do
    goal = median(crabs)

    Enum.reduce(crabs, 0, fn position, acc -> acc + abs(goal - position) end)
    |> trunc()
  end

  def mean(items) do
    Enum.sum(items) / Enum.count(items)
  end

  def triangular_cost(a, b) do
    n = abs(a - b)
    n * (n + 1) / 2
  end

  def total_triangular_cost(crabs, goal) do
    Enum.reduce(crabs, 0, fn position, acc -> acc + triangular_cost(goal, position) end)
    |> trunc()
  end

  def part_2(crabs) do
    [floor(mean(crabs)), ceil(mean(crabs))]
    |> Enum.map(fn goal -> total_triangular_cost(crabs, goal) end)
    |> Enum.min()
  end

  def solutions do
    IO.puts("Day 7: The Treachery of Whales")

    sample_input =
      AOC.slurp_parse("day07_ex.txt", fn line -> String.split(line, ",", trim: true) end)
      |> Enum.map(&String.to_integer/1)

    puzzle_input =
      AOC.slurp_parse("day07.txt", fn line -> String.split(line, ",", trim: true) end)
      |> Enum.map(&String.to_integer/1)

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
