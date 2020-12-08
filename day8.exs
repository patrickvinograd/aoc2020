operations = File.read!("input_day8.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x -> (String.split(x, " ", trim:  true)) end) |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end) 
  |> Enum.with_index 
  |> Map.new(fn {op, i} -> {i, op} end)


defmodule Loop do

  def done(acc) do
   IO.puts(acc)
  end

  def step(operations, pc, seen, acc) do
    if (pc in seen) do
      done(acc)
    else
      {op, val} = Map.get(operations, pc)
      if op == "nop" do
       step(operations, pc+1, [pc|seen], acc)
      end
      if op == "acc" do
       step(operations, pc+1, [pc|seen], acc+val)
      end
      if op == "jmp" do
        step(operations, pc+val, [pc|seen], acc)
      end
    end
  end
end

Loop.step(operations, 0, [], 0)

