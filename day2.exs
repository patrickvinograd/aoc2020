lines = File.read!("input_day2.txt") 
        |> String.split("\n", trim: true)

defmodule PW do
  def valid(input) do
    match = Regex.run(~r/^([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]])\: ([[:alpha:]]+)$/, input)
    {min, max} = {String.to_integer(Enum.at(match, 1)), String.to_integer(Enum.at(match, 2))}
    {char, pw} = {Enum.at(match, 3), Enum.at(match, 4)}
    x = Enum.count(String.graphemes(pw), &(&1 == char))
    min <= x and x <= max
  end
end

#Enum.each(lines, &(IO.puts &1))

IO.inspect Enum.count(lines, &(PW.valid &1))

