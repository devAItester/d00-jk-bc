#!/usr/bin/env bash
set -euo pipefail

failed=0

while IFS= read -r -d '' file; do
  if ! awk '
    NR == 1 { in_frontmatter = ($0 == "---"); next }
    in_frontmatter && $0 == "---" { exit found ? 0 : 1 }
    in_frontmatter && $0 ~ /^title:[[:space:]]*[^[:space:]].*$/ { found = 1 }
    END {
      if (in_frontmatter && found) exit 0
      if (!in_frontmatter) exit 1
    }
  ' "$file"; then
    printf 'Missing non-empty front matter title: %s\n' "$file" >&2
    failed=1
  fi
done < <(find . -type f -name '*.md' \
  ! -path './.git/*' \
  ! -path './_site/*' \
  ! -name 'README.md' \
  -print0)

if (( failed )); then
  exit 1
fi
