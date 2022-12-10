{:ok, input} = File.read("input.txt")

cols =
  String.split(input, "\n")
  |> Enum.at(0)
  |> String.length()

rows =
  String.split(input, "\n")
  |> Enum.count()

is_visible = fn x, y ->
  if x == 0 or y == 0 or x == rows - 1 or y == cols - 1 do
    true
  else
    h =
      String.split(input, "\n")
      |> Enum.at(x)
      |> String.at(y)
      |> String.to_integer()

    cmp = fn c -> c < h end

    {l, r} =
      String.split(input, "\n")
      |> Enum.at(x)
      |> String.split("", trim: true)
      |> List.delete_at(y)
      |> Enum.map(fn c -> String.to_integer(c) end)
      |> Enum.split(y)

    if Enum.all?(l, cmp) or Enum.all?(r, cmp) do
      true
    else
      {t, b} =
        String.split(input, "\n")
        |> Enum.map(fn s -> String.at(s, y) end)
        |> List.delete_at(x)
        |> Enum.map(fn c -> String.to_integer(c) end)
        |> Enum.split(x)

      if Enum.all?(t, cmp) or Enum.all?(b, cmp) do
        true
      else
        false
      end
    end
  end
end

r = Enum.to_list(0..(rows - 1))
c = Enum.to_list(0..(cols - 1))

ans =
  Enum.reduce(r, 0, fn x, acc ->
    Enum.reduce(c, acc, fn y, acc -> if is_visible.(x, y), do: acc + 1, else: acc end)
  end)

IO.puts(ans)
