path = []
map = {}

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  if i == 0
    path = line.split('')
    next
  end
  next if i == 1

  matches = /(.+) = \((.+), (.+)\)/.match(line)
  map[matches[1]] = [matches[2], matches[3]]
end

def get_path_len(start_node, path, map)
  curr_node = start_node
  curr_inst = 0
  while curr_node[-1] != 'Z'
    cmd = path[curr_inst % path.length]
    curr_node = map[curr_node][cmd == 'L' ? 0 : 1]
    curr_inst += 1
  end
  curr_inst
end

p map.select { |k, v| k[-1] == 'A' }.map { |s| get_path_len(s[0], path, map)}.reduce(1, :lcm)
