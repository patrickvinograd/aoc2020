values = File.read!("input_day10.txt") \
  |> String.split("\n", trim: true) \
  |> Enum.map(&(String.to_integer(&1))) \
  |> Enum.sort

values = [0] ++ values ++ [List.last(values) + 3]

defmodule Lookback do
  def calc(_map, _i, nil) do 0 end
  def calc(_map, _i, 1) do 1 end

  def calc(map, i, _ways) do
    Lookback.calc(map, i-1, Map.get(map, i-1)) + Lookback.calc(map, i-2, Map.get(map, i-2)) + Lookback.calc(map, i-3, Map.get(map, i-3))
  end
end

ways = Enum.map(values, fn x -> Enum.count(x-3..x-1, fn y -> y in values end) end)
map = Enum.zip(values, ways) |> Map.new |> Map.put(0, 1) |> IO.inspect
[_ | keys] = Map.keys(map) |> Enum.sort

# Calculate options chains
options = Enum.map(keys, fn x -> Lookback.calc(map, x, Map.get(map, x)) end) |> IO.inspect
# Calculate product of options chains separated by runs of 1s
Enum.reduce(options, {1, 1}, fn x, {product, last} -> (if x == 1, do: {product*last, x}, else: {product, x}) end) |> IO.inspect

