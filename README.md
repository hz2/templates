# templates

Project templates with one self-contained directory per language. Each flake template carries
its own build, tooling and checks, so a project can be created without inheriting this repository.

| template | use |
|---|---|
| `rust` | Library crate with a pinned toolchain, tests, linting, coverage, benchmarks, docs and release tooling |
| `typst` | Paper and notes templates with Ipe and native Cetz diagrams |
| `latex` | Paper and notes templates with an Ipe diagram workflow |

## Create a project

With Nix, choose one template:

```sh
nix flake new -t github:hz2/templates#rust my-crate
```

```sh
nix flake new -t github:hz2/templates#typst my-paper
```

```sh
nix flake new -t github:hz2/templates#latex my-paper
```

For the Rust template, rename the crate and initialize its files:

```sh
cd my-crate
sh init.sh my-crate
git init && git add -A
nix flake check -L
```

For Typst and LaTeX projects, enter the dev shell and build either the paper or notes entrypoint:

```sh
cd my-paper
nix develop
make build
make notes
```

The first Typst build downloads packages from its package registry. See each template's README
for its tools, output files, and diagram workflow.

## Develop a template

Each directory is independently instantiable with `nix flake new -t .#<name> <directory>`.
Keep changes and language-specific dependencies inside that directory. Register new templates
in the root `flake.nix`, document them in this table, and cover instantiation in the root CI.

The original Rust, Typst and LaTeX repository histories are preserved as merge parents.
