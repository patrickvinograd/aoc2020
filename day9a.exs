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

target = Enum.at(values, idx) |> IO.inspect

Range.new(1, Enum.count(values)-1) 
  |> Enum.each(fn last -> Enum.each(0..last-1, fn first -> if (Enum.sum(Enum.slice(values, first..last)) == target), do: IO.puts "#{Enum.min(Enum.slice(values,first..last)) + Enum.max(Enum.slice(values,first..last))}" end) end)


