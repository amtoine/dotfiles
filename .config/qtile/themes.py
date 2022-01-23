from collections import namedtuple

ColorScheme = namedtuple(
    "ColorScheme",
    [
        "bg",
        "fg",
        "cursor",
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
)

WidgetTheme = namedtuple(
    "WidgetTheme",
    [
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
    ]
)

Layout = namedtuple(
    "Layout",
    [
        "focus",
        "normal",
        "focus_stack",
        "normal_stack",
    ],
    defaults=(None, None, None, None)
)

LayoutTheme = namedtuple(
    "LayoutTheme",
    [
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
        "border_width",
        "margin",
    ]
)

vibrant_ink = ColorScheme(**{
    "bg":       "#000000",
    "fg":       "#ffffff",
    "cursor":   "#ffffff",
    "sel_bg":   "#b4d5ff",
    "sel_fg":   "#000000",
    "color0":   "#868686",  # grey
    "color8":   "#545454",
    "color1":   "#ff6600",  # red
    "color9":   "#ff0000",
    "color2":   "#ccff04",  # green
    "color10":  "#00ff00",
    "color3":   "#ffcc00",  # yellow
    "color11":  "#ffff00",
    "color4":   "#44b3cc",  # blue
    "color12":  "#0000ff",
    "color5":   "#9933cc",  # magenta
    "color13":  "#ff00ff",
    "color6":   "#44b3cc",  # cyan
    "color14":  "#00ffff",
    "color7":   "#f4f4f4",  # white
    "color15":  "#e5e5e5",
})
batman = ColorScheme(**{
    "bg":       "#1b1d1e",
    "fg":       "#6e6e6e",
    "cursor":   "#fcee0b",
    "sel_bg":   "#4d4f4c",
    "sel_fg":   "#1b1d1e",
    "color0":   "#1b1d1e",  # grey
    "color8":   "#505354",
    "color1":   "#e6db43",  # red
    "color9":   "#fff68d",
    "color2":   "#c8be46",  # green
    "color10":  "#fff27c",
    "color3":   "#f3fd21",  # yellow
    "color11":  "#feed6c",
    "color4":   "#737074",  # blue
    "color12":  "#909495",
    "color5":   "#737271",  # magenta
    "color13":  "#9a999d",
    "color6":   "#615f5e",  # cyan
    "color14":  "#a2a2a5",
    "color7":   "#c5c5be",  # white
    "color15":  "#dadad5",
})
chalk = ColorScheme(**{
    "bg":       "#2b2c2e",
    "fg":       "#d2d8d9",
    "cursor":   "#708183",
    "sel_bg":   "#e3e8ed",
    "color0":   "#7c8a8f",  # grey
    "color8":   "#888888",
    "color1":   "#b23a51",  # red
    "color9":   "#f24840",
    "color2":   "#789a69",  # green
    "color10":  "#80c46f",
    "color3":   "#b9ab4a",  # yellow
    "color11":  "#ffeb62",
    "color4":   "#2a7fac",  # blue
    "color12":  "#4095ff",
    "color5":   "#bc4f5a",  # magenta
    "color13":  "#fb5175",
    "color6":   "#44a799",  # cyan
    "color14":  "#52ccbd",
    "color7":   "#d2d8d9",  # white
    "color15":  "#d2d8d9",
    "sel_fg":   "#2b2c2e",
})
# _default = ColorScheme(**{
# })

theme = chalk

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
    "wlan":           {"bg": theme.bg,      "fg": theme.color2},
    "net":            {"bg": theme.bg,      "fg": theme.color3},
    "df":             {"bg": theme.bg,      "fg": theme.color7},
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

bar_theme = dict(
    size=20,
    opacity=.8,
    background=theme.bg,
    margin=[0, 0, 0, 0],         # N E S W
    # border_width=[0, 0, layout_theme.border_width // 2, 0],
    border_color=[theme.color6, theme.color6, theme.color6, theme.color6]
)
