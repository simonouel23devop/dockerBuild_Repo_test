
import argparse
import logging


def build_parser() -> argparse.ArgumentParser:
    """Define the command-line options."""
    parser = argparse.ArgumentParser(description="A basic Python starter program.")
    parser.add_argument(
        "--name",
        default="Simon",
        help="Name to greet (default: Simon).",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Show debug messages.",
    )
    return parser


def greet(name: str) -> str:
    """Return a greeting for a non-empty name."""
    cleaned_name = name.strip()
    if not cleaned_name:
        raise ValueError("Name cannot be empty.")
    return f"Hello, {cleaned_name}!"


def main() -> int:
    """Run the program and return its process exit code."""
    args = build_parser().parse_args()
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(levelname)s: %(message)s",
    )

    try:
        message = greet(args.name)
    except ValueError as error:
        logging.error("%s", error)
        return 1

    logging.debug("Generated greeting successfully.")
    print(message)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
