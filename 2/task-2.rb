total = 0
File.readlines('input.txt', chomp: true).each do |line|
  matches = /.+?(\d+): (.+)/.match(line)
  id = Integer(matches[1])
  maxRed = 0;
  maxGreen = 0;
  maxBlue = 0;
  attempts = matches[2].split('; ').each do |att|
    item = att.split(', ').map do |i| 
      vals = i.split(' ')
      [vals[1], Integer(vals[0])]
    end
    item = item.to_h
    maxRed = item['red']if item['red'] && item['red'] > maxRed
    maxGreen = item['green']if item['green'] && item['green'] > maxGreen
    maxBlue = item['blue']if item['blue'] && item['blue'] > maxBlue
  end
  total += maxRed * maxGreen * maxBlue
end

puts total
