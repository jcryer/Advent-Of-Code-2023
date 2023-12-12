def recurse(line, test_arr)
  if line.length == 0 && test_arr.length == 0
    return 1
  end
  return 0 if test_arr.length == 0 && line.any? {|x| x == '#'}

  return recurse(line[1..-1], test_arr) if line[0] == '.'

  if line[0] == '#' && line.length >= test_arr[0] && line[0..test_arr[0]-1].all? {|x| x != '.'} && line[test_arr[0]] != '#'
    return recurse(line[test_arr[0]+1..-1] || [], test_arr[1..-1])
  end

  if line[0] == '?'
    return recurse(['.'] + line[1..-1] || [], test_arr) + recurse(['#'] + line[1..-1] || [], test_arr)
  end
  return 0
end

tot = 0
File.readlines('test_input.txt', chomp: true).each_with_index do |line, i|
  spl = line.split(' ')
  prob = spl[0].squeeze('.').split('')
  ans = spl[1].split(',').map(&:to_i)
  val = recurse(prob, ans)
  p val
  tot += val
end

p tot

