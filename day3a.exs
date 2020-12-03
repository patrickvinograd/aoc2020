lines = File.read!("input_day3.txt")
        |> String.split("\n", trim: true)

length = Enum.at(lines, 0) |> String.length

#    Right 1, down 1.
#    Right 3, down 1. (This is the slope you already checked.)
#    Right 5, down 1.
#    Right 7, down 1.
#    Right 1, down 2.

checktree11 = fn({line, idx}) -> binary_part(line, rem(idx*1, length), 1) == "#" end
checktree31 = fn({line, idx}) -> binary_part(line, rem(idx*3, length), 1) == "#" end
checktree51 = fn({line, idx}) -> binary_part(line, rem(idx*5, length), 1) == "#" end
checktree71 = fn({line, idx}) -> binary_part(line, rem(idx*7, length), 1) == "#" end
checktree12 = fn({line, idx}) -> rem(idx, 2) == 0 && binary_part(line, rem(div(idx, 2), length), 1) == "#" end

[checktree11, checktree31, checktree51, checktree71, checktree12] 
  |> Enum.reduce(1, fn x, acc -> acc * (Enum.with_index(lines) |> Enum.count(x)) end)
  |> IO.inspect


