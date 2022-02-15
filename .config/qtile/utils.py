from collections import namedtuple

import gi
gi.require_version("Gdk", "3.0")
from gi.repository import Gdk


def fetch_monitors():
    """
        TODO
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


# TODO
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

# TODO
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
        "entropy",
        "moc",
        "spacer"
]
WidgetTheme = namedtuple(
    "WidgetTheme",
    _widgets,
    defaults=({},) * len(_widgets)
)


def build_widgets(group_size, theme, battery_fmt, clock_fmt, count_fmt, qexit_fmt, wlan_co_fmt, wlan_dis_fmt):
    """
        TODO
    """
    _group_box_misc_colors = {
        "active":        theme.sel_bg,
        "inactive":      theme.bg,
        "select":        theme.sel_fg,
        "line":         [theme.color4, theme.color4],
        "other_focus":   theme.color8,
        "other_unfocus": theme.color8,
        "this_focus":    theme.sel_bg,
        "this_unfocus":  theme.sel_bg,
        "urgent_border": theme.color9,
        "urgent_text":   theme.color9,
        "fontsize":      group_size,
    }
    return WidgetTheme(**{
        "current_layout": {"bg": theme.sel_bg,  "fg": theme.sel_fg},
        "current_screen": {"bg": theme.bg,      "fg": theme.fg,      "active": theme.color10, "inactive": theme.color9},
        "group_box":      {"bg": theme.bg,      "fg": theme.fg,      **_group_box_misc_colors},
        "window_name":    {"bg": theme.sel_bg,  "fg": theme.sel_fg},

        "spacer":         {"bg": theme.bg},
        "chord":          {"bg": theme.bg,      "fg": theme.color1},
        "prompt":         {"bg": theme.bg,      "fg": theme.fg},
        "check_updates":  {"bg": theme.bg,      "fg": theme.color8},
        "df":             {"bg": theme.bg,      "fg": theme.color7},
        "volume":         {"bg": theme.bg,      "fg": theme.color3},
        "moc":            {"bg": theme.bg,      "fg": theme.color11},
        "entropy":        {"bg": theme.bg,      "fg": theme.color7},
        "wlan":           {"bg": theme.bg,      "fg": theme.color2, "co_fmt": wlan_co_fmt, "dis_fmt": wlan_dis_fmt},
        "net":            {"bg": theme.bg,      "fg": theme.color10},
        "cpu":            {"bg": theme.bg,      "fg": theme.color7},
        "clock":          {"bg": theme.bg,      "fg": theme.color6,   "format": clock_fmt},
        "battery":        {"bg": theme.bg,      "fg": theme.color14,  "format": battery_fmt},
        "quick_exit":     {"bg": theme.bg,      "fg": theme.color1,   "text": qexit_fmt, "countdown": count_fmt},
    })


# TODO
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

# TODO
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


def build_layouts(theme, border_width, margin):
    """
        TODO
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
        border_width=8,
        margin=8,
    )


# TODO
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
font_sizes = FontSizes(
    tiny=(17, 12, 5),
    small=(19, 16, 9),
    medium=(27, 24, 16),
    large=(36, 32, 23),
    huge=(58, 50, 37),
)

# TODO
Bars = namedtuple(
    "Bars",
    [
        "minimal",
        "decreased",
        "normal",
    ]
)
bars = Bars(
    # these are arbitrary indices.
    minimal=0,
    decreased=1,
    normal=2,
    )


def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    """
        TODO
    """
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    """
        TODO
    """
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i + 1)
