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
    sed "s/^BROWSER /BROWSER:/g;" | \
    sed "s/^EMACS /EMACS:/g;" | \
    sed "s/^PROMPT /PROMPT:/g;" | \
    sed "s/^ROFI /ROFI:/g;" | \
    sed "s/^RESIZE /RESIZE:/g;" | \
    sed "s/^SYSTEM /SYSTEM:/g;" | \

    sed "s/@/@     /g;" | \
    sed "s/$/@/g;" | \
    tr '@' '\n' | \

    sed 's/dawd//' > $cache
fi
# cat $cache
# exit 0

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--prompt='Qtile commands: '
--preview='cat $cache | grep -w {1} -A2 | grep -w {2} -A2'"

cmd=$(cat $cache | grep -v "^$\|^ " | awk -F@ '{print $1}' | uniq | sort | fzf)
cat $cache | grep $cmd -A2
