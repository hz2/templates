//! Minimal usage example. Run with `cargo run --example basic`.

use rust_template::stats::{mean, variance};

fn main() {
    let xs = [1.0, 2.0, 3.0, 4.0];
    println!("mean = {:?}, variance = {:?}", mean(&xs), variance(&xs));
}
