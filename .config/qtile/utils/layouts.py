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
from .colorscheme import ColorScheme

# a Layout is a tuple of colors for some states of
# the windows
# they all default to None
_layout_opts = [
        "focus",
        "normal",
        "focus_stack",
        "normal_stack",
]
Layout = namedtuple(
    "Layout",
    _layout_opts,
    defaults=(None,) * len(_layout_opts)
)

# as for the WidgetTheme above, the LayoutTheme is
# a tuple with one color palette, i.e. Layout, per
# layout.
# They will use the default arguments of the wrappers
# inside widgets.py by default.
_layouts = [
        "floating",
        "bsp",
        "columns",
        "matrix",
        "monad_tall",
        "monad_wide",
        "ratio",
        "stack",
        "tile",
        "vertical",
        "tree",
        "border_width",
        "margin",
]
LayoutTheme = namedtuple(
    "LayoutTheme",
    _layouts,
    defaults=({},) * len(_layouts)
)


def build_layouts(
        theme: ColorScheme,
        border_width: int,
        margin: int
        ) -> LayoutTheme:
    """
        Build the Layout themes inside a LayoutTheme,
        with some hints in optional arguments.
    """
    _layout_themes = {
        "bsp":        {"focus": theme.color12, "normal": theme.color2},
        "columns":    {"focus": theme.color12, "normal": theme.color2, "focus_stack": theme.color1, "normal_stack": theme.color8},
        "monad_tall": {"focus": theme.color1,  "normal": theme.color2},
        "monad_wide": {"focus": theme.color1,  "normal": theme.color2},
        "floating":   {"focus": theme.color12, "normal": theme.color2},
        "tree":       {"focus": theme.color1,  "normal": theme.color2},
    }

    return LayoutTheme(
        **dict(zip(_layout_themes.keys(), [Layout(**args) for args in _layout_themes.values()])),
        border_width=border_width,
        margin=margin,
    )
