#!/usr/bin/env sh

WD="$(pwd)"
OUT="$WD/.stdoutmk"
ERR="$WD/.stderrmk"
echo "make $CMD" | tee "$OUT" "$ERR"
for DIR in $(find "$WD" -maxdepth 1 -type d -name "jeksterslabR*"); do
    (cd "$DIR" && make "$1" >> "$OUT" 2>> "$ERR")
done
