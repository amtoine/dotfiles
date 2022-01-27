from utils import WidgetTheme
from utils import Layout
from utils import LayoutTheme
from utils import font_sizes

from theme import theme


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
    "urgent_text":   theme.color9
}
_battery_fmt = "{char} {percent:2.0%} {hour:d}:{min:02d}"
_battery_fmt = "{char}{percent:2.0%}"
_clock_fmt = " %a, %m/%d/%y - %H:%M "
_clock_fmt = " %m/%d  %H:%M"
_count_fmt = "{}"
_qexit_fmt = "襤"
WIDGETS = WidgetTheme(**{
    "current_layout": {"bg": theme.sel_bg,  "fg": theme.sel_fg},
    "current_screen": {"bg": theme.bg,      "fg": theme.fg,      "active": theme.color10, "inactive": theme.color9},
    "group_box":      {"bg": theme.bg,      "fg": theme.fg,      **_group_box_misc_colors},
    "window_name":    {"bg": theme.sel_bg,  "fg": theme.sel_fg},

    "chord":          {"bg": theme.bg,      "fg": theme.color1},
    "prompt":         {"bg": theme.bg,      "fg": theme.color0},
    "check_updates":  {"bg": theme.bg,      "fg": theme.color8},
    "volume":         {"bg": theme.bg,      "fg": theme.color3},
    "moc":            {"bg": theme.bg,      "fg": theme.color11},
    "df":             {"bg": theme.bg,      "fg": theme.color7},
    "wlan":           {"bg": theme.bg,      "fg": theme.color2},
    "net":            {"bg": theme.bg,      "fg": theme.color10},
    "cpu":            {"bg": theme.bg,      "fg": theme.color7},
    "entropy":        {"bg": theme.bg,      "fg": theme.color9},
    "clock":          {"bg": theme.bg,      "fg": theme.color13,  "format": _clock_fmt},
    "battery":        {"bg": theme.bg,      "fg": theme.color6,   "format": _battery_fmt},
    "quick_exit":     {"bg": theme.bg,      "fg": theme.color0,   "text": _qexit_fmt, "countdown": _count_fmt},

    "image":          {"bg": theme.bg},
    "systray":        {"bg": theme.color2},
    "memory":         {"bg": theme.bg,      "fg": theme.color10},
    "backlight":      {"bg": theme.bg,      "fg": theme.color4},
    "wallpaper":      {"bg": theme.bg,      "fg": theme.color12},
    "battery_icon":   {"bg": theme.bg},
})

_layouts = {
    "bsp":        {"focus": theme.color12, "normal": theme.color2},
    "columns":    {"focus": theme.color12, "normal": theme.color2, "focus_stack": theme.color1, "normal_stack": theme.color8},
    "monad_tall": {"focus": theme.color1,  "normal": theme.color2},
    "monad_wide": {"focus": theme.color1,  "normal": theme.color2},

    "ratio":      {"focus": theme.color1, "normal": theme.color2},
    "stack":      {"focus": theme.color1, "normal": theme.color2},
    "tile":       {"focus": theme.color1, "normal": theme.color2},
    "vertical":   {"focus": theme.color1, "normal": theme.color2},
    "floating":   {"focus": theme.color1, "normal": theme.color2},
    "matrix":     {"focus": theme.color1, "normal": theme.color2},
}

LAYOUTS = LayoutTheme(
    **dict(zip(_layouts.keys(), [Layout(**args) for args in _layouts.values()])),
    border_width=8,
    margin=8,
)

FONT = "mononoki Nerd Font"
DMFONT = "mononoki Nerd Font-20"
ARROW_SIZE, SIZE = font_sizes.medium

_bar_width = LAYOUTS.border_width // 2
_border = (0, 0, 1, 0)
BAR = dict(
    size=SIZE,
    opacity=1,
    background=theme.bg,
    margin=[0, 0, 0, 0],         # N E S W
    border_width=list(map(lambda x: x * _bar_width, _border)),
    border_color=[theme.sel_bg, theme.sel_bg, theme.sel_bg, theme.sel_bg]
)
