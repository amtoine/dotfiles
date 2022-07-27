#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://amtoine.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/amtoine 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/amtoine/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __                   ____      __                  _       __             __                                   __         __                    __
#             _________  ____  / __(_)___ _     _/_/  _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ____  ____  ___  ____           / /_  ___  / /___           _____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ \/ __ \/ _ \/ __ \         / __ \/ _ \/ / __ \         / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ /  __/ / / /   _    / / / /  __/ / /_/ /   _    (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \____/ .___/\___/_/ /_/   (_)  /_/ /_/\___/_/ .___/   (_)  /____/_/ /_/
#                                 /____/                                                          /_/                             /_/                                    /_/
#
# Description:  Open a help file in a text editor, shows key bindings...
# Dependencies: kitty
# License:      https://github.com/amtoine/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

configfile="$HOME/repos/surf/config.def.h"
tmpfile=$(mktemp /tmp/surf-help.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15

cat << EOF > "$tmpfile"
This is the help file of my surf rice.
Below are some key bindings of the surf web browser I user.

my personal page: https://amtoine.github.io/ 
my github   page: https://github.com/amtoine 
my      dotfiles: https://github.com/amtoine/dotfiles 

EOF
cat "$configfile" | grep -e "#define MOD" | sed "s/#define MODKEY GDK_\(\w*\)_MASK/modkey: \1/g" >> "$tmpfile"
cat << EOF >> "$tmpfile"

modifiers            | key           | function          | parameters
---------------------+---------------+-------------------+-----------
EOF
cat "$configfile" | grep -e "GDK_KEY" | sed "s/#define MODKEY GDK_\(\w*\)_MASK/\1/g; s/^\s\+{\s\+//g; s/\s\+},$//g" >> "$tmpfile"

cat << EOF >> "$tmpfile"

tag | search engine               | URL
----+-----------------------------+--------------------------------------
EOF
cat "$configfile" | grep -e '{ "..=", "https' | sed 's/  { "//g; s/", "/ /g; s/" },//g; s/https:\/\/\(.*\)\/\(.*\)/| \1\^| https:\/\/\1\/\2/g;' | column -t -s '^'>> "$tmpfile"

# kitty "$EDITOR" "$tmpfile"
kitty nvim "$tmpfile"
