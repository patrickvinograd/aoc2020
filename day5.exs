use Bitwise

input = File.read!("input_day5.txt")
  |> String.split("\n", trim: true)

seatid = fn(record) ->
  row = String.split(record, "", trim: true)
    |> Enum.slice(0, 7)
    |> Enum.reduce(0, fn x, acc -> y = acc <<< 1; if x == "B", do: y ||| 1, else: y;  end)
  column = String.split(record, "", trim: true)
    |> Enum.slice(7, 3)
    |> Enum.reduce(0, fn x, acc -> y = acc <<< 1; if x == "R", do: y ||| 1, else: y;  end)
  row * 8 + column
end
    
input |> Enum.map(seatid)
  |> Enum.max
  |> IO.inspect

