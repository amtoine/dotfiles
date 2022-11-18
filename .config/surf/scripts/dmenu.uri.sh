#! /usr/bin/bash

DMFONT="mononoki Nerd Font-15"

tac ~/.config/surf/history.txt | dmenu -fn "$DMFONT" -l 10 -b -i | awk '{ print $2 }'
