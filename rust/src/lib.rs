//! A short description of `rust-template`.
//!
//! Replace this crate-level doc with an overview of what the crate does
//! and a minimal example. Math renders on docs.rs through KaTeX, inline
//! as $\bar{x}$ or as a display block:
//!
//! $$ \bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i $$
//!
//! # Examples
//!
//! ```
//! use rust_template::stats;
//!
//! assert_eq!(stats::mean(&[1.0, 2.0, 3.0]), Some(2.0));
//! ```
//!
//! # Features
//!
//! - `std` (default): enables `std` support. Without it the crate is
//!   `no_std`.

#![cfg_attr(not(any(feature = "std", test)), no_std)]
#![cfg_attr(docsrs, feature(doc_cfg))]

pub mod stats;
