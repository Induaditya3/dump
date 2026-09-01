#!/bin/bash
set -euo pipefail

SRC_DIR="$HOME/xournal"
PDF_DIR="$SRC_DIR/pdf"
mkdir -p "$PDF_DIR"
shopt -s nullglob

CHANGED=0

for f in "$SRC_DIR"/*.xopp; do
    base="$(basename "$f" .xopp)"
    pdf="$PDF_DIR/${base}.pdf"

    # Export only if pdf missing or source is newer than existing pdf
    if [[ ! -e "$pdf" || "$f" -nt "$pdf" ]]; then
        xournalpp --create-pdf="$pdf" "$f"
        CHANGED=1
    fi
done

# Optional: clean up pdfs whose source .xopp no longer exists
for pdf in "$PDF_DIR"/*.pdf; do
    base="$(basename "$pdf" .pdf)"
    if [[ ! -e "$SRC_DIR/${base}.xopp" ]]; then
        rm -f "$pdf"
        CHANGED=1
    fi
done

if [[ "$CHANGED" -eq 1 ]]; then
    rclone sync "$PDF_DIR" journal:xournal
else
    echo "No changes detected, skipping sync."
fi
