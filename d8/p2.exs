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

    lc =
      Enum.reverse(l)
      |> Enum.reduce_while(0, fn c, acc ->
        if c < h do
          {:cont, acc + 1}
        else
          {:halt, acc + 1}
        end
      end)

    rc =
      Enum.reduce_while(r, 0, fn c, acc ->
        if c < h do
          {:cont, acc + 1}
        else
          {:halt, acc + 1}
        end
      end)

    tc =
      Enum.reverse(t)
      |> Enum.reduce_while(0, fn c, acc ->
        if c < h do
          {:cont, acc + 1}
        else
          {:halt, acc + 1}
        end
      end)

    bc =
      Enum.reduce_while(b, 0, fn c, acc ->
        if c < h do
          {:cont, acc + 1}
        else
          {:halt, acc + 1}
        end
      end)

    lc * rc * tc * bc
  end
end

r = Enum.to_list(0..(rows - 1))
c = Enum.to_list(0..(cols - 1))

ans =
  Enum.reduce(r, 0, fn x, acc ->
    Enum.reduce(c, acc, fn y, acc ->
      score = score.(x, y)

      if score > acc do
        score
      else
        acc
      end
    end)
  end)

IO.puts(ans)
