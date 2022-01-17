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
    ]
)

Theme = namedtuple(
    "Theme",
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
        "font",
        "size",
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
)

widget_theme = Theme(
    black=[colors.black, colors.black],
    grey=[colors.grey, colors.grey],
    white=[colors.white, colors.white],
    red=[colors.red, colors.red],
    green=[colors.green, colors.green],
    orange=[colors.orange, colors.orange],
    yellow=[colors.yellow, colors.yellow],
    blue=[colors.blue, colors.blue],
    purple=[colors.purple, colors.purple],
    cyan=[colors.cyan, colors.cyan],
    lila=[colors.lila, colors.lila],
    font="mononoki",
    size=None,
)

bar_theme = dict(
    size=16,
    opacity=1.,
    background="#ff3333",
    # border_width=[2, 2, 2, 2],
    border_width=[0, 0, 2, 0],
    border_color=[colors.orange, colors.orange, colors.white, colors.orange]
)

# prompt = "{0}@{1}: ".format(os.environ=["USER"], socket.gethostname())
