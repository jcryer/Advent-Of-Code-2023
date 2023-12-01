const fs = require('fs');
const data = fs.readFileSync('input.txt').toString().split('\n')
const lookup = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];

const res = data.reduce((acc, line) => {
  const nums = Array.from(line.matchAll(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/g), x => x[1])
  .map(n => {
    const loc = lookup.findIndex(x => x === n);
    if (loc === -1) return n;
    return loc+1;
  });
  return acc + parseInt(`${nums[0]}${nums[nums.length - 1]}`);
}, 0);

console.log(res);
