#!/usr/bin/env sh

WD="$(pwd)"
OUT="$WD/.stdout$1"
ERR="$WD/.stderr$1"
echo "make $1" | tee "$OUT" "$ERR"
for DIR in $(find "$WD" -maxdepth 1 -type d -name "jeksterslabR*"); do
    (cd "$DIR" && make "$1" >> "$OUT" 2>> "$ERR")
done
