val = 0
File.readlines('input.txt', chomp: true).each do |line|
  seqs = []
  seqs.append(line.split(' ').map(&:to_i))

  while !seqs[-1].all? { |n| n == 0 }
   seqs.append(seqs[-1].map.with_index { |n, i| i == 0 ? nil : n - seqs[-1][i-1] }.compact)
  end

  (seqs.length-1).downto(1).each { |i| seqs[i-1].append(seqs[i-1][-1] + seqs[i][-1]) }
  val += seqs[0][-1]
end

p val
