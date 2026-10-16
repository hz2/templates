//! Integration tests: exercise the crate through its public api only.

use rust_template::stats::{mean, variance};

#[test]
fn variance_matches_definition() {
    let xs = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0];
    assert_eq!(mean(&xs), Some(5.0));
    assert_eq!(variance(&xs), Some(4.0));
}
