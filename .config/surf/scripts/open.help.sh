#!/bin/sh

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
