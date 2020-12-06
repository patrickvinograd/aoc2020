input = File.read!("input_day6.txt")

groupqs = fn(group) -> 
  answers = String.split(group, ~r{\s}, trim: true)
  Enum.flat_map(answers, &(String.split(&1, "", trim: true)))
    |> Enum.frequencies
    |> Enum.count(fn {k, v} -> v == Enum.count(answers) end)
  end

String.split(input, "\n\n", trim: true)
  |> Enum.map(groupqs)
  |> Enum.sum
  |> IO.inspect

