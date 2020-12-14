lines = File.read!("input_day13.txt")
  |> String.split("\n", trim: true)

buses = String.split(Enum.at(lines, 1), ",", trim: true) |> Enum.with_index 
  |> Enum.filter(fn {x,i} -> x != "x" end) 
  |> Enum.map(fn {x, i} -> {i, String.to_integer(x)} end) |> IO.inspect

Enum.each(buses, fn {i, v} -> IO.puts "x = #{v-i} mod #{v}" end)

{first, second} = Enum.map(buses, fn {i, v} -> {v-i, v} end) |> Enum.unzip
IO.puts "ChineseRemainder[{#{Enum.join(first, ",")}}, {#{Enum.join(second, ",")}}]"

IO.puts "Product of primes (upper bound):"
Enum.reduce(buses, 1, fn {i,v}, acc -> v*acc end) |> IO.inspect

defmodule Loop do

  def go(buses, i, true) do
    if Enum.all?(buses, fn {offset, bus} -> rem(i+offset, bus) == 0 end) do
      IO.inspect i
    else
      go(buses, i+elem(Enum.at(buses, 0),1), true)
    end
  end

end

#Loop.go(buses, 100000000000000, true)


