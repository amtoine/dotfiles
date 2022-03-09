#!/usr/bin/env fish

for theme in (tail -n +2 ~/.cache/all-themes/themes.csv)
    echo "$theme" | awk -F, '{print $1}'
    for color in (echo "$theme" | awk -F, '{for (i = 2; i < 4; i++) print $i}')
        set_color -b "$color"
        echo -n "  "
    end
    for color in (echo "$theme" | awk -F, '{for (i = 6; i < 14; i++) print $i}')
        set_color -b "$color"
        echo -n "  "
    end
    echo ""
    for color in (echo "$theme" | awk -F, '{for (i = 4; i < 6; i++) print $i}')
        set_color -b "$color"
        echo -n "  "
    end
    for color in (echo "$theme" | awk -F, '{for (i = 14; i < 22; i++) print $i}')
        set_color -b "$color"
        echo -n "  "
    end
    set_color normal
    echo ""
end | less
