#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __         __     _                           _   _                       _    
#          __    / /  __ _    / /  ___   / /  __| |_  __ _ _ _  __ _ ___ ___| |_| |_  ___ _ __  ___   __| |_  
#      _  / _|  / /  / _` |  / /  (_-<  / /  / _| ' \/ _` | ' \/ _` / -_)___|  _| ' \/ -_) '  \/ -_)_(_-< ' \ 
#     (_) \__| /_/   \__, | /_/   /__/ /_/   \__|_||_\__,_|_||_\__, \___|    \__|_||_\___|_|_|_\___(_)__/_||_|
#                       |_|                                    |___/                                          
#
# Description:  change the theme of qtile with dmenu
# Dependencies: fzf
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

################################################################################################
## Some color definitions ######################################################################
################################################################################################
# Reset
Off=$(printf '\033[0m')        # Text Reset
# Regular Colors
Blk=$(printf '\033[0;30m')     # Black
Red=$(printf '\033[0;31m')     # Red
Grn=$(printf '\033[0;32m')     # Green
Ylw=$(printf '\033[0;33m')     # Yellow
Blu=$(printf '\033[0;34m')     # Blue
Pur=$(printf '\033[0;35m')     # Purple
Cyn=$(printf '\033[0;36m')     # Cyan
Wht=$(printf '\033[0;37m')     # White
# High Intensity
IRed=$(printf '\033[0;91m')    # Red
IGrn=$(printf '\033[0;92m')    # Green
IYlw=$(printf '\033[0;93m')    # Yellow
IBlu=$(printf '\033[0;94m')    # Blue
IPur=$(printf '\033[0;95m')    # Purple
IWht=$(printf '\033[0;97m')    # White
# Bold High Intensity
################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Cod=$IBlu  # code
Hed=$IPur  # head
Src=$Pur   # source
Dst=$Grn   # destination
Pmt=$Cyn   # prompt
Tip=$IGrn  # tip

repo="kovidgoyal/kitty-themes"
cache="$HOME/.cache/qtile/themes"
qtile_current="$HOME/.config/qtile/theme.py"

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--prompt='Manual: '
--preview=\"cat $cache/themes/{1} | grep -Ev 'cursor|active|^\$|^#|url' | sed 's/background/bg/; s/foreground/fg/; s/selection/sel/;  s/ #/%#/' | column -t -s '\%'\""

if [[ ! -d "$cache" ]]; then
  echo "Downloading themes from ${Src}$repo${Off} to ${Dst}$cache${Off}.";
  git clone -q "https://github.com/$repo.git" "$cache";
fi

# download the themes list from remote.
# use fzf to let the user choose the theme.
theme=$(find "$cache/themes" -type f | sed 's/.*\/\(.*.conf\)/\1/;' | sort | fzf)
if [ "$theme" == "" ]; then
  echo "${Wrn}No theme selected. Aborting.${Off}";
  exit 1
fi
echo "$theme"

# build the head and the body of the next theme file,
# located at $qtile_current
#      the head
tmpheader=$(mktemp /tmp/qtile-header.XXXXXX)
trap  'rm "$tmpheader"' 0 1 15
cat << EOF > "$tmpheader"
#      _     ___   ___    _  _  ___ _____   ___ ___ ___ _____
#    _| |_  |   \ / _ \  | \| |/ _ \_   _| | __|   \_ _|_   _|
#   |_   _| | |) | (_) | | .\` | (_) || |   | _|| |) | |  | |
#     |_|   |___/ \___/  |_|\_|\___/ |_|   |___|___/___| |_|
#
#      _     ___   ___    _  _  ___ _____   __  __  _____   _____
#    _| |_  |   \ / _ \  | \| |/ _ \_   _| |  \/  |/ _ \ \ / / __|
#   |_   _| | |) | (_) | | .\` | (_) || |   | |\/| | (_) \ V /| _|
#     |_|   |___/ \___/  |_|\_|\___/ |_|   |_|  |_|\___/ \_/ |___|
#
#      _     ___   ___    _  _  ___ _____   ___  ___ _    ___ _____ ___
#    _| |_  |   \ / _ \  | \| |/ _ \_   _| |   \| __| |  | __|_   _| __|
#   |_   _| | |) | (_) | | .\` | (_) || |   | |) | _|| |__| _|  | | | _|
#     |_|   |___/ \___/  |_|\_|\___/ |_|   |___/|___|____|___| |_| |___|
#
#   please use the \`qtile-change-theme.sh\` script in \`~/.config/qtile/scripts\`
#   to automatically edit this file and change the theme of Qtile.

EOF
#      the body
tmpbody=$(mktemp /tmp/qtile-body.XXXXXX)
trap  'rm "$tmpbody"' 0 1 15
{ echo "from utils import ColorScheme"; echo "theme = ColorScheme(**{"; } > "$tmpbody"
grep -Ev 'cursor|active|^\$|^#|url' "$cache/themes/$theme" | \
  sed 's/background/bg/; s/foreground/fg/; s/selection/sel/; s/\s\+/ /' | \
  sed 's/\([a-z_0-9]*\)/    "\1":/; s/\(#......\)/"\1",/;' | \
  sed 's/\s\+"":\s*$//' >> "$tmpbody"
echo "})" >> "$tmpbody"

# preview the theme file before installing.
# formats are sometimes different in the repo,
# theme parsing might go wrong, hence this verification step.
echo -e "\nTheme to install (${Wrn}please verify the integrity of the python code${Off}):"
echo "${Cod}\`\`\`python${Hed}"
cat "$tmpbody"
echo "${Cod}\`\`\`${Off}"
echo ""

# prompt the user to install the theme.
read -rp "${Pmt}Install above theme?${Off} (y/N) " install
case $install in
  Y|y|yes|YES|Yes)
    echo "Installing the theme to ${Dst}$qtile_current${Off}.";
    cp "$tmpheader" "$qtile_current";
    cat "$tmpbody" >> "$qtile_current";
    echo "# current: $theme" >> "$qtile_current"
    echo "${Tip}Do not forget to restart the Qtile window manager to apply changes.${Off}"
    ;;
  ''|N|n|no|NO|No) echo "${Wrn}Do not install the theme.${Off}"; exit 0;;
  *) echo "${Err}Unknown answer ${Off}'$install'${Err}. Aborting.${Off}"; exit 1;;
esac
