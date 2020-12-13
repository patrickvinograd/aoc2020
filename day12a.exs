steps = File.read!("input_day12.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x -> Kernel.apply(fn {c,d} -> {c, String.to_integer(d)} end, [String.split_at(x, 1)]) end)

# Null terminator
steps = steps ++ {"X",0}

defmodule Nav do
  def rotate(wx, wy, "L", 90) do {wy, -wx} end
  def rotate(wx, wy, "L", 180) do {-wx, -wy} end
  def rotate(wx, wy, "L", 270) do {-wy, wx} end

  def rotate(wx, wy, "R", 90) do {-wy, wx} end
  def rotate(wx, wy, "R", 180) do {-wx, -wy} end
  def rotate(wx, wy, "R", 270) do {wy, -wx} end

  def go({"X", _amount}, x, y, _wx, _wy) do
    IO.puts "#{x},#{y}"
    abs(x)+abs(y) |> IO.inspect
  end

  def go([{"N", amount}|steps], x, y, wx, wy) do Nav.go(steps, x, y, wx, wy-amount) end
  def go([{"S", amount}|steps], x, y, wx, wy) do Nav.go(steps, x, y, wx, wy+amount) end
  def go([{"E", amount}|steps], x, y, wx, wy) do Nav.go(steps, x, y, wx+amount, wy) end
  def go([{"W", amount}|steps], x, y, wx, wy) do Nav.go(steps, x, y, wx-amount, wy) end
  def go([{"F", amount}|steps], x, y, wx, wy) do Nav.go(steps, x+(wx*amount), y+(wy*amount), wx, wy) end
  def go([{"L", amount}|steps], x, y, wx, wy) do 
    {nwx, nwy} = rotate(wx, wy, "L", amount) 
    Nav.go(steps, x, y, nwx, nwy) 
  end
  def go([{"R", amount}|steps], x, y, wx, wy) do 
    {nwx, nwy} = rotate(wx, wy, "R", amount) 
    Nav.go(steps, x, y, nwx, nwy)
  end

end

Nav.go(steps, 0,0, 10, -1)
