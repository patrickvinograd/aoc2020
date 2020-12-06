input = File.read!("input_day6.txt")

groupqs = fn(group) -> 
  String.split(group, ~r{\s}, trim: true)
  |> Enum.flat_map(&(String.split(&1, "", trim: true)))
  |> Enum.uniq
  |> Enum.count
  end

String.split(input, "\n\n", trim: true)
  |> Enum.map(groupqs)
  |> Enum.sum
  |> IO.inspect

