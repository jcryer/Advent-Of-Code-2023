class String
  def indices e
    start, result = -1, []
    result << start while start = (self.index e, start + 1)
    result.slice_when { |prev, curr| curr != prev.next }.to_a
  end
end

map = []
width = 140
height = 140

numbers = []
File.readlines('input.txt', chomp: true).each_with_index do |line, l_n|
  map.append(line)
  matches = line.scan(/(\d+)/)
  indices = line.indices /\d/
  matches.each_with_index do |m, i|
    numbers.append({val: Integer(m[0]), row: l_n, cols: indices[i]})
  end
end

puts numbers
total = 0
numbers.each do |num|
  prep = num[:cols][0] == 0 ? [] : [num[:cols][0]-1]
  app = num[:cols][-1] == width-1 ? [] : [num[:cols][-1]+1]
  cols_to_check = prep + num[:cols] + app

  rows_to_check = [0]
  rows_to_check.append(-1) unless num[:row] == 0
  rows_to_check.append(1) unless num[:row] == height-1

  breaking = false
  rows_to_check.each do |row|
    cols_to_check.each do |col|
      if map[num[:row]+row][col].match?(/[^.\d]/)
        total += num[:val]
        breaking = true
        break
      end
    end
    break if breaking
  end
end

puts total
