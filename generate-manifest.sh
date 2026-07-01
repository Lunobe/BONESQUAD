#!/usr/bin/env bash
# Regenerates manifest.txt from the contents of Assets/.
# Run this after adding/changing/removing any file in Assets/, then commit+push both.
set -euo pipefail
cd "$(dirname "$0")"

: > manifest.txt
find Assets -type f | LC_ALL=C sort | while IFS= read -r f; do
    rel="${f#Assets/}"
    hash=$(sha256sum "$f" | cut -d' ' -f1)
    printf '%s\t%s\n' "$rel" "$hash" >> manifest.txt
done

echo "Wrote $(wc -l < manifest.txt) entries to manifest.txt"
