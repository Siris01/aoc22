pub fn run(input: &str) -> i64 {
    let mut ans: i64 = -1;
    let lines = input.lines();
    let mut current: i64 = 0;

    for l in lines {
        let n = l.parse::<i64>();
        if n.is_err() {
            if current > ans {
                ans = current;
            }
            current = 0;
        } else {
            current = current + n.unwrap();
        }
    }

    ans
}
