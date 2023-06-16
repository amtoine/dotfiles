#!/usr/bin/env bash

original="$HOME/.config/tig/config"
dotfiles="$HOME/.config/tig/.dotfiles"

grep -v "^\s*#" "$original" | grep -v "^\s*$" | tee "$dotfiles"
sed -i 's/\s*#.*//g' "$dotfiles"
sed -i 's/^set \(.*\)untracked\(.*\) = yes/set \1untracked\2 = no/' "$dotfiles"
