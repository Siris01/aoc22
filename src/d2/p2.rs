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
        let res = match itr.next().unwrap() {
            "X" => 0,
            "Y" => 3,
            _ => 6,
        };

        let b = match res {
            0 => {
                let r = a - 1;
                if r == 0 {
                    3
                } else {
                    r
                }
            }
            6 => {
                let r = a + 1;
                if r == 4 {
                    1
                } else {
                    r
                }
            }
            _ => a,
        };

        ans += b + res;
    }

    ans
}
