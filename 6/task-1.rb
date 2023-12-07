time = []
dist = []
File.readlines('input.txt', chomp: true).each_with_index do |line, i|

  x = /.+:(.+)/.match(line)[1].split(' ').map(&:to_i)
  time = x if i == 0
  dist = x if i == 1
end

all_successes = 0

p time
p dist
time.each_with_index do |t, i|
  puts all_successes
  success = 0
  (1..t-1).each do |x|
    if (x * (t-x)) > dist[i]
      success += 1
    end
  end
  if all_successes == 0 
    all_successes = success 
  else
    all_successes *= success
  end
end

puts all_successes
