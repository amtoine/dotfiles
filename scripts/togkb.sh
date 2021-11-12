#! /usr/bin/bash
# toggles the keyboard layout between qwerty and azerty.

echo "togkb"
if [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = fr ]]; then
	setxkbmap -layout us;
elif [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = us ]]; then
	setxkbmap -layout fr;
fi
