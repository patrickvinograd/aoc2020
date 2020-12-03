lines = File.read!("input_day3.txt")
        |> String.split("\n", trim: true)

length = Enum.at(lines, 0) |> String.length

checktree = fn({line, idx}) -> binary_part(line, rem(idx*3, length), 1) == "#" end

Enum.with_index(lines)
  |> Enum.count(checktree)
  |> IO.inspect




