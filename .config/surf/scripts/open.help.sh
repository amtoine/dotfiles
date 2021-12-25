#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __                                   __         __                    __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ____  ____  ___  ____           / /_  ___  / /___           _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ \/ __ \/ _ \/ __ \         / __ \/ _ \/ / __ \         / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ /  __/ / / /   _    / / / /  __/ / /_/ /   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \____/ .___/\___/_/ /_/   (_)  /_/ /_/\___/_/ .___/   (_)  /____/_/ /_/
#                                                    /_/                             /_/                                    /_/
#
# Description:  Open a help file in a text editor, shows key bindings...
# Dependencies: kitty
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

configfile="$HOME/repos/surf/config.def.h"
tmpfile=$(mktemp /tmp/surf-help.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15

cat << EOF > "$tmpfile"
This is the help file of my surf rice.
Below are some key bindings of the surf web browser I user.

my personal page: https://a2n-s.github.io/ 
my github   page: https://github.com/a2n-s 
my      dotfiles: https://github.com/a2n-s/dotfiles 

EOF
cat "$configfile" | grep -e "#define MOD" | sed "s/#define MODKEY GDK_\(\w*\)_MASK/modkey: \1/g" >> "$tmpfile"
cat << EOF >> "$tmpfile"

modifiers            | key           | function          | parameters
---------------------+---------------+-------------------+-----------
EOF
cat "$configfile" | grep -e "GDK_KEY" | sed "s/#define MODKEY GDK_\(\w*\)_MASK/\1/g; s/^\s\+{\s\+//g; s/\s\+},$//g" >> "$tmpfile"

# kitty "$EDITOR" "$tmpfile"
kitty nvim "$tmpfile"
