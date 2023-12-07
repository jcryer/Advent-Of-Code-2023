time = 0
dist = 0
File.readlines('test_input.txt', chomp: true).each_with_index do |line, i|

  x = /.+:(.+)/.match(line)[1].gsub(/\s+/, "").to_i
  time = x if i == 0
  dist = x if i == 1
end

p time
p dist

success = 0
(1..time-1).each do |x|
  if (x * (time-x)) > dist
    success += 1
  end
end

p success
