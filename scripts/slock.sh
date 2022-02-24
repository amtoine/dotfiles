#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __     _         _        _
#      ___   / /  __| |___  __| |__  __| |_
#     (_-<  / /  (_-< / _ \/ _| / /_(_-< ' \
#     /__/ /_/   /__/_\___/\__|_\_(_)__/_||_|
#
# Description:  a wrapper for slock which prints a fancy raibow cow on the lock screen.
# Dependencies: cowsay, fortune, locat.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# slock -m "$(cowsay $(fortune -c) | lolcat -ft)"
# slock -m "$(figlet -tcf slant "Screen Is Locked. Type Your Password To Unlock." -w 100)"
# slock -m "$(figlet -tcf slant "Screen Is Locked. Type Your Password To Unlock." -w 100 | lolcat -ft)"
# slock -m "$(figlet -tf small "Bet you can't crack it open.")"
slock -m ""
