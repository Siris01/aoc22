pub fn run(input: &str) -> i64 {
    let mut ans: [i64; 3] = [-1; 3];
    let lines = input.lines();
    let mut current: i64 = 0;

    for l in lines {
        let n = l.parse::<i64>();
        if n.is_err() {
            if current <= ans[2] {
                current = 0;
                continue;
            } else if current <= ans[1] {
                ans[2] = current;
                current = 0;
                continue;
            } else if current <= ans[0] {
                ans[2] = ans[1];
                ans[1] = current;
                current = 0;
                continue;
            } else {
                ans[2] = ans[1];
                ans[1] = ans[0];
                ans[0] = current;
                current = 0;
                continue;
            }
        } else {
            current = current + n.unwrap();
        }
    }

    ans.iter().sum()
}
