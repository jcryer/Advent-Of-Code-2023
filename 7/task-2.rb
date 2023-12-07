lookup = {
  'A': 13,
  'K': 12,
  'Q': 11,
  'T': 9,
  '9': 8,
  '8': 7,
  '7': 6,
  '6': 5,
  '5': 4,
  '4': 3,
  '3': 2,
  '2': 1,
  'J': 0
}

def handType(hand)
  return 7 if hand == 'JJJJJ'

  uni = hand.gsub(/J/,'').chars.uniq.map {|c| hand.count(c)}.sort
  num_uniq = uni.length
  num_joker = hand.count('J')

  uni[-1] += num_joker

  return 7 if num_uniq == 1

  if (uni.length == 2)
    return 6 if uni[0] == 1 && uni[1] == 4
    return 5 if uni[0] == 2 && uni[1] == 3
  elsif (uni.length == 3)
    return 4 if uni[2] == 3
    return 3
  end

  return 2 if uni.length == 4
  return 1
end

def handScore(hand1, hand2, lookup) # returns 1 if hand1 bigger than hand2 else -1
  hand1.split('').each_with_index do |h, i|
    return 1 if lookup[h.to_sym] > lookup[hand2[i].to_sym]
    return -1 if lookup[h.to_sym] < lookup[hand2[i].to_sym]
  end
end

hands = []
File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  line_s = line.split(' ')
  hands.append({hand: line_s[0], type: handType(line_s[0]), score: line_s[1].to_i})
end

hands = hands.sort do |x, y|
  next 1 if x[:type] > y[:type]
  next -1 if x[:type] < y[:type]
  next handScore(x[:hand], y[:hand], lookup)
end

total = 0
hands.each_with_index do |h, i|
  total += (h[:score] * (i+1))
end
p total
