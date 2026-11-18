import argparse


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="A small Python CLI")
    parser.add_argument("name", nargs="?", default="world")
    args = parser.parse_args(argv)
    print(f"Hello, {args.name}!")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
