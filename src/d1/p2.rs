pub fn run(input: &str) -> i64 {
    const TOP: usize = 3;
    let mut ans: [i64; TOP] = [-1; TOP];
    let lines = input.lines();
    let mut current: i64 = 0;

    for l in lines {
        let n = l.parse::<i64>();
        if n.is_ok() {
            current += n.unwrap();
            continue;
        }

        if current < ans[0] {
            current = 0;
            continue;
        }

        let mut shift_num = 0;

        for i in 1..(TOP + 1) {
            let c = ans.get(i);
            if c.is_none() {
                shift_num = TOP;
                break;
            }
            let c = c.unwrap();

            if current < *c {
                shift_num = i;
                break;
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
