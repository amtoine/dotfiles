#!/usr/bin/env bash

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
# Bold
BBlk=$(printf '\033[1;30m')    # Black
BRed=$(printf '\033[1;31m')    # Red
BGrn=$(printf '\033[1;32m')    # Green
BYlw=$(printf '\033[1;33m')    # Yellow
BBlu=$(printf '\033[1;34m')    # Blue
BPur=$(printf '\033[1;35m')    # Purple
BCyn=$(printf '\033[1;36m')    # Cyan
BWht=$(printf '\033[1;37m')    # White
# Underline
UBlk=$(printf '\033[4;30m')    # Black
URed=$(printf '\033[4;31m')    # Red
UGrn=$(printf '\033[4;32m')    # Green
UYlw=$(printf '\033[4;33m')    # Yellow
UBlu=$(printf '\033[4;34m')    # Blue
UPur=$(printf '\033[4;35m')    # Purple
UCyn=$(printf '\033[4;36m')    # Cyan
UWht=$(printf '\033[4;37m')    # White
# Background
OBlk=$(printf '\033[40m')      # Black
ORed=$(printf '\033[41m')      # Red
OGrn=$(printf '\033[42m')      # Green
OYlw=$(printf '\033[43m')      # Yellow
OBlu=$(printf '\033[44m')      # Blue
OPur=$(printf '\033[45m')      # Purple
OCyn=$(printf '\033[46m')      # Cyan
OWht=$(printf '\033[47m')      # White
# High Intensity
IBlk=$(printf '\033[0;90m')    # Black
IRed=$(printf '\033[0;91m')    # Red
IGrn=$(printf '\033[0;92m')    # Green
IYlw=$(printf '\033[0;93m')    # Yellow
IBlu=$(printf '\033[0;94m')    # Blue
IPur=$(printf '\033[0;95m')    # Purple
ICyn=$(printf '\033[0;96m')    # Cyan
IWht=$(printf '\033[0;97m')    # White
# Bold High Intensity
BIBlk=$(printf '\033[1;90m')   # Black
BIRed=$(printf '\033[1;91m')   # Red
BIGrn=$(printf '\033[1;92m')   # Green
BIYlw=$(printf '\033[1;93m')   # Yellow
BIBlu=$(printf '\033[1;94m')   # Blue
BIPur=$(printf '\033[1;95m')   # Purple
BICyn=$(printf '\033[1;96m')   # Cyan
BIWht=$(printf '\033[1;97m')   # White
# High Intensity backgrounds
OIBlk=$(printf '\033[0;100m')  # Black
OIRed=$(printf '\033[0;101m')  # Red
OIGrn=$(printf '\033[0;102m')  # Green
OIYlw=$(printf '\033[0;103m')  # Yellow
OIBlu=$(printf '\033[0;104m')  # Blue
OIPur=$(printf '\033[0;105m')  # Purple
OICyn=$(printf '\033[0;106m')  # Cyan
OIWht=$(printf '\033[0;107m')  # White

################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Crt=$Red   # critical
Cod=$IBlu  # code
Hed=$IPur  # head
Src=$Pur   # source
Dst=$Grn   # destination
Nrm=$IWht  # normal
Pmt=$Cyn   # prompt
Pkg=$Ylw   # package
Tip=$IGrn  # tip
Url=$IYlw  # url

# download the themes list from remote.
# use fzf to let the user choose the theme.
base_url="https://raw.githubusercontent.com/kovidgoyal/kitty-themes/master"
theme=$(curl -s "$base_url/themes.json" | grep file | sed 's/\s\+"file": "//; s/",//' | fzf)
if [ "$theme" == "" ]; then
  echo "${Wrn}No theme selected. Aborting.${Off}";
  exit 1
fi

qtile_current="$HOME/.config/qtile/current_scheme.py"

# download the theme itself.
tmpfile=$(mktemp /tmp/qtile-theme.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15
echo -e "Downloading ${Dst}$theme${Off} from ${Src}$base_url${Off}\n"
curl -fLo "$tmpfile" "$base_url/$theme"

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
grep -v "^#" "$tmpfile" | grep -v "url" | \
  sed 's/background/bg/; s/foreground/fg/; s/selection/sel/;  s/ \#/\&\#/' | column -t -s '&' | \
  sed 's/\([a-z_0-9]*\)/    "\1":/; s/\(#......\)/"\1",/;' | \
  sed 's/\(.*color0".*\)/\1  # grey/'   | \
  sed 's/\(.*color1".*\)/\1  # red/'    | \
  sed 's/\(.*color2".*\)/\1  # green/'  | \
  sed 's/\(.*color3".*\)/\1  # yellow/' | \
  sed 's/\(.*color4".*\)/\1  # blue/'   | \
  sed 's/\(.*color5".*\)/\1  # magenta/'| \
  sed 's/\(.*color6".*\)/\1  # cyan/'   | \
  sed 's/\(.*color7".*\)/\1  # white/' >> "$tmpbody"
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
    echo "# remote:  $base_url" >> "$qtile_current";
    echo "# current: $theme" >> "$qtile_current"
    ;;
  ''|N|n|no|NO|No) echo "${Wrn}Do not install the theme.${Off}"; exit 0;;
  *) echo "${Err}Unknown answer ${Off}'$install'${Err}. Aborting.${Off}"; exit 1;;
esac
echo "${Tip}Do not forget to restart the Qtile window manager to apply changes.${Off}"
