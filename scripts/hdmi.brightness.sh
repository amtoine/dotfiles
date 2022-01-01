#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   __        __          _          __         _       __    __                               __
#        _______________(_)___  / /______     _/_/  / /_  ____/ /___ ___  (_)        / /_  _____(_)___ _/ /_  / /_____  ___  __________   _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ \/ __  / __ `__ \/ /        / __ \/ ___/ / __ `/ __ \/ __/ __ \/ _ \/ ___/ ___/  / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / / / / /_/ / / / / / / /   _    / /_/ / /  / / /_/ / / / / /_/ / / /  __(__  |__  )  (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/ /_/\__,_/_/ /_/ /_/_/   (_)  /_.___/_/  /_/\__, /_/ /_/\__/_/ /_/\___/____/____/  /____/_/ /_/
#                     /_/                                                                      /____/
#
# Description:  increases or decreases the brightness of the screen by giving + or - to the script.
# Dependencies: xrandr
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: WinEunuuchs2Unix at https://askubuntu.com/questions/1150339/increment-brightness-by-value-using-xrandr (original idea)
#               Stevan Antoine (adaptations)

MON="HDMI-2"    # Discover monitor name with: xrandr | grep " connected"
STEP=5          # Step Up/Down brightness by: 5 = ".05", 10 = ".10", etc.

CurrBright=$( xrandr --verbose --current | grep ^"$MON" -A5 | tail -n1 )
CurrBright="${CurrBright##* }"  # Get brightness level with decimal place

Left=${CurrBright%%"."*}        # Extract left of decimal point
Right=${CurrBright#*"."}        # Extract right of decimal point

MathBright="0"
[[ "$Left" != 0 && "$STEP" -lt 10 ]] && STEP=10     # > 1.0, only .1 works
[[ "$Left" != 0 ]] && MathBright="$Left"00          # 1.0 becomes "100"
[[ "${#Right}" -eq 1 ]] && Right="$Right"0          # 0.5 becomes "50"
MathBright=$(( MathBright + Right ))

[[ "$1" == "Up" || "$1" == "+" ]] && MathBright=$(( MathBright + STEP ))
[[ "$1" == "Down" || "$1" == "-" ]] && MathBright=$(( MathBright - STEP ))
[[ "${MathBright:0:1}" == "-" ]] && MathBright=0    # Negative not allowed
[[ "$MathBright" -gt 110  ]] && MathBright=110      # Can't go over 9.99

if [[ "${#MathBright}" -eq 3 ]] ; then
    MathBright="$MathBright"000         # Pad with lots of zeros
    CurrBright="${MathBright:0:1}.${MathBright:1:2}"
else
    MathBright="$MathBright"000         # Pad with lots of zeros
    CurrBright=".${MathBright:0:2}"
fi

xrandr --output "$MON" --brightness "$CurrBright"   # Set new brightness
exit 0

# Display current brightness
printf "Monitor $MON "
echo $( xrandr --verbose --current | grep ^"$MON" -A5 | tail -n1 )
