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
            let res = match l.get_unchecked(2..3) {
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
    }

    ans
}
