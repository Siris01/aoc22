pub fn run(input: &str) -> i64 {
    let mut ans: i64 = -1;
    let lines = input.lines();
    let mut current: i64 = 0;

    for l in lines {
        match l.parse::<i64>() {
            Ok(n) => current += n,
            Err(_) => {
                if current > ans {
                    ans = current;
                }
                current = 0;
            }
        }
    }

    ans
}
