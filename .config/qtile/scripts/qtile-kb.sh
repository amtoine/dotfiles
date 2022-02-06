cache="$HOME/.cache/qtile/kb"
if [[ -f "$cache" ]]; then
  qtile cmd-obj -o cmd -f display_kb | \
  tr '\n' ' ' | \
    sed 's/\s\+/ /g' | \
    sed "s/\\\n/\n/g" | \
    sed 's/" "//g;' | \
    grep -v "^')\|^(\|^' '---" | \
    sed "s/\"/'/g;" | \
    sed "s/\\\'/'/g;" | \
    sed "s/' ''/'/g;" | \
    sed "s/''/'/g;" | \
    sed "s/^('/' '/;" | \
    sed "s/\\\u....//g;" | \
    sed "s/, /+/;" | \
    sed "s/togroup/' 'togroup/g;" | \
    sed "s/' 'True)/True) ' '/g;" | \
    sed "s/' 'if true/if true/g;" | \
    sed "s/ spawn/ ' 'spawn/g;" | \
    sed "s/' 'mod\(.\) ' 'Enter  /mod\1 ' 'Enter /;" | \
    sed "s/\(spawn.*)\) \(.*[a-zA-Z]\) ' '/\1 ' '\2 /;" | \
    sed "s/run_extension(<libqtile.extension.\(.*\) object at ' '0x............>)/run_extension(\1) ' '/" | \
    sed "s/.mod\([0-9]\)/+mod\1/g;" | \

    sed "s/' '/@/g;" | \
    sed "s/@ /@/g;" | \
    sed "s/^@//g;" | \

    sed 's/\s\+/ /g' | \
    sed "s/ \(.*\)+mod\([0-9]\)/ mod\2+\1/g;" | \
    sed "s/+\(.*\)+shift/+shift+\1/g;" | \
    sed "s/+\(.*\)+control/+control+\1/g;" | \

    sed "s/^<root> /<root>:/g;" | \
    sed "s/^BROWSER /BROWSER:mod4+b,/g" | \
    sed "s/^DMENU /DMENU:mod4+d,/g" | \
    sed "s/^EDITOR /EDITOR:mod4+e,/g" | \
    sed "s/^MUSIC /MUSIC:mod4+m,/g" | \
    sed "s/^MISCELLANEOUS /MISCELLANEOUS:mod4+c,/g" | \
    sed "s/^PASS /PASS:mod4+p,/g" | \
    sed "s/^QTILE> HELP /QTILE,HELP:mod4+q,h,/g" | \
    sed "s/^QTILE /QTILE:mod4+q,/g" | \
    sed "s/^ROFI /ROFI:mod4+r,/g" | \
    sed "s/^SYSTEM> CONFIG /SYSTEM,CONFIG:mod4+s,c,/g" | \
    sed "s/^SYSTEM> DISK /SYSTEM,DISK:mod4+s,d,/g" | \
    sed "s/^SYSTEM> MONITOR /SYSTEM,MONITOR:mod4+s,h,/g" | \
    sed "s/^SYSTEM> TERMINAL /SYSTEM,TERMINAL:mod4+s,t,/g" | \
    sed "s/^SYSTEM> UPDATES /SYSTEM,UPDATES:mod4+s,u,/g" | \
    sed "s/^SYSTEM /SYSTEM:mod4+s,/g" | \
    sed "s/^RESIZE /RESIZE:mod4+z,/g" | \

    sed "s/@/@     /g;" | \
    sed "s/$/@/g;" | \
    tr '@' '\n' | \

    sed 's/dawd//' > "$cache"
fi
# cat $cache
# exit 0

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--prompt='Qtile commands: '
--preview='cat $cache | grep -w {1} -A2 | grep -w {2} -A2'"

cmd=$(cat $cache | grep -v "^$\|^ " | awk -F@ '{print $1}' | uniq | sort | fzf)
cat "$cache" | grep "$cmd" -A2
