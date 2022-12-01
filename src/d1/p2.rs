pub fn run(input: &str) -> i64 {
    const TOP: usize = 3;
    let mut ans: [i64; TOP] = [-1; TOP];
    let lines = input.lines();
    let mut current: i64 = 0;

    for l in lines {
        if let Ok(n) = l.parse::<i64>() {
            current += n;
            continue;
        }

        if current < ans[0] {
            current = 0;
            continue;
        }

        let mut shift_num = 0;

        for i in 1..(TOP + 1) {
            match ans.get(i) {
                Some(&n) => {
                    if current < n {
                        shift_num = i;
                        break;
                    }
                }
                None => {
                    shift_num = TOP;
                    break;
                }
            }
        }

        for i in 0..(shift_num - 1) {
            ans[i] = ans[i + 1];
        }

        ans[shift_num - 1] = current;
        current = 0;
    }

    ans.iter().sum()
}
