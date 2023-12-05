
seeds = []
maps = []

File.readlines('test_input.txt', chomp: true).each_with_index do |line, i|
  if i == 0
    seeds = line.split(': ')[1].split(' ').map(&:to_i)
    next
  end

  maps.append([]) if line.include? '-to-'
  match = /(\d+) (\d+) (\d+)/.match(line)
  maps[-1].append({dest: match[1].to_i, source: match[2].to_i, range: match[3].to_i}) if match
end

min_loc = 1000000000

seeds.each_with_index do |seed, i|
  maps.each do |map|
    map.each do |map_item|
      diff = seeds[i] - map_item[:source]
      if diff >= 0 && diff < map_item[:range]
        seeds[i] = map_item[:dest] + diff
        break
      end
    end
  end
end

p seeds.min
