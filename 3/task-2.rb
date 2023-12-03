class String
  def indices e
    start, result = -1, []
    result << start while start = (self.index e, start + 1)
    result.slice_when { |prev, curr| curr != prev.next }.to_a
  end
end

width = 140
height = 140

numbers = []
gears = []
File.readlines('input.txt', chomp: true).each_with_index do |line, l_n|
  num_matches = line.scan /(\d+)/
  num_indices = line.indices /\d/
  num_matches.each_with_index do |m, i|
    numbers.append({val: Integer(m[0]), row: l_n, cols: num_indices[i]})
  end

  gear_matches = line.scan /\*/
  gear_indices = line.indices  /\*/
  gear_matches.each_with_index do |m, i|
    gears.append({row: l_n, col: gear_indices[i][0]})
  end
end

total = 0
gears.each do |gear|
  prep = gear[:col] == 0 ? [] : [gear[:col]-1]
  app = gear[:col] == width-1 ? [] : [gear[:col]+1]
  cols_to_check = prep + [gear[:col]] + app

  rows_to_check = [0]
  rows_to_check.append(-1) unless gear[:row] == 0
  rows_to_check.append(1) unless gear[:row] == height-1

  breaking = false
  numbers_for_gear = []

  rows_to_check.each do |row|
    cols_to_check.each do |col|
      # go through all numbers to check if they are next to gear
      numbers.each do |num|
        if num[:row] == gear[:row]+row && num[:cols].include?(col) && !numbers_for_gear.include?(num)
          if numbers_for_gear.length == 2
            breaking = true
            break
          end
          numbers_for_gear.append(num)
        end
      end
      break if breaking
    end
    break if breaking
  end
  break if breaking
  if numbers_for_gear.length == 2
    total += numbers_for_gear[0][:val] * numbers_for_gear[1][:val]
  end
end

puts total

# for each gear:
#   Make list of all adjacent numbers
#   If exactly two numbers in list, multiply then add to total
