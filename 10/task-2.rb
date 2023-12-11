map = []
start = {x: 0, y: 0}

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  map.append(line)
  loc = line.index('S')
  unless loc == nil
    start = {x: loc, y: i}
  end
end

def next_tile(prev, curr, map)
  return nil if curr[:x] < 0 || curr[:x] >= map[0].length || curr[:y] < 0 || curr[:y] > map.length
  curr_tile = map[curr[:y]][curr[:x]]

  if curr_tile == '|'
    return {x: curr[:x], y: curr[:y]+1} if prev[:y] < curr[:y] && prev[:x] == curr[:x]
    return {x: curr[:x], y: curr[:y]-1} if prev[:y] > curr[:y] && prev[:x] == curr[:x]
  end

  if curr_tile == '-'
    return {x: curr[:x]+1, y: curr[:y]} if prev[:x] < curr[:x] && prev[:y] == curr[:y]
    return {x: curr[:x]-1, y: curr[:y]} if prev[:x] > curr[:x] && prev[:y] == curr[:y]
  end

  if curr_tile == 'L'
    return {x: curr[:x]+1, y: curr[:y]} if prev[:x] == prev[:x] && prev[:y] < curr[:y]
    return {x: curr[:x], y: curr[:y]-1} if prev[:x] > curr[:x] && prev[:y] == curr[:y]
  end

  if curr_tile == 'J'
    return {x: curr[:x], y: curr[:y]-1} if prev[:x] < curr[:x] && prev[:y] == curr[:y]
    return {x: curr[:x]-1, y: curr[:y]} if prev[:y] < curr[:y] && prev[:x] == curr[:x]
  end

  if curr_tile == '7'
    return {x: curr[:x], y: curr[:y]+1} if prev[:x] < curr[:x] && prev[:y] == curr[:y]
    return {x: curr[:x]-1, y: curr[:y]} if prev[:y] > curr[:y] && prev[:x] == curr[:x]
  end

  if curr_tile == 'F'
    return {x: curr[:x]+1, y: curr[:y]} if prev[:y] > curr[:y] && prev[:x] == curr[:x]
    return {x: curr[:x], y: curr[:y]+1} if prev[:x] > curr[:x] && prev[:y] == curr[:y]
  end

  return nil
end

def print_tile(val, map)
  p map[val[:y]][val[:x]]
end

back_to_s = false
final_loop_vals = []
# 0 is top, 1 is right, 2 is down, 3 is left
(0..3).each do |i|
  break if back_to_s

  prev = {x: start[:x], y: start[:y]}

  curr = {x: start[:x], y: start[:y]-1} if i == 0
  curr = {x: start[:x]+1, y: start[:y]} if i == 1
  curr = {x: start[:x], y: start[:y]+1} if i == 2
  curr = {x: start[:x]-1, y: start[:y]} if i == 3

  dist = 2
  loop_vals = [prev, curr]

  while true
    resp = next_tile(prev, curr, map)
    break if resp == nil
    loop_vals.append(resp)

    if map[resp[:y]][resp[:x]] == 'S'
      back_to_s = true
      final_loop_vals = loop_vals
      p dist/2
      break
    end

    prev = curr
    curr = resp
    dist += 1
  end
end

new_map = []

map.each_with_index do |row, i|
  new_row = ''
  row.split('').each_with_index do |item, j| 
    if final_loop_vals.any? { |v| v[:x] == j && v[:y] == i } || item == '.'
      if item == 'S'
        new_row += 'J' # hardcode S swap because I enjoy cheating
      else
        new_row += item
      end
    else
      new_row += '.'
    end
  end
  new_map.append(new_row)
end


def get_count(row)
  count = 0
  in_loop = false
  prev_curve = ''
  row.split('').each_with_index do |item, i|
    count += 1 if item == '.' && in_loop
    prev_curve = item if item == 'F' || item == 'L'
    if item == '7'
      prev_curve == 'F' ? prev_curve = '' : in_loop = !in_loop
    end
    if item == 'J'
      prev_curve == 'L' ? prev_curve = '' : in_loop = !in_loop
    end
    in_loop = !in_loop if item == '|' 
  end
  count
end

tot = 0
new_map.each { |row| tot += get_count(row) }

p tot
