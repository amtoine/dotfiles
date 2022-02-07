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
]
WidgetTheme = namedtuple(
    "WidgetTheme",
    _widgets,
    defaults=({},) * len(_widgets)
)

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

FontSizes = namedtuple(
    "FontSized",
    [
        "small",
        "medium",
        "large",
    ]
)
font_sizes = FontSizes(
    small=(19, 16),
    medium=(27, 24),
    large=(36, 32)
    )
