vals = String.split(File.read!("input_day1.txt"), "\n", trim: true)
values = List.to_tuple(Enum.map(vals, fn x -> String.to_integer(x) end))

defmodule State do
  def start_link(tup) do
    Task.start_link(fn -> loop(tup) end)
  end

  defp loop(tup) do
    receive do
      {:get, index, caller} ->
        send caller, {:got, elem(tup, index)}
        loop(tup)
    end
  end
end

defmodule Expense do
  def check2020(parent, values, start, length) do
    # send :state, {:get, start, self()}
    # receive do {:got, val} -> a = val end
    a = elem(values, start)
    Enum.each(start+1..length-2, fn(x) -> 
      b = elem(values, x)
      Enum.each(x+1..length-1, fn(y) ->
        c = elem(values, y)
        if a + b + c == 2020 do
          IO.puts("!!!!yes #{a} #{b} #{c}")
          send(parent, {:result, a * b * c})
        else
          nil
        end
      end
      )
    end
    )
  end
end


me = self()

length = tuple_size(values)

Enum.each(0..length-3, fn(x) -> spawn(Expense, :check2020, [me, values, x, length]) end)

#spawn(Expense, :check2020, [me, values, 0, length])

IO.puts("hi")

receive do
 {:result, product} -> IO.puts "Got answer #{product} !"
after 
  10000 -> "nada"
end
