defmodule Aoc2021.D05 do
  def parse_endpoints(line) do
    Regex.scan(~r/(\d+),(\d+) -> (\d+),(\d+)/, line, capture: :all_but_first)
    |> List.first()
    |> Enum.map(&String.to_integer/1)
  end

  def to_points([x1, y1, x2, y2], opts \\ []) do
    xs =
      if x1 <= x2 do
        x1..x2
      else
        x1..x2//-1
      end

    ys =
      if y1 <= y2 do
        y1..y2
      else
        y1..y2//-1
      end

    cond do
      # Vertical line
      x1 == x2 -> Enum.map(ys, fn y -> {x1, y} end)
      # Horizontal line
      y1 == y2 -> Enum.map(xs, fn x -> {x, y1} end)
      Keyword.fetch(opts, :diagonal) == {:ok, true} -> Enum.zip(xs, ys)
      true -> []
    end
  end

  def find_overlaps(input, opts \\ []) do
    Enum.flat_map(input, fn coords -> to_points(coords, opts) end)
    |> Enum.frequencies()
    |> Enum.count(fn {_coord, freq} -> freq > 1 end)
  end

  def solutions do
    sample_input = AOC.parse_lines("day05_ex.txt", &Aoc2021.D05.parse_endpoints/1)
    puzzle_input = AOC.parse_lines("day05.txt", &Aoc2021.D05.parse_endpoints/1)

    %{
      part_1: [
        sample: Aoc2021.D05.find_overlaps(sample_input),
        puzzle: Aoc2021.D05.find_overlaps(puzzle_input)
      ],
      part_2: [
        sample: Aoc2021.D05.find_overlaps(sample_input, diagonal: true),
        puzzle: Aoc2021.D05.find_overlaps(puzzle_input, diagonal: true)
      ]
    }
  end
end
