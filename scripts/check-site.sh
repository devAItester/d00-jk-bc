#!/usr/bin/env bash
set -euo pipefail

site_dir="${1:-_site}"
baseurl="${2:-}"

if [[ -z "$baseurl" ]]; then
  baseurl="$(sed -n 's/^baseurl:[[:space:]]*//p' _config.yml | head -n 1)"
fi

if [[ -z "$baseurl" ]]; then
  echo "Missing baseurl in _config.yml" >&2
  exit 1
fi

python3 - "$site_dir" "$baseurl" <<'PY'
import html.parser
import pathlib
import sys

site_dir = pathlib.Path(sys.argv[1])
baseurl = sys.argv[2].rstrip("/")

if not (site_dir / "index.html").is_file():
    raise SystemExit("Missing generated homepage: _site/index.html")

class MainListParser(html.parser.HTMLParser):
    def __init__(self):
        super().__init__()
        self.main_depth = 0
        self.ul_depth = 0
        self.links = []
        self.current_href = None
        self.current_text = []

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == "main":
            self.main_depth += 1
        elif self.main_depth and tag == "ul" and self.ul_depth == 0:
            self.ul_depth = 1
        elif self.ul_depth and tag == "ul":
            self.ul_depth += 1
        elif self.ul_depth and tag == "a" and self.ul_depth == 1:
            self.current_href = attrs.get("href")
            self.current_text = []

    def handle_data(self, data):
        if self.current_href is not None:
            self.current_text.append(data)

    def handle_endtag(self, tag):
        if tag == "a" and self.current_href is not None:
            self.links.append((self.current_href, "".join(self.current_text).strip()))
            self.current_href = None
            self.current_text = []
        elif tag == "ul" and self.ul_depth:
            self.ul_depth -= 1
        elif tag == "main" and self.main_depth:
            self.main_depth -= 1

html = (site_dir / "index.html").read_text(encoding="utf-8")
parser = MainListParser()
parser.feed(html)

actual = {href: title for href, title in parser.links if href}

expected = {}
for path in pathlib.Path(".").rglob("*.md"):
    if any(part in {".git", "_site"} for part in path.parts):
        continue
    if path.name == "README.md":
        continue

    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        continue

    frontmatter = text.split("\n---\n", 1)
    if len(frontmatter) != 2:
        continue

    title = None
    for line in frontmatter[0].splitlines()[1:]:
        if line.startswith("title:"):
            value = line.split(":", 1)[1].strip().strip("'").strip('"')
            if value:
                title = value
            break

    if not title:
        raise SystemExit(f"Missing non-empty front matter title: {path}")

    if path.as_posix() == "index.md":
        continue

    url_path = path.as_posix()[:-3] + ".html"
    expected[f"{baseurl}/{url_path}"] = title

missing = sorted(set(expected) - set(actual))
unexpected = sorted(set(actual) - set(expected))

if missing:
    print("Homepage list is missing:")
    for href in missing:
        print(f"  {href} — {expected[href]}")
if unexpected:
    print("Homepage list contains unexpected links:")
    for href in unexpected:
        print(f"  {href} — {actual[href]}")

if missing or unexpected:
    raise SystemExit(1)

print(f"Homepage list OK: {len(expected)} source pages are represented.")
PY
