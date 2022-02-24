#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                     _      _                      _
#      ___   / /     __ ___ _  _ _ _| |_ __| |_____ __ ___ _    __| |_
#     (_-<  / /     / _/ _ \ || | ' \  _/ _` / _ \ V  V / ' \ _(_-< ' \
#     /__/ /_/    __\__\___/\_,_|_||_\__\__,_\___/\_/\_/|_||_(_)__/_||_|
#                |___|
#
# Description:  simple countdown
#               deprecated -> see the termdown command instead.
# Dependencies: play
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine


date1=$((`date +%s` + $1));
while [ "$date1" -ge `date +%s` ]; do
 echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
 sleep 0.1
done
echo -n "COUNTDOWN OVER!!"
while [ true ]; do
    play -q -n synth .1 sine 880 vol 0.5
    play -q -n synth .1 sine 880 vol 0.5
    play -q -n synth .1 sine 880 vol 0.5
    play -q -n synth .1 sine 880 vol 0.5
    play -q -n synth .1 sine 880 vol 0.5
 sleep 0.5
done

