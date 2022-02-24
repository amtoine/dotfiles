#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __  _             _   _         _
#      ___   / / | |_ ___  __ _| |_| |__   __| |_
#     (_-<  / /  |  _/ _ \/ _` | / / '_ \_(_-< ' \
#     /__/ /_/    \__\___/\__, |_\_\_.__(_)__/_||_|
#                         |___/
#
# Description:  toggles the keyboard layout between qwerty and azerty.
# Dependencies: setxkbmap 
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

if [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = fr ]]; then
	setxkbmap -layout us;
elif [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = us ]]; then
	setxkbmap -layout fr;
fi
