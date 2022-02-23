#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __       _   _ _
#          __    / /  __ _    / /  _  _| |_(_) |___  _ __ _  _
#      _  / _|  / /  / _` |  / /  | || |  _| | (_-<_| '_ \ || |
#     (_) \__| /_/   \__, | /_/    \_,_|\__|_|_/__(_) .__/\_, |
#                       |_|                         |_|   |__/
#
# Description:  a collection of classes, definitions and tool functions.
# Dependencies: gdk
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

from libqtile.lazy import lazy

from collections import namedtuple

import gi
gi.require_version("Gdk", "3.0")
from gi.repository import Gdk


def fetch_monitors() -> list:
    """
        Returns the list of connected monitors,
        containing their geometries.
        Greatly inspired from
        https://askubuntu.com/questions/639495/how-can-i-list-connected-monitors-with-xrandr
    """
    allmonitors = []

    gdkdsp = Gdk.Display.get_default()
    for i in range(gdkdsp.get_n_monitors()):
        monitor = gdkdsp.get_monitor(i)
        scale = monitor.get_scale_factor()
        geo = monitor.get_geometry()
        allmonitors.append([
            monitor.get_model()] + [n * scale for n in [
                geo.x, geo.y, geo.width, geo.height
            ]
        ])

    return allmonitors


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


def window_to_previous_screen(qtile,
                              switch_group: bool = False,
                              switch_screen: bool = False
                              ) -> None:
    """
        Sends current window to the previous screen.
        Computes the corresponding group and sends the
        window
    """
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile,
                          switch_group: bool = False,
                          switch_screen: bool = False
                          ) -> None:
    """
        Sends current window to the next screen.
        Computes the corresponding group and sends the
        window
    """
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i + 1)


@lazy.function
def float_to_front(qtile):
    """
        Make all floating windows to float lazily
        to the front on a key stroke.
    """
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()
