input = File.read!("input_day4.txt")

required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
# not required: "cid"

checkrec = fn(record) -> keys = String.split(record, ~r{\s}, trim: true)
  |> Enum.map(fn x -> String.split(x, ":") |> Enum.at(0) end)
  Enum.all?(required, fn x -> x in keys end)
  end

String.split(input, "\n\n", trim: true)
  |> Enum.count(checkrec)
  |> IO.inspect

