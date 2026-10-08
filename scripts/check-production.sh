#!/usr/bin/env bash
set -euo pipefail

base="${1:?production URL is required}"
base="${base%/}"

python3 - "$base" <<'PY'
import html.parser
import sys
import time
import urllib.request
import urllib.error
import urllib.parse

base = sys.argv[1]

class Parser(html.parser.HTMLParser):
    def __init__(self):
        super().__init__()
        self.main = 0
        self.ul = 0
        self.links = []
    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == "main":
            self.main += 1
        elif self.main and tag == "ul" and self.ul == 0:
            self.ul = 1
        elif self.ul and tag == "ul":
            self.ul += 1
        elif self.ul == 1 and tag == "a" and attrs.get("href"):
            self.links.append(attrs["href"])
    def handle_endtag(self, tag):
        if tag == "ul" and self.ul:
            self.ul -= 1
        elif tag == "main" and self.main:
            self.main -= 1

def fetch(url):
    request = urllib.request.Request(url, headers={"User-Agent": "flatfiletxtdb-production-check"})
    last = None
    for attempt in range(1, 13):
        try:
            with urllib.request.urlopen(request, timeout=20) as response:
                return response.status, response.geturl(), response.headers.get("content-type", ""), response.read()
        except urllib.error.HTTPError as exc:
            if exc.code == 404:
                raise
            last = exc
            if attempt == 12:
                raise
            time.sleep(5)
    raise last

try:
    status, final, content_type, body = fetch(base + "/")
except urllib.error.HTTPError as exc:
    raise SystemExit(f"Homepage failed: HTTP {exc.code}: {base}/")
if status < 200 or status >= 400:
    raise SystemExit(f"Homepage failed: HTTP {status}: {base}/")
if b"<main" not in body:
    raise SystemExit("Homepage does not contain <main>")

try:
    index_status, index_final, index_content_type, index_body = fetch(base + "/index.html")
except urllib.error.HTTPError as exc:
    raise SystemExit(f"Root index.html failed: HTTP {exc.code}: {base}/index.html")
if index_status < 200 or index_status >= 400 or not index_body:
    raise SystemExit(f"Root index.html failed: HTTP {index_status}: {base}/index.html")

parser = Parser()
parser.feed(body.decode("utf-8", "replace"))

urls = []
for href in parser.links:
    urls.append(urllib.parse.urljoin(base + "/", href))

urls = list(dict.fromkeys(urls))
if not urls:
    raise SystemExit("No navigation URLs found on production homepage")

missing = base + "/this-page-must-not-exist-404-check.html"
try:
    fetch(missing)
except urllib.error.HTTPError as exc:
    if exc.code != 404:
        raise SystemExit(f"Expected HTTP 404 for missing page, got {exc.code}: {missing}")
else:
    raise SystemExit(f"Expected HTTP 404 for missing page: {missing}")

for url in urls:
    status, final, content_type, body = fetch(url)
    if status < 200 or status >= 400:
        raise SystemExit(f"Production URL failed: HTTP {status}: {url}")
    if not body:
        raise SystemExit(f"Production URL returned an empty body: {url}")

print(f"Production smoke test OK: {len(urls)} navigation URLs returned HTTP 2xx/3xx.")
PY
