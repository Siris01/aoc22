pub fn run(input: &str) -> i64 {
    let mut ans: i64 = 0;
    let lines = input.lines();

    for l in lines {
        let mut itr = l.split_whitespace();

        let a = match itr.next().unwrap() {
            "A" => 1,
            "B" => 2,
            _ => 3,
        };
        let b = match itr.next().unwrap() {
            "X" => 1,
            "Y" => 2,
            _ => 3,
        };

        let res = match a - b {
            0 => 3,
            -1 | 2 => 6,
            _ => 0,
        };

        ans += b + res;
    }

    ans
}
