#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#        _     __  _        __                    _        _
#       | |   / / | |__    / /  ____ __  __ _ _ _| |__  __| |_
#      _| |  / /  | '_ \  / /  (_-< '_ \/ _` | '_| / /_(_-< ' \
#     (_)_| /_/   |_.__/ /_/   /__/ .__/\__,_|_| |_\_(_)__/_||_|
#                                 |_|
#
# Description:  sparkline generator
# Dependencies: awk
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

command awk -v FS="[[:space:],]*" -v argv="$argv" '
    BEGIN {
        min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
    }
    {
        for (i = j = 1; i <= NF; i++) {
            if ($i ~ /^--/) continue
            if ($i !~ /^-?[0-9]/) data[count + j++] = ""
            else {
                v = data[count + j++] = int($i)
                if (max == "" && min == "") max = min = v
                if (max < v) max = v
                if (min > v ) min = v
            }
        }
        count += j - 1
    }
    END {
        n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
        scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
        for (i = 1; i <= count; i++)
            out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
        print out
    }
'
