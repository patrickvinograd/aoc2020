rulelines = File.read!("input_day7.txt")
  |> String.split("\n", trim: true)

parserules = fn(line) ->
  [head, tail] = String.split(line, " contain ")
  outer = Regex.run(~r/^(.*) bags/, head) |> Enum.at(1)
  if tail == "no other bags." do
    {outer, []}
  else
    {outer, String.split(tail, ", ", trim: true) |> Enum.map(&(Regex.run(~r/^(\d+) (.*) bag/, &1) |> Enum.slice(1, 2) |> List.to_tuple))}
  end
end

map = Enum.map(rulelines, parserules) |> Map.new(fn {k, v} -> {k, v} end)

defmodule Loop do

  def scanbags(_map, bags, added) when added < 0 do 
    IO.puts (Enum.count(bags)-1)
  end

  def scanbags(map, bags, _added) do
    found = Enum.filter(map, fn {_k, v} -> Enum.any?(Enum.map(v, fn {_i, j} -> j end), &(&1 in bags)) end) |> Enum.map(fn {k, _v} -> k end)
    Loop.scanbags(map, Enum.uniq(bags ++ found), (Enum.count(found) - Enum.count(bags)))
  end
end

bags = ["shiny gold"]
Loop.scanbags(map, bags, 1)

