total = 0
File.readlines('input.txt', chomp: true).each do |line|
  matches = /.+?(\d+): (.+)/.match(line)
  id = Integer(matches[1])

  failed = false
  attempts = matches[2].split('; ').each do |att|
    item = att.split(', ').map do |i| 
      vals = i.split(' ')
      [vals[1], Integer(vals[0])]
    end
    item = item.to_h
    if (item['red'] && item['red'] > 12) || (item['green'] && item['green'] > 13) || (item['blue'] && item['blue'] > 14)
      failed = true
      break
    end
  end
  total += id unless failed
end

puts total
