#! /usr/bin/bash
tac ~/.config/surf/history.txt | dmenu -l 10 -b -i | awk '{ print $2 }'
# tac ~/.config/surf/history.txt | dmenu -l 10 -b -i | cut -d ' ' -f 2
