defmodule AOC do
  require Integer

  @doc """
  Reads every line in the file at `path` and converts it to a list of integers.
  """
  def parse_lines(path) do
    File.stream!("../aoc2021/resources/" <> path)
    |> Stream.map(fn line -> String.trim_trailing(line) |> String.to_integer() end)
  end

  @doc """
  Reads every line in the file at `path` and maps `func` over each line.
  """
  def parse_lines(path, func) do
    File.stream!("../aoc2021/resources/" <> path)
    |> Stream.map(fn line -> String.trim_trailing(line) |> func.() end)
  end

  @doc """
  Reads in the entire file at `path` and maps `func` over each line.
  """
  def slurp_parse(path, func) do
    File.read("../aoc2021/resources/" <> path)
    |> Kernel.then(fn {_, line} -> String.trim_trailing(line) |> func.() end)
  end

  @doc """
  Reads in the entire file at `path` into a map of {y, x} coordinates to their values.
  """
  def parse_grid(path) do
    grid =
      parse_lines(path, fn line ->
        if Regex.match?(~r/^\d+$/, line) do
          # Can't use Integer.digits/1 here because it will trim leading zeroes
          String.graphemes(line) |> Enum.map(&String.to_integer/1)
        else
          String.graphemes(line)
        end
      end)

    Enum.with_index(grid, fn row, y ->
      Enum.with_index(row, fn val, x ->
        %{{y, x} => val}
      end)
      |> Enum.reduce(&Map.merge/2)
    end)
    |> Enum.reduce(&Map.merge/2)
  end

  @doc """
  Given a grid, returns a map of %{`coords` => `values`} for each neighbor
  present in the grid. `straight: true` includes up-down-left-right neighbors and
  `diagonal: true` includes diagonal neighbors.
  """
  def neighbors(grid, {y, x}, opts \\ []) do
    udlr =
      if opts[:straight] do
        [{y - 1, x}, {y, x - 1}, {y, x + 1}, {y + 1, x}]
      else
        []
      end

    diag =
      if opts[:diagonal] do
        [{y - 1, x - 1}, {y - 1, x + 1}, {y + 1, x - 1}, {y + 1, x + 1}]
      else
        []
      end

    # Map.take returns only those keyvals whose keys are in map
    Map.take(grid, Enum.concat(udlr, diag))
  end
end
