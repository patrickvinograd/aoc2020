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

  def total(rules, bag) do
    if Enum.count(Map.get(rules, bag)) == 0 do
      1
    else
      Enum.sum(Enum.map(Map.get(rules, bag), fn {i, j} -> String.to_integer(i) * Loop.total(rules, j) end)) + 1
    end
  end

end

Loop.total(map, "shiny gold") - 1 |> IO.inspect
