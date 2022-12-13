import fs from 'fs';

const compare = (left, right) => {
    if (typeof left === 'number' && typeof right !== 'number') left = [left];
    else if (typeof left !== 'number' && typeof right === 'number') right = [right];

    for (let i = 0; i < left.length; i++) {
        if (right[i] === undefined) return false;
        else if (left[i] === right[i]) continue;
        else if (typeof left[i] === 'number' && typeof right[i] === 'number') return left[i] < right[i];
        else {
            const res = compare(left[i], right[i]);
            if (res !== null) return res;
        }
    }
    if (right.length > left.length) return true;
    return null;
}

const file = fs.readFileSync('input.txt', 'utf8');
const ans = file.split('\n\n').map((pair, i) => compare(...pair.split('\n').map(JSON.parse)) ? (i + 1): 0).reduce((a, b) => a + b, 0);
console.log(ans);
