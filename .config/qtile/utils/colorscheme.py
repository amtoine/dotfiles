#!/usr/bin/env python3
# a header could go here

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
