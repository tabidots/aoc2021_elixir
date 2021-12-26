defmodule Aoc2021.D09 do
  def low_point?(coords, heatmap) do
    value = Map.fetch!(heatmap, coords)

    AOC.neighbors(heatmap, coords, straight: true)
    |> Enum.all?(fn {_coords, n_value} -> value < n_value end)
  end

  def low_points(heatmap) do
    Enum.filter(heatmap, fn {coords, _value} ->
      low_point?(coords, heatmap)
    end)
  end

  def part_1(heatmap) do
    low_points(heatmap)
    |> Enum.reduce(0, fn {_coords, height}, risk -> risk + height + 1 end)
  end

  def get_basin(basin, heatmap) do
    new_basin =
      Enum.flat_map(basin, fn {coords, _val} ->
        AOC.neighbors(heatmap, coords, straight: true)
      end)
      |> Enum.filter(fn {_coords, val} -> val < 9 end)
      |> Enum.into(basin)

    if new_basin == basin do
      basin
    else
      get_basin(new_basin, heatmap)
    end
  end

  def part_2(heatmap) do
    low_points(heatmap)
    |> Enum.map(fn cell -> MapSet.new([cell]) |> get_basin(heatmap) |> Enum.count() end)
    |> Enum.sort(&>=/2)
    |> Enum.take(3)
    |> Enum.reduce(&*/2)
  end

  def solutions do
    IO.puts("Day 9: Smoke Basin")

    sample_input = AOC.parse_grid("day09_ex.txt")
    puzzle_input = AOC.parse_grid("day09.txt")

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
