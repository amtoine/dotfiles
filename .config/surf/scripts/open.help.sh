#!/bin/sh
#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

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
