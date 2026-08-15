# afterFileEdit hook: fail-open UTF-8 check. ASCII-only source.
from __future__ import annotations

import json
import sys
from pathlib import Path

EXTS = {".R", ".Rmd", ".qmd", ".md", ".mdc", ".yml", ".yaml"}
FFFD = "\ufffd"


def read_payload() -> dict:
    raw = sys.stdin.buffer.read()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    if not raw.strip():
        return {}
    text = raw.decode("utf-8", errors="strict")
    if text.startswith("\ufeff"):
        text = text[1:]
    return json.loads(text)


def diagnose(path: Path) -> str | None:
    if path.suffix not in EXTS or not path.is_file():
        return None
    data = path.read_bytes()
    if data.startswith(b"\xef\xbb\xbf"):
        data = data[3:]
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError as exc:
        return f"invalid UTF-8 in {path.as_posix()}: {exc}"
    n = text.count(FFFD)
    if n:
        return f"U+FFFD in {path.as_posix()} count={n}"
    return None


def main() -> int:
    try:
        payload = read_payload()
    except (UnicodeDecodeError, json.JSONDecodeError, OSError):
        sys.stdout.write("{}\n")
        return 0
    file_path = payload.get("file_path") or ""
    if not file_path:
        sys.stdout.write("{}\n")
        return 0
    problem = diagnose(Path(file_path))
    if not problem:
        sys.stdout.write("{}\n")
        return 0
    ctx = (
        "UTF-8 check failed after this edit: "
        + problem
        + ". Do not open-save the file. Restore Chinese from the last valid "
        + "git UTF-8 blob (see .cursor/skills/techme-encoding-utf8/SKILL.md). "
        + "Rewrite with UTF-8 bytes only; never errors='replace'."
    )
    sys.stdout.write(json.dumps({"additional_context": ctx}, ensure_ascii=True) + "\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
