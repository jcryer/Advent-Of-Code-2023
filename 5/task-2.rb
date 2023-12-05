maps = []
seed_ranges = []

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  if i == 0
    seeds = line.split(': ')[1].split(' ').map(&:to_i)
    seeds.each_with_index do |t, i|
      if i % 2 != 0
        seed_ranges.append({start: seeds[i-1], end: seeds[i-1]+seeds[i]-1})
      end
    end
    next
  end

  maps.append([]) if line.include? '-to-'
  match = /(\d+) (\d+) (\d+)/.match(line)

  maps[-1].append({transpose: match[1].to_i - match[2].to_i,
                   source_start: match[2].to_i, 
                   source_end: match[2].to_i + match[3].to_i-1}) if match
end

maps.each do |map|
  local_seed_ranges = seed_ranges.map(&:clone)

  while local_seed_ranges.length > 0
    seed_range = local_seed_ranges.shift
    map.each do |map_item|
      next if (seed_range[:start] > map_item[:source_end] || seed_range[:end] < map_item[:source_start])

      seed_ranges = seed_ranges.select {|s| !(s[:start] == seed_range[:start] && s[:end] == seed_range[:end])}
      overlap_start = [seed_range[:start], map_item[:source_start]].max
      overlap_end = [seed_range[:end], map_item[:source_end]].min

      if (seed_range[:start] < overlap_start)
        before_overlap = {start: seed_range[:start], end: overlap_start-1}
        seed_ranges.append(before_overlap)
        local_seed_ranges.append(before_overlap)
      end

      if (seed_range[:end] > overlap_end)
        after_overlap = {start: overlap_end+1, end: seed_range[:end]}
        seed_ranges.append(after_overlap)
        local_seed_ranges.append(after_overlap)
      end

      if (overlap_start <= overlap_end)
        overlap = {start: overlap_start, end: overlap_end}
        seed_ranges.append(overlap)
        seed_ranges[-1][:start] += map_item[:transpose]
        seed_ranges[-1][:end] += map_item[:transpose]
      end
    end
  end
end

min_val = 10000000000

seed_ranges.each { |x| min_val = x[:start] if x[:start] < min_val }
puts min_val
