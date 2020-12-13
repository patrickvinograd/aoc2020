steps = File.read!("input_day12.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x -> Kernel.apply(fn {c,d} -> {c, String.to_integer(d)} end, [String.split_at(x, 1)]) end)

# Null terminator
steps = steps ++ {"X",0}

defmodule Nav do
  def revcompass(dir) do Map.new([{"N",0},{"E",90},{"S",180},{"W",270}]) |> Map.get(dir) end
  def compass(bearing) do Map.new([{0, "N"},{90, "E"},{180,"S"},{270,"W"}]) |> Map.get(bearing) end
  def rotate(current, "L", amount) do compass(rem(revcompass(current) - amount + 360, 360)) end
  def rotate(current, "R", amount) do compass(rem(revcompass(current) + amount + 360, 360)) end

  def go({"X", _amount}, x, y, _heading) do
    IO.puts "#{x},#{y}"
    abs(x)+abs(y) |> IO.inspect
  end

  def go([{"N", amount}|steps], x, y, heading) do Nav.go(steps, x, y-amount, heading) end
  def go([{"S", amount}|steps], x, y, heading) do Nav.go(steps, x, y+amount, heading) end
  def go([{"E", amount}|steps], x, y, heading) do Nav.go(steps, x+amount, y, heading) end
  def go([{"W", amount}|steps], x, y, heading) do Nav.go(steps, x-amount, y, heading) end
  def go([{"F", amount}|steps], x, y, heading) do Nav.go([{heading,amount}|steps], x, y, heading) end
  def go([{"L", amount}|steps], x, y, heading) do Nav.go(steps, x, y, rotate(heading, "L", amount)) end
  def go([{"R", amount}|steps], x, y, heading) do Nav.go(steps, x, y, rotate(heading, "R", amount)) end

end

Nav.go(steps, 0,0,"E")
