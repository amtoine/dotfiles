from utils import WidgetTheme
from utils import Layout
from utils import LayoutTheme

from current_scheme import theme

clock_format = " %a, %m/%d/%y - %H:%M "
clock_format = " %m/%d  %H:%M"
battery_format = "{char} {percent:2.0%} {hour:d}:{min:02d}"
battery_format = "{char}{percent:2.0%}"

group_box_misc_colors = {
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
widget_theme = WidgetTheme(**{
    "current_layout": {"bg": theme.sel_bg,  "fg": theme.sel_fg},
    "current_screen": {"bg": theme.bg,      "fg": theme.fg,      "active": theme.color10, "inactive": theme.color9},
    "group_box":      {"bg": theme.bg,      "fg": theme.fg,      **group_box_misc_colors},
    "window_name":    {"bg": theme.sel_bg,  "fg": theme.sel_fg},

    "prompt":         {"bg": theme.bg,      "fg": theme.color0},
    "chord":          {"bg": theme.bg,      "fg": theme.color0},
    "check_updates":  {"bg": theme.bg,      "fg": theme.color8},
    "df":             {"bg": theme.bg,      "fg": theme.color7},
    "wlan":           {"bg": theme.bg,      "fg": theme.color2},
    "net":            {"bg": theme.bg,      "fg": theme.color3},
    "cpu":            {"bg": theme.bg,      "fg": theme.color7},
    "clock":          {"bg": theme.bg,      "fg": theme.color13,  "format": clock_format},
    "battery":        {"bg": theme.bg,      "fg": theme.color6,   "format": battery_format},
    "quick_exit":     {"bg": theme.bg,      "fg": theme.color0,   "text": "襤", "countdown": "{}"},

    "image":          {"bg": theme.bg},
    "systray":        {"bg": theme.color2},
    "memory":         {"bg": theme.bg,      "fg": theme.color10},
    "volume":         {"bg": theme.bg,      "fg": theme.color11},
    "backlight":      {"bg": theme.bg,      "fg": theme.color4},
    "wallpaper":      {"bg": theme.bg,      "fg": theme.color12},
    "battery_icon":   {"bg": theme.bg},
})

layouts = {
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

layout_theme = LayoutTheme(
    **dict(zip(layouts.keys(), [Layout(**args) for args in layouts.values()])),
    border_width=8,
    margin=8,
)

FONT = "mononoki Nerd Font"
ARROW_SIZE = 24

bar_width = layout_theme.border_width // 2
border = (0, 0, 1, 0)
bar_theme = dict(
    size=20,
    opacity=.8,
    background=theme.bg,
    margin=[0, 0, 0, 0],         # N E S W
    border_width=list(map(lambda x: x * bar_width, border)),
    border_color=[theme.sel_bg, theme.sel_bg, theme.sel_bg, theme.sel_bg]
)
