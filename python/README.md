# python-template

A small Python app and CLI template. Runtime code uses only the standard library.

## Development

Python 3.12 or newer, pytest, and ruff are the only tools needed. They are available in the
Nix dev shell (`nix develop`) or can be provided by an offline development environment.
Run checks from the repository root without installing the project:

```sh
python -m pytest -q
ruff check .
ruff format --check .
```

`nix flake check` runs the same checks. To run the CLI directly, set `PYTHONPATH=src`:

```sh
PYTHONPATH=src python -m python_template Ada
```

Commits follow Conventional Commits.
