values = File.read!("input_day9.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&(String.to_integer(&1)))

prenum = 25

IO.inspect values

invalid = fn(record, preamble) ->
  Enum.any?(preamble, fn x -> record - x in preamble end)
end

idx = Range.new(prenum, Enum.count(values)-1) 
  |> Enum.find(-1, fn x -> ! invalid.(Enum.at(values, x), Enum.slice(values, x-prenum, prenum)) end)

Enum.at(values, idx) |> IO.inspect
