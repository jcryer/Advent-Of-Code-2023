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

val = 0
path
curr_inst = 0
curr_node = "AAA"
while curr_node != "ZZZ"
  cmd = path[curr_inst % path.length]
  curr_node = map[curr_node][cmd == 'L' ? 0 : 1]
  val += 1
  curr_inst += 1
end

p val
