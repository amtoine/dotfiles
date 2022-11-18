#!/bin/sh

tmpfile=$(mktemp /tmp/surf-edit.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15
cat > "$tmpfile"

# kitty "$EDITOR" "$tmpfile"
kitty nvim "$tmpfile"
