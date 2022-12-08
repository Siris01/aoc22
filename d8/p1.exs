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

    {l, r} =
      String.split(input, "\n")
      |> Enum.at(x)
      |> String.split("", trim: true)
      |> List.delete_at(y)
      |> Enum.map(fn c -> String.to_integer(c) end)
      |> Enum.split(y)

    if Enum.all?(l, fn c -> c < h end) or
         Enum.all?(r, fn c -> c < h end) do
      true
    else
      {t, b} =
        String.split(input, "\n")
        |> Enum.map(fn s -> String.at(s, y) end)
        |> List.delete_at(x)
        |> Enum.map(fn c -> String.to_integer(c) end)
        |> Enum.split(x)

      if Enum.all?(t, fn c -> c < h end) or
           Enum.all?(b, fn c -> c < h end) do
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
    Enum.reduce(c, acc, fn y, acc ->
      if is_visible.(x, y) do
        acc + 1
      else
        acc
      end
    end)
  end)

IO.puts(ans)
