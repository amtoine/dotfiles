#!/usr/bin/env bash

base_url="https://raw.githubusercontent.com/kovidgoyal/kitty-themes/master"

theme=$(curl -s "$base_url/themes.json" | grep file | sed 's/\s\+"file": "//; s/",//' | fzf)
if [ "$theme" == "" ]; then
  echo "No theme selected. Aborting.";
  exit 1
fi

qtile_current="$HOME/.config/qtile/current_scheme.py"

tmpfile=$(mktemp /tmp/qtile-theme.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15

echo -e "Downloading $theme from $base_url\n"
curl -fLo $tmpfile "$base_url/$theme"

tmpcurrent=$(mktemp /tmp/qtile-current.XXXXXX)
trap  'rm "$tmpcurrent"' 0 1 15

cat << EOF > "$tmpcurrent"
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
echo "from utils import ColorScheme" >> "$tmpcurrent"
echo "theme = ColorScheme(**{" >> "$tmpcurrent"
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
  sed 's/\(.*color7".*\)/\1  # white/' >> "$tmpcurrent"
echo "})" >> "$tmpcurrent"
echo "# $theme" >> "$tmpcurrent"

echo -e "\nTheme to install (please verify the integrity of the python code):"
echo "\`\`\`python"
cat "$tmpcurrent"
echo "\`\`\`"
echo ""

read -p "Install above theme? (y/N) " install
case $install in
  Y|y|yes|YES|Yes) echo "Installing the theme to $qtile_current."; cp $tmpcurrent $qtile_current;;
  ''|N|n|no|NO|No) echo "Do not install the theme."; exit 0;;
  *) echo "Unknown answer '$install'. Aborting."; exit 1;;
esac
echo "Do not forget to restart the Qtile window manager to apply changes."
