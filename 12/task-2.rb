$dp = {}

def recurse(whole)
  line = whole[:str]
  test_arr = whole[:ans]
  if line.length == 0 && test_arr.length == 0
    return 1
  end
  return 0 if test_arr.length == 0 && line.any? {|x| x == '#'}

  return recurse({str: line[1..-1], ans: test_arr}) if line[0] == '.'

  if line[0] == '#' && line.length >= test_arr[0] && line[0..test_arr[0]-1].all? {|x| x != '.'} && line[test_arr[0]] != '#'
    return recurse({str: line[test_arr[0]+1..-1] || [], ans: test_arr[1..-1]})
  end

  if line[0] == '?'
    lhs = {str: ['.'] + line[1..-1] || [], ans: test_arr}
    rhs = {str: ['#'] + line[1..-1] || [], ans: test_arr}
    $dp[lhs] = recurse(lhs) unless $dp.key?(lhs)
    $dp[rhs] = recurse(rhs) unless $dp.key?(rhs)
    return $dp[lhs] + $dp[rhs]
  end
  return 0
end

tot = 0
File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  spl = line.split(' ')
  prob = ((spl[0].squeeze('.').split('') + ['?']) * 5)[0..-2]
  ans = spl[1].split(',').map(&:to_i) * 5
  tot += recurse({str: prob, ans: ans})
end

p tot
