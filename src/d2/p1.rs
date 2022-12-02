pub fn run(input: &str) -> i64 {
    let mut ans: i64 = 0;
    let lines = input.lines();

    unsafe {
        for l in lines {
            let a = match l.get_unchecked(0..1) {
                "A" => 1,
                "B" => 2,
                _ => 3,
            };
            let b = match l.get_unchecked(2..3) {
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
    }

    ans
}
