def reduce(ary, default=0)
  counter = 0
  accumulator = default

  while counter < ary.size
    accumulator = yield(accumulator, ary[counter])
    counter +=1
  end
  accumulator
end


array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }
p reduce(array, 10) { |acc, num| acc + num }
p reduce(array) { |acc, num| acc + num if num.odd? }
