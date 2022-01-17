from collections import namedtuple

Colors = namedtuple(
    "Colors",
    [
        "black",
        "grey",
        "white",
        "red",
        "green",
        "orange",
        "yellow",
        "blue",
        "purple",
        "cyan",
        "lila",
        "marine",
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

colors = Colors(
    black="#282c34",
    grey="#1c1f24",
    white="#dfdfdf",
    red="#ff6c6b",
    green="#98be65",
    orange="#da8548",
    yellow="#dada22",
    blue="#51afef",
    purple="#c678dd",
    cyan="#46d9ff",
    lila="#a9a1e1",
    marine="#5555ff",
)

widget_theme = WidgetTheme(
    image=dict(bg=colors.grey),
    current_layout=dict(bg=colors.grey, fg=colors.white),
    current_screen=dict(bg=colors.black, fg=colors.white),
    group_box=dict(bg=colors.grey, fg=colors.white),
    prompt=dict(bg=colors.black, fg=colors.white),
    window_name=dict(bg=colors.grey, fg=colors.white),

    net=dict(bg=colors.yellow, fg=colors.black),
    wlan=dict(bg=colors.green, fg=colors.black),
    chord=dict(bg=colors.cyan, fg=colors.black),
    systray=dict(bg=colors.blue),
    memory=dict(bg=colors.purple, fg=colors.black),
    cpu=dict(bg=colors.lila, fg=colors.black),
    check_updates=dict(bg=colors.purple, fg=colors.black),
    volume=dict(bg=colors.blue, fg=colors.black),
    backlight=dict(bg=colors.cyan, fg=colors.black),
    wallpaper=dict(bg=colors.green, fg=colors.black),
    clock=dict(bg=colors.yellow, fg=colors.black),
    battery_icon=dict(bg=colors.grey),
    battery=dict(bg=colors.orange, fg=colors.black),
    quick_exit=dict(bg=colors.red, fg=colors.black),
)

bar_theme = dict(
    # N E S W
    size=16,
    opacity=1.,
    background="#ff3333",
    margin=[0, 0, 0, 0],
    # border_width=[2, 2, 2, 2],
    border_width=[0, 0, 1, 0],
    border_color=[colors.orange, colors.orange, colors.white, colors.orange]
)
