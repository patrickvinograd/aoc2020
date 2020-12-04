input = File.read!("input_day4.txt")

required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
# not required: "cid"

validate_height = fn
  ([_, x, "cm"]) -> try do y = String.to_integer(x); (y >= 150 and y <= 193); rescue _ -> nil; end
  ([_, x, "in"]) -> try do y = String.to_integer(x); (y >= 59 and y <= 76); rescue _ -> nil; end
  (_) -> nil
end

validate = fn
  (["byr", v]) -> try do y = String.to_integer(v); if (y >= 1920 and y <= 2020), do: "byr"; rescue _ -> nil; end
  (["iyr", v]) -> try do y = String.to_integer(v); if (y >= 2010 and y <= 2020), do: "iyr"; rescue _ -> nil; end
  (["eyr", v]) -> try do y = String.to_integer(v); if (y >= 2020 and y <= 2030), do: "eyr"; rescue _ -> nil; end
  (["hgt", v]) -> try do if validate_height.(Regex.run(~r/^(\d+)([[:alpha:]]+$)/, v)), do: "hgt"; rescue _ -> nil; end
  (["hcl", v]) -> if Regex.match?(~r/^#[0-9a-f]{6}$/, v) do "hcl"; end
  (["ecl", v]) -> if v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] do "ecl"; end
  (["pid", v]) -> if Regex.match?(~r/^[0-9]{9}$/, v) do "pid"; end
  ([_, _]) -> nil
end

checkrec = fn(record) -> keys = String.split(record, ~r{\s}, trim: true)
  |> Enum.map(fn x -> validate.(String.split(x, ":")) end)
  Enum.all?(required, fn x -> x in keys end)
end

String.split(input, "\n\n", trim: true)
  |> Enum.count(checkrec)
  |> IO.inspect

