use std::fs;

mod d1 {
    pub mod p1;
    pub mod p2;
}

fn main() {
    let input =
        fs::read_to_string("src/d1/input.txt").expect("Something went wrong reading the file");
    println!("{}", d1::p2::run(&input));
}
