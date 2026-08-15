# Check tracked or given text files are UTF-8 without U+FFFD.
# ASCII-only source so this script cannot mojibake itself.
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

EXTS = {".R", ".Rmd", ".qmd", ".md", ".mdc", ".yml", ".yaml"}
FFFD = "\ufffd"


def iter_paths(explicit: list[str]) -> list[Path]:
    if explicit:
        return [Path(p) for p in explicit]
    tracked = subprocess.check_output(["git", "ls-files"], text=True).splitlines()
    return [Path(p) for p in tracked if Path(p).suffix in EXTS]


def check(path: Path) -> str | None:
    if not path.is_file():
        return f"missing: {path.as_posix()}"
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
        bom = True
    else:
        bom = False
    try:
        text = raw.decode("utf-8")
    except UnicodeDecodeError as exc:
        return f"invalid-utf8: {path.as_posix()} ({exc})"
    n = text.count(FFFD)
    if n:
        return f"u+fffd: {path.as_posix()} count={n}"
    if bom:
        return f"utf-8-bom: {path.as_posix()}"
    return None


def main() -> int:
    parser = argparse.ArgumentParser(description="Verify UTF-8 source files.")
    parser.add_argument("paths", nargs="*", help="Files to check; default: git-tracked text")
    parser.add_argument(
        "--strict-bom",
        action="store_true",
        help="Treat UTF-8 BOM as failure (default: warn only)",
    )
    args = parser.parse_args()
    problems = [msg for path in iter_paths(args.paths) if (msg := check(path))]
    fatal = [m for m in problems if not m.startswith("utf-8-bom:")]
    boms = [m for m in problems if m.startswith("utf-8-bom:")]
    if boms:
        sys.stderr.write("\n".join(boms) + "\n")
    if fatal or (args.strict_bom and boms):
        sys.stderr.write("\n".join(fatal) + "\n")
        return 1
    print("utf-8 ok", len(iter_paths(args.paths)), "files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
