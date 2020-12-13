seats = File.read!("input_day11.txt")
  |> String.split("\n", trim: true)
  |> Enum.with_index
  |> Enum.flat_map(fn {row, i} -> String.split(row, "", trim: true) |> Enum.with_index |> Enum.map(fn {v, j} -> {{i,j},v} end) end)
  |> Map.new(fn {k,v} -> {k, v} end)
  |> IO.inspect
  
count = fn(seats, {i,j}) ->
  Map.get(seats, {i-1,j-1}, "") <> Map.get(seats, {i-1,j}, "") <> Map.get(seats, {i-1,j+1}, "") <> Map.get(seats, {i,j-1}, "") <> Map.get(seats, {i,j+1}, "") <> Map.get(seats, {i+1,j-1}, "") <> Map.get(seats, {i+1,j}, "") <> Map.get(seats, {i+1,j+1}, "")
   |> String.split("") |> Enum.count(&(&1=="#"))
end

iterate = fn
  {seats, {i,j}, "."} -> "."
  {seats, {i,j}, "L"} -> if count.(seats, {i,j}) == 0, do: "#", else: "L"
  {seats, {i,j}, "#"} -> if count.(seats, {i,j}) >= 4, do: "L", else: "#"
end

defmodule Loop do

  def count(seats, {i,j}) do
    Map.get(seats, {i-1,j-1}, "") <> Map.get(seats, {i-1,j}, "") <> Map.get(seats, {i-1,j+1}, "") <> Map.get(seats, {i,j-1}, "") <> Map.get(seats, {i,j+1}, "") <> Map.get(seats, {i+1,j-1}, "") <> Map.get(seats, {i+1,j}, "") <> Map.get(seats, {i+1,j+1}, "")
     |> String.split("") |> Enum.count(&(&1=="#"))
  end

  def iterate(seats, {i,j}, ".") do "." end
  def iterate(seats, {i,j}, "L") do if Loop.count(seats, {i,j}) == 0, do: "#", else: "L" end
  def iterate(seats, {i,j}, "#") do if Loop.count(seats, {i,j}) >= 4, do: "L", else: "#" end

  def step(seats, i, equal) when equal == true do
    IO.puts Enum.count(Map.values(seats), &(&1 == "#"))
  end

  def step(seats, i, equal) do
    seats2 = Enum.map(Map.keys(seats), fn {i,j} -> {{i, j}, Loop.iterate(seats, {i,j}, Map.get(seats, {i,j})) } end) 
      |> Map.new(fn {k,v} -> {k, v} end)
    Loop.step(seats2, i+1, seats2==seats)
  end
end

#seats2 = Enum.map(Map.keys(seats), fn {i,j} -> {{i, j}, iterate.({seats, {i,j}, Map.get(seats, {i,j}) }) } end) |> IO.inspect
#IO.puts "#{seats2==seats}"
Loop.step(seats, 0, false)

