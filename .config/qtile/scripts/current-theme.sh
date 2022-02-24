#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __         __                          _       _   _                       _    
#          __    / /  __ _    / /  ___   / /  __ _  _ _ _ _ _ ___ _ _| |_ ___| |_| |_  ___ _ __  ___   __| |_  
#      _  / _|  / /  / _` |  / /  (_-<  / /  / _| || | '_| '_/ -_) ' \  _|___|  _| ' \/ -_) '  \/ -_)_(_-< ' \ 
#     (_) \__| /_/   \__, | /_/   /__/ /_/   \__|\_,_|_| |_| \___|_||_\__|    \__|_||_\___|_|_|_\___(_)__/_||_|
#                       |_|                                                                                    
#
# Description:  shows the current theme and exits.
# Dependencies: none
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

_qtile_current="$HOME/.config/qtile/theme.py"

tail -n1 "$_qtile_current" | sed 's/# current: \(.*\).conf/\1/'
