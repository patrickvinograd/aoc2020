operations = File.read!("input_day8.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x -> (String.split(x, " ", trim:  true)) end) |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end) 
  |> Enum.with_index 
  |> Map.new(fn {op, i} -> {i, op} end)



defmodule Loop do

  def step(_operations, _pc, _seen, acc, looped, _last) when looped do
    acc
  end
 
  def step(_operations, pc, _seen, acc, _looped, last) when pc >= last do
    IO.puts "Halted #{acc}"
  end
 
  def step(operations, pc, seen, acc, _looped, last) do
      {op, val} = Map.get(operations, pc)
      if op == "nop" do
       step(operations, pc+1, [pc|seen], acc, pc+1 in seen, last)
      end
      if op == "acc" do
       step(operations, pc+1, [pc|seen], acc+val, pc+1 in seen, last)
      end
      if op == "jmp" do
        step(operations, pc+val, [pc|seen], acc, pc+val in seen, last)
      end
  end
end

swap = fn
  {"nop", val} -> {"jmp", val}
  {"jmp", val} -> {"nop", val}
  {x, y} -> {x, y}
end

Range.new(0, Enum.count(operations) -1) |>
  Enum.each(&(Loop.step(Map.update!(operations, &1, swap), 0, [], 0, false, Enum.count(operations))))


