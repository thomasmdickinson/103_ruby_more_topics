array = [1, 2, 3, 4, 5]

def select(ary)
  counter = 0
  new_ary = []
  while counter < ary.size
    new_ary << ary[counter] if yield(ary[counter])
    counter +=1
  end
  new_ary
end

puts "existing select method"
puts "---------------------"
p array.select{ |num| num.odd? }
p array.select{ |num| puts num }
p array.select{ |num| num + 1 }
puts ''
puts "my select method"
puts "---------------------"
p select(array) { |num| num.odd? }
p select(array) { |num| puts num }
p select(array) { |num| num + 1 }
