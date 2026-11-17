#!/bin/bash

set -euo pipefail

BUCKET="$1"
BOOK_DIR="$2"

mkdir -p "$BOOK_DIR"
aws s3 cp "s3://$BUCKET/" "$BOOK_DIR" --recursive --exclude "*" --include "*.txt"

echo "file path" > book_list.txt
find "$(realpath "$BOOK_DIR")" -name "*.txt" | sort >> book_list.txt

echo "Wrote $(tail -n +2 book_list.txt | wc -l) book files to book_list.txt"
