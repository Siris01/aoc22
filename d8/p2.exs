{:ok, input} = File.read("input.txt")

cols =
  String.split(input, "\n")
  |> Enum.at(0)
  |> String.length()

rows =
  String.split(input, "\n")
  |> Enum.count()

score = fn x, y ->
  if x == 0 or y == 0 or x == rows - 1 or y == cols - 1 do
    0
  else
    h =
      String.split(input, "\n")
      |> Enum.at(x)
      |> String.at(y)
      |> String.to_integer()

    get_count = fn list ->
      Enum.reduce_while(list, 0, fn c, acc ->
        if c < h, do: {:cont, acc + 1}, else: {:halt, acc + 1}
      end)
    end

    {l, r} =
      String.split(input, "\n")
      |> Enum.at(x)
      |> String.split("", trim: true)
      |> List.delete_at(y)
      |> Enum.map(fn c -> String.to_integer(c) end)
      |> Enum.split(y)

    {t, b} =
      String.split(input, "\n")
      |> Enum.map(fn s -> String.at(s, y) end)
      |> List.delete_at(x)
      |> Enum.map(fn c -> String.to_integer(c) end)
      |> Enum.split(x)

    lc = get_count.(Enum.reverse(l))
    rc = get_count.(r)
    tc = get_count.(Enum.reverse(t))
    bc = get_count.(b)

    lc * rc * tc * bc
  end
end

r = Enum.to_list(0..(rows - 1))
c = Enum.to_list(0..(cols - 1))

ans =
  Enum.reduce(r, 0, fn x, acc ->
    Enum.reduce(c, acc, fn y, acc ->
      score = score.(x, y)
      if score > acc, do: score, else: acc
    end)
  end)

IO.puts ans
