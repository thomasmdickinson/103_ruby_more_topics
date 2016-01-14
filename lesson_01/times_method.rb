def times(number)
  counter = 0
  while counter < number
    yield(counter)
    counter += 1
  end
  num
end

times(5) do |num|
  puts num
end
