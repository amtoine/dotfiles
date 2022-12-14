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

# the WidgetTheme namedtuple contains one color palette,
# built from the current colorscheme, per widget
# by default, the widget palette is empty, thus using
# the default arguments of the wrappers in widgets.py
_widgets = [
        "image",
        "current_layout",
        "current_screen",
        "group_box",
        "prompt",
        "window_name",
        "net",
        "df",
        "wlan",
        "chord",
        "systray",
        "cst_bluetooth",
        "memory",
        "cpu",
        "check_updates",
        "volume",
        "backlight",
        "wallpaper",
        "clock",
        "battery_icon",
        "battery",
        "quick_exit",
        "cst_entropy",
        "cst_moc",
        "spacer",
        "notify",
        "cst_dunst",
]
WidgetTheme = namedtuple(
    "WidgetTheme",
    _widgets,
    defaults=({},) * len(_widgets)
)


def build_widgets(
        group_size: str,
        theme: ColorScheme,
        battery_fmt: str,
        clock_fmt: str,
        countdown_fmt: str,
        qexit_fmt: str,
        wlan_co_fmt: str,
        wlan_dis_fmt: str,
        dunst_fmt: str,
       ) -> WidgetTheme:
    """
        Build a widget theme with some hints about the style.
        The user might only constrain some string formats, as the goal
        is the following:
             below is defined a general template for the colorscheme of the
             bar.
             The user is then encouraged to use the qtile-change-theme.sh
             script to modify the colors with predefined color palettes.

        Please refer to the signatures of the wrappers inside widgets.py.
        A non-existing parameter might cause qtile to crash, edit the
        color arragement with great care.
    """
    _group_box_misc_colors = {
        "active":        theme.sel_bg,
        "inactive":      theme.bg,
        "select":        theme.sel_fg,
        "line":         [theme.color4, theme.color4],
        "other_focus":   theme.color8,  # the color of focused group on other monitors
        "other_unfocus": theme.color8,  # the color of unfocused groups on other monitors
        "this_focus":    theme.sel_bg,  # the color of focused group on current monitor
        "this_unfocus":  theme.sel_bg,  # the color of unfocused groups on current monitor
        "urgent_border": theme.color9,
        "urgent_text":   theme.color9,
        "fontsize":      group_size,
    }
    return WidgetTheme(**{
        "current_layout": {"bg": theme.sel_bg,  "fg": theme.sel_fg},
        "current_screen": {"bg": theme.bg,      "fg": theme.fg,       "active": theme.color10, "inactive": theme.color9},
        "group_box":      {"bg": theme.bg,      "fg": theme.fg,       **_group_box_misc_colors},
        "window_name":    {"bg": theme.sel_bg,  "fg": theme.sel_fg},

        "cst_bluetooth":  {"bg": theme.bg,      "fg": theme.color10},
        "systray":        {"bg": theme.bg},
        "spacer":         {"bg": theme.bg},
        "chord":          {"bg": theme.bg,      "fg": theme.color1},
        "prompt":         {"bg": theme.bg,      "fg": theme.fg},
        "check_updates":  {"bg": theme.bg,      "fg": theme.color8},
        "df":             {"bg": theme.bg,      "fg": theme.color7},
        "volume":         {"bg": theme.bg,      "fg": theme.color3},
        "cst_moc":        {"bg": theme.bg,      "fg": theme.color11},
        "cst_entropy":    {"bg": theme.bg,      "fg": theme.color7},
        "wlan":           {"bg": theme.bg,      "fg": theme.color2,   "co_fmt": wlan_co_fmt, "dis_fmt": wlan_dis_fmt},
        "net":            {"bg": theme.bg,      "fg": theme.color10},
        "cpu":            {"bg": theme.bg,      "fg": theme.color7},
        "clock":          {"bg": theme.bg,      "fg": theme.color6,   "format": clock_fmt},
        "battery":        {"bg": theme.bg,      "fg": theme.color14,  "format": battery_fmt},
        "quick_exit":     {"bg": theme.bg,      "fg": theme.color1,   "text": qexit_fmt, "countdown": countdown_fmt},
        "notify":         {"bg": theme.bg,      "fg": theme.color14},
        "cst_dunst":      {"bg": theme.bg,      "fg": theme.color5,   "fmt": dunst_fmt},
    })
