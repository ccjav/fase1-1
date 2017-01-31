def shuffle(array)
  # array.shuffle
  i = 1
  # new_array = []
  while i <= array.length
    random = array[0..array.length - i].sample
    temp = array[-i]
    array[-i] = random
    array[array.index(random)] = temp
    i += 1
  end
  array
end


array = (1..15).to_a

p shuffle(array)

10.times do |variable|
    raise "No esta revolviendo bien" if shuffle(array) == shuffle(array)
end
p true