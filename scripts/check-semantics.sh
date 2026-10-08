#!/usr/bin/env bash
set -euo pipefail

site_dir="${1:-_site}"

python3 - "$site_dir" <<'PY'
import html.parser
import pathlib
import re
import sys

site_dir = pathlib.Path(sys.argv[1])
if not site_dir.is_dir():
    raise SystemExit(f"Missing generated site: {site_dir}")

class PageParser(html.parser.HTMLParser):
    def __init__(self):
        super().__init__()
        self.counts = {tag: 0 for tag in ("header", "nav", "main", "footer")}
        self.main_depth = 0
        self.main_text = []
        self.headings = []

    def handle_starttag(self, tag, attrs):
        if tag in self.counts:
            self.counts[tag] += 1
        if tag == "main":
            self.main_depth += 1
        if self.main_depth and re.fullmatch(r"h[1-6]", tag):
            self.headings.append((int(tag[1]), []))

    def handle_data(self, data):
        if self.main_depth:
            self.main_text.append(data)
            if self.headings:
                self.headings[-1][1].append(data)

    def handle_endtag(self, tag):
        if tag == "main" and self.main_depth:
            self.main_depth -= 1

def normalized(text):
    return re.sub(r"\s+", " ", text).strip()

def source_heading_levels(source):
    levels = []
    for line in source.splitlines():
        match = re.match(r"^(#{1,6})\s+", line)
        if match:
            levels.append(len(match.group(1)))
    return levels

failures = []
source_root = pathlib.Path(".")

for path in sorted(site_dir.rglob("*.html")):
    html = path.read_text(encoding="utf-8")
    parser = PageParser()
    parser.feed(html)
    for tag, count in parser.counts.items():
        if count != 1:
            failures.append(f"{path}: expected exactly one <{tag}>, found {count}")
    if not normalized(" ".join(parser.main_text)):
        failures.append(f"{path}: <main> is empty")
    levels = [level for level, _ in parser.headings]
    if levels and levels[0] != 1:
        failures.append(f"{path}: first main heading is h{levels[0]}, expected h1")
    for previous, current in zip(levels, levels[1:]):
        if current > previous + 1:
            failures.append(f"{path}: heading jump h{previous} -> h{current}")

for source_path in sorted(source_root.rglob("*.md")):
    if any(part in {".git", "_site"} for part in source_path.parts) or source_path.name == "README.md":
        continue
    source = source_path.read_text(encoding="utf-8")
    if not source.startswith("---\n") or "layout: default" not in source:
        continue
    match = re.search(r"^permalink:\s*(.+)$", source, re.MULTILINE)
    if not match:
        continue
    output = site_dir / match.group(1).strip().lstrip("/")
    if not output.is_file():
        failures.append(f"{source_path}: generated page missing: {output}")
        continue
    parser = PageParser()
    parser.feed(output.read_text(encoding="utf-8"))
    actual = [level for level, _ in parser.headings]
    expected = source_heading_levels(source)
    if expected and actual != expected:
        failures.append(f"{source_path}: heading levels changed: expected {expected}, actual {actual}")
    elif not expected and actual not in ([], [1]):
        failures.append(f"{source_path}: unexpected generated heading levels: {actual}")

if failures:
    print("\n".join(failures))
    raise SystemExit(1)

print(f"Semantic HTML OK: {len(list(site_dir.rglob('*.html')))} generated HTML pages checked.")
PY
