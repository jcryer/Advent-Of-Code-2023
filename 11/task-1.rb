class String
  def indices e
    start, result = -1, []
    result << start while start = (self.index e, start + 1)
    result.slice_when { |prev, curr| curr != prev.next }.to_a
  end
end

map = []
stars = []
void_rows = []
void_cols = []

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  map.append(line.split(''))
  (line.indices /#/).flatten.each { |v| stars.append({x: v, y: i})}
end

map.each_with_index {|r, i| void_rows.append(i) unless r.include? '#' }
map.transpose.each_with_index {|c, i| void_cols.append(i) unless c.include? '#' }

# p map
# puts stars
# p void_rows
# p void_cols

def calc_manh(s1, s2)
  (s1[:x] - s2[:x]).abs + (s1[:y] - s2[:y]).abs
end

def calc_offset(s1, s2, void_rows, void_cols)
  xs = [s1[:x], s2[:x]].sort
  ys = [s1[:y], s2[:y]].sort
  void_cols.filter { |c| c > xs[0] && c < xs[1] }.length + void_rows.filter { |r| r > ys[0] && r < ys[1] }.length
end

total = 0
(0..stars.length-1).each do |i|
  (i+1..stars.length-1).each do |j|
    total += calc_manh(stars[i], stars[j]) + (calc_offset(stars[i], stars[j], void_rows, void_cols) * 999999)
  end
end

p total
