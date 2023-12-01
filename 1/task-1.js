const fs = require('fs');
const data = fs.readFileSync('input.txt').toString().split('\n');

const res = data.reduce((acc, line) => {
    const nums = line.match(/\d/g);
    return acc + parseInt(`${nums[0]}${nums[nums.length - 1]}`);
}, 0);

console.log(res);
