values = File.read!("input_day10.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&(String.to_integer(&1)))
  |> Enum.sort

values = values ++ [List.last(values) + 3]
#IO.inspect(values)

{_, ones} = Enum.reduce(values, {0, 0}, fn x, {prev, count} -> {x, (if x - prev == 1, do: (count+1), else: count) } end) |> IO.inspect
{_, threes} = Enum.reduce(values, {0, 0}, fn x, {prev, count} -> {x, (if x - prev == 3, do: (count+1), else: count) } end) |> IO.inspect

IO.puts (ones * threes)

