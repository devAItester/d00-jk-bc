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
from collections import Counter

site_dir = pathlib.Path(sys.argv[1])
baseurl = sys.argv[2].rstrip("/")

if not (site_dir / "index.html").is_file():
    raise SystemExit("Missing generated homepage: _site/index.html")

class Parser(html.parser.HTMLParser):
    def __init__(self):
        super().__init__()
        self.main = 0
        self.ul = 0
        self.href = None
        self.text = []
        self.links = []

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == "main":
            self.main += 1
        elif self.main and tag == "ul" and self.ul == 0:
            self.ul = 1
        elif self.ul and tag == "ul":
            self.ul += 1
        elif self.ul == 1 and tag == "a":
            self.href = attrs.get("href")
            self.text = []

    def handle_data(self, data):
        if self.href is not None:
            self.text.append(data)

    def handle_endtag(self, tag):
        if tag == "a" and self.href is not None:
            self.links.append((self.href, "".join(self.text).strip()))
            self.href = None
            self.text = []
        elif tag == "ul" and self.ul:
            self.ul -= 1
        elif tag == "main" and self.main:
            self.main -= 1

parser = Parser()
parser.feed((site_dir / "index.html").read_text(encoding="utf-8"))
actual = {href: title for href, title in parser.links if href}

source_titles = []
source_modes = {}
for path in pathlib.Path(".").rglob("*.md"):
    if any(part in {".git", "_site"} for part in path.parts) or path.name in {"README.md", "404.html"}:
        continue
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        continue
    fm = text.split("\n---\n", 1)
    if len(fm) != 2:
        continue
    title = None
    for line in fm[0].splitlines()[1:]:
        if line.startswith("title:"):
            value = line.split(":", 1)[1].strip().strip("'").strip('"')
            if value:
                title = value
            break
    if not title:
        raise SystemExit(f"Missing non-empty front matter title: {path}")
    if path.as_posix() != "index.md":
        source_titles.append(title)
        source_modes[title] = path.name == "index.md"

if Counter(source_titles) != Counter(actual.values()):
    raise SystemExit(
        "Homepage links do not represent exactly the source pages.\n"
        f"source={sorted(source_titles)}\nactual={sorted(actual.values())}"
    )

def output_for(href):
    if not href.startswith(baseurl + "/"):
        return None
    rel = href[len(baseurl):].lstrip("/")
    if not rel:
        return site_dir / "index.html"
    if rel.endswith("/"):
        return site_dir / rel / "index.html"
    return site_dir / rel

for href, title in actual.items():
    output = output_for(href)
    if output is None or not output.is_file():
        raise SystemExit(f"No generated HTML for homepage link: {href} ({title})")
    if href.endswith("/") and not source_modes.get(title, False):
        raise SystemExit(f"Non-index page has a directory URL: {href} ({title})")

index_outputs = [p for p in site_dir.rglob("index.html") if p.is_file()]
if index_outputs != [site_dir / "index.html"]:
    raise SystemExit(
        "Unexpected index.html outputs: "
        + ", ".join(str(p) for p in sorted(index_outputs))
    )

for href, title in actual.items():
    if href != baseurl + "/" and not href.endswith(".html"):
        raise SystemExit(f"Non-index page URL does not end in .html: {href} ({title})")

print(f"Generated page URLs OK: {len(actual)} pages resolve to HTML output; only the site root is index.html.")
PY
