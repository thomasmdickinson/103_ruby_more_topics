def each(arr)
  counter = 0
  while counter < arr.size
    yield(arr[counter])
    counter +=1
  end
  arr
end

my_arr = [1, 2, 3]

each(my_arr) { |num| puts "It's #{num}!"}
