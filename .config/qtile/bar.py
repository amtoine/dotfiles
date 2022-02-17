from theme import theme
from style import BAR
from style import WIDGETS as wt
from utils import fetch_monitors
from widgets import current_screen
from widgets import current_layout
from widgets import group_box
from widgets import window_name
from widgets import chord
from widgets import prompt
from widgets import check_updates
from widgets import df
from widgets import volume
from widgets import moc
from widgets import entropy
from widgets import wlan
from widgets import net
from widgets import cpu
from widgets import clock
from widgets import battery
from widgets import quick_exit
from widgets import powerline_right_arrow
from widgets import sep
from widgets import spacer
from widgets import notify


def _create_widgets_table(terminal):
    """
        TODO
    """
    return {
        "current_screen": [current_screen, dict(**wt.current_screen)],
        "current_layout": [current_layout, dict(**wt.current_layout)],
        "group_box": [group_box, dict(**wt.group_box)],
        "window_name": [window_name, dict(**wt.window_name)],
        "chord": [chord, dict(**wt.chord)],
        "prompt": [prompt, dict(**wt.prompt)],
        "check_updates": [check_updates, dict(**wt.check_updates, terminal=terminal)],
        "df": [df, dict(**wt.df, terminal=terminal)],
        "volume": [volume, dict(**wt.volume, terminal=terminal)],
        "moc": [moc, dict(**wt.moc, terminal=terminal)],
        "entropy": [entropy, dict(**wt.entropy)],
        "wlan": [wlan, dict(**wt.wlan, terminal=terminal)],
        "net": [net, dict(**wt.net)],
        "cpu": [cpu, dict(**wt.cpu, terminal=terminal)],
        "clock": [clock, dict(**wt.clock, terminal=terminal)],
        "battery": [battery, dict(**wt.battery)],
        "quick_exit": [quick_exit, dict(**wt.quick_exit)],
        "spacer": [spacer, dict(**wt.spacer)],
        "notify": [notify, dict(**wt.notify)],
    }


# TODO
_bar_styles = [
    [
        ["current_screen", "group_box"],
        ["chord", "prompt", "battery", "quick_exit"],
    ],
    [
        ["current_screen", "group_box", "window_name"],
        ["chord", "prompt", "volume", "wlan", "clock", "cpu", "battery", "quick_exit"],
    ],
    [
        ["current_screen", "current_layout", "group_box", "window_name"],
        ["chord", "prompt", "check_updates", "df", "volume", "moc", "entropy", "wlan", "net", "cpu", "clock", "battery", "quick_exit"],
    ]
]


def _init_widgets(terminal):
    """
        TODO
    """
    left, right = _bar_styles[BAR]
    if len(fetch_monitors()) == 1:
        left = list(filter(lambda s: s != "current_screen", left))
        right = list(filter(lambda s: s != "current_screen", right))

    table = _create_widgets_table(terminal)
    widgets = []
    bg = theme.bg
    for lf in left[::-1]:
        func, kwargs = table[lf]
        _bg = kwargs["bg"]
        widgets.extend([powerline_right_arrow(fg=_bg, bg=bg), func(**kwargs)])
        bg = _bg
    widgets = widgets[::-1]

    if left[-1] != "window_name":
        widgets.append(spacer(**wt.spacer))

    for rg in right:
        func, kwargs = table[rg]
        fg = kwargs["fg"] if "fg" in kwargs else theme.bg
        _sep = sep(fg=fg, bg=theme.bg, width=5, size=100)
        widgets.extend([_sep, func(**kwargs)])

    return widgets


def init_widgets_screen1(terminal):
    """
        TODO
    """
    widgets = _init_widgets(terminal)
    return widgets


def init_widgets_screen2(terminal):
    """
        TODO
    """
    widgets = _init_widgets(terminal)
    return widgets
