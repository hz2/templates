# templates

Project templates, one self-contained directory per language. Each is a
nix flake template, so you copy only the part you need.

| template | contents |
|----------|----------|
| [`rust`](rust) | library crate: crane + rust-overlay flake, pinned toolchain, clippy pedantic, cargo-deny/audit, llvm-cov + codecov, criterion, KaTeX docs, release-plz |

## Using a template

With nix (copies just that directory):

```sh
nix flake new -t github:hz2/templates#rust my-crate
cd my-crate && sh init.sh my-crate && git init && git add -A
nix flake check -L
```

Without nix:

```sh
curl -L https://codeload.github.com/hz2/templates/tar.gz/main \
  | tar -xz --strip-components=2 templates-main/rust
```

Or a sparse clone, to track the template itself:

```sh
git clone --filter=blob:none --sparse https://github.com/hz2/templates
cd templates && git sparse-checkout set rust
```

## Adding a template

Create `<lang>/` with its own `flake.nix`, register it under `templates`
in the root `flake.nix`, and add a row above.
