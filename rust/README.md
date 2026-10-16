# rust-template

[![CI](https://github.com/hz2/rust-template/actions/workflows/ci.yml/badge.svg)](https://github.com/hz2/rust-template/actions/workflows/ci.yml)
[![crates.io](https://img.shields.io/crates/v/rust-template.svg)](https://crates.io/crates/rust-template)
[![docs.rs](https://img.shields.io/docsrs/rust-template)](https://docs.rs/rust-template)
[![codecov](https://codecov.io/gh/hz2/rust-template/graph/badge.svg)](https://codecov.io/gh/hz2/rust-template)
[![MSRV](https://img.shields.io/crates/msrv/rust-template)](Cargo.toml)
[![license](https://img.shields.io/crates/l/rust-template.svg)](#license)

A short description of rust-template.

```toml
[dependencies]
rust-template = "0.1"
```

```rust
use rust_template::stats;

assert_eq!(stats::mean(&[1.0, 2.0, 3.0]), Some(2.0));
```

## Development

Everything runs inside the nix dev shell (`nix develop`, or `direnv allow`
once), which provides the pinned toolchain from `rust-toolchain.toml` and
every tool the recipes below need. Without nix, rustup reads the same
`rust-toolchain.toml`; install the extra tools with cargo.

| command            | does                                                   |
|--------------------|--------------------------------------------------------|
| `just check`       | fmt, clippy, tests: the fast pre-push gate             |
| `just test`        | unit, integration, and doc tests                       |
| `just doc --open`  | docs with KaTeX math, as docs.rs renders them          |
| `just cov`         | line coverage via `cargo-llvm-cov` (`cov-html` to browse) |
| `just bench`       | criterion benchmarks                                   |
| `just deny`        | licenses, bans, sources, advisories                    |
| `just semver`      | public api breakage vs the last release                |
| `just ci`          | `nix flake check`: everything ci runs, hermetically    |

`nix flake check` is the single source of truth: fmt (rust, toml, nix),
clippy, tests, docs with `--deny warnings`, cargo-deny, cargo-audit, the
MSRV build, a no-default-features build, coverage, and a benchmark smoke
run. CI runs it on Linux and macOS, plus a plain `cargo test` on Windows.

### Math in docs

`katex-header.html` is injected into every rustdoc page, both locally
(`just doc`) and on docs.rs (`package.metadata.docs.rs`). Inline math uses
`$...$`, display math `$$...$$`. Rustdoc parses markdown before KaTeX
runs, so write `\\` as `\\\\` and avoid `*` inside math (use `\ast`).

### Releasing

Commits follow [Conventional Commits](https://www.conventionalcommits.org).
[release-plz](https://release-plz.dev) keeps a release PR open that bumps the
version and updates `CHANGELOG.md`; merging it tags, creates a GitHub
release, and publishes to crates.io.

One-time setup:

1. Publish `0.1.0` by hand with `cargo publish` (crates.io cannot trust a
   crate that does not exist yet).
2. On crates.io, add a trusted publisher for this repo, workflow
   `release-plz.yml`, environment `release`.
3. Enable "Allow GitHub Actions to create and approve pull requests" in the
   repo settings. Optionally add a `RELEASE_PLZ_TOKEN` secret (fine-grained
   PAT) so release PRs trigger CI.
4. Sign in to [Codecov](https://codecov.io) with GitHub and enable the repo;
   uploads authenticate with OIDC, so no token secret is needed.

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))
- MIT license ([LICENSE-MIT](LICENSE-MIT))

at your option.

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in the work by you, as defined in the Apache-2.0
license, shall be dual licensed as above, without any additional terms or
conditions.
