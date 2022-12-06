buffer = File.read("input.txt")
i=0
arr=Array(Char).new 

buffer.each_char do |char|
  if i >= 14
    arr.delete_at(0)
  end
  arr << char
  if arr.to_set().size == 14
    puts i+1
    break
  end
  i += 1
end