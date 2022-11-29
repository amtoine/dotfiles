#!/usr/bin/env python3
# *
# *                  _    __ _ _
# *   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
# *  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
# *  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
# *  |___/
# *          MAINTAINERS:
# *              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
# *              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
# *

from collections import namedtuple

# a coloscheme is a structure made of background, foreground colors
# and 16 indexed colors
# they all default to pure red to indicate a color is missing.
_colors = [
        "bg",
        "fg",
        "sel_bg",
        "sel_fg",
        "color0",
        "color8",
        "color1",
        "color9",
        "color2",
        "color10",
        "color3",
        "color11",
        "color4",
        "color12",
        "color5",
        "color13",
        "color6",
        "color14",
        "color7",
        "color15",
]
ColorScheme = namedtuple(
    "ColorScheme",
    _colors,
    defaults=("#ff0000",) * len(_colors)
)
