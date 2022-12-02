use std::fs;

mod d2 {
    pub mod p1;
    pub mod p2;
}

fn main() {
    let input =
        fs::read_to_string("src/d2/input.txt").expect("Something went wrong reading the file");
    println!("{}", d2::p1::run(&input));
}
