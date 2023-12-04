t1_total = 0
winnings = []

File.readlines('input.txt', chomp: true).each do |line|
  matches = /Card +(\d+): (.+) \| (.+)/.match(line)
  id = Integer(matches[1])
  winning = matches[2].split(' ').map(&:to_i)
  held = matches[3].split(' ').map(&:to_i)
  
  t1_line_val = 0
  line_val = 0
  winning.each do |w|
    if held.include?(w)
      t1_line_val = t1_line_val == 0 ? 1 : t1_line_val * 2
      line_val += 1
    end
  end
  winnings.append(line_val)
  t1_total += t1_line_val
end

puts t1_total

num_cards = Array.new(winnings.length, 1)

winnings.each_with_index do |w, i|
  (i+1..[i+w, winnings.length-1].min).each do |lil_iter|
    num_cards[lil_iter] += num_cards[i]
  end
end

puts num_cards.sum
