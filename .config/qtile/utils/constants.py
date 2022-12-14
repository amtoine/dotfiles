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

# a wrapper to make the change of the
# font size easier
# the user inly has to choose among the
# given names instead of computing good
# sizes for a given layout
FontSizes = namedtuple(
    "FontSized",
    [
        "tiny",
        "small",
        "medium",
        "large",
        "huge",
    ]
)
# the number have been computed so that the
# bar stays pretty no matter the size
#
# a font size is of the form
# ARROW_SIZE, BAR_SIZE, GROUP_SIZE
font_sizes = FontSizes(
    tiny=(17, 12, 5),
    small=(19, 16, 9),
    medium=(29, 24, 16),
    large=(38, 32, 23),
    huge=(58, 50, 37),
)

# same as the FontSizes above, allow the user to
# choose among predefined presets for the bar content.
Bars = namedtuple(
    "Bars",
    [
        "minimal",
        "decreased",
        "normal",
    ]
)
bar_styles = Bars(
    # these are arbitrary indices.
    minimal=0,
    decreased=1,
    normal=2,
)

# same as the FontSizes above, allow the user to
# choose among predefined presets for the widget
# separators.
Seps = namedtuple(
    "Seps",
    [
        "vmono",
        "vcolor",
        "smono",
        "scolor",
    ]
)
sep_styles = Seps(
    # these are arbitrary values.
    vmono=0,
    vcolor=1,
    smono=2,
    scolor=3,
)
