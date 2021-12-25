#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                                   __      __                                  __
#        _______________(_)___  / /______     _/_/           _________  __  ______  / /_____/ /___ _      ______           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / ___/ __ \/ / / / __ \/ __/ __  / __ \ | /| / / __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             / /__/ /_/ / /_/ / / / / /_/ /_/ / /_/ / |/ |/ / / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______    \___/\____/\__,_/_/ /_/\__/\__,_/\____/|__/|__/_/ /_/   (_)  /____/_/ /_/
#                     /_/                       /_____/
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

