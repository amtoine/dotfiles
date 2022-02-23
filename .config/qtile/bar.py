#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __  _
#          __    / /  __ _    / / | |__  __ _ _ _  _ __ _  _
#      _  / _|  / /  / _` |  / /  | '_ \/ _` | '_|| '_ \ || |
#     (_) \__| /_/   \__, | /_/   |_.__/\__,_|_|(_) .__/\_, |
#                       |_|                       |_|   |__/
#
# Description:  constructs the bar based on widgets and geometry
# Dependencies: none
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

from theme import theme
from style import BAR_STYLE
from style import WIDGETS as wt
from style import SEP_STYLE
from utils import sep_styles
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
from widgets import cst_moc
from widgets import cst_entropy
from widgets import wlan
from widgets import net
from widgets import cpu
from widgets import clock
from widgets import battery
from widgets import quick_exit
from widgets import right_arrow_sep
from widgets import vertical_sep
from widgets import slash_sep
from widgets import spacer
from widgets import notify


def _create_widgets_table(terminal: str) -> dict:
    """
        Returns the table of all implemented widget wrappers,
        with the arguments from the WidgetTheme to use for as
        the style.
    """
    # dict of the form {"key": [wrapper, args]}
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
        "cst_moc": [cst_moc, dict(**wt.cst_moc, terminal=terminal)],
        "cst_entropy": [cst_entropy, dict(**wt.cst_entropy)],
        "wlan": [wlan, dict(**wt.wlan, terminal=terminal)],
        "net": [net, dict(**wt.net)],
        "cpu": [cpu, dict(**wt.cpu, terminal=terminal)],
        "clock": [clock, dict(**wt.clock, terminal=terminal)],
        "battery": [battery, dict(**wt.battery)],
        "quick_exit": [quick_exit, dict(**wt.quick_exit)],
        "spacer": [spacer, dict(**wt.spacer)],
        "notify": [notify, dict(**wt.notify)],
    }


# the widgets to include inside each predefined bar
_bar_styles = [
    # a bar is of the form:
    # [
    #     ["left-widget-1", "left-widget-2"],
    #     ["right-widget-1", "right-widget-2", "right-widget-3"],
    # ],

    # minimal
    [
        ["current_screen", "group_box"],
        ["chord", "prompt", "battery", "quick_exit"],
    ],
    # decreased
    [
        ["current_screen", "group_box", "window_name"],
        ["chord", "prompt", "volume", "wlan", "clock", "cpu", "battery", "quick_exit"],
    ],
    # normal
    [
        ["current_screen", "current_layout", "group_box", "window_name"],
        ["chord", "prompt", "check_updates", "df", "volume", "cst_moc", "cst_entropy", "wlan", "net", "cpu", "clock", "battery", "quick_exit"],
    ]
]


def _init_widgets(terminal: str) -> list:
    """
        Builds the widgets using the left and right
        widget lists from _bar_styles
    """
    # isolate left from right
    left, right = _bar_styles[BAR_STYLE]
    # remove the current_screen widget when there is only
    # one monitor
    if len(fetch_monitors()) == 1:
        left = list(filter(lambda s: s != "current_screen", left))
        right = list(filter(lambda s: s != "current_screen", right))

    table = _create_widgets_table(terminal)
    widgets = []

    # build the left widgets
    # on the left, widget are separated by a powerline like arrow
    bg = theme.bg
    # go in reverse to get the colors in order for the arrow.
    for lf in left[::-1]:
        func, kwargs = table[lf]
        _bg = kwargs["bg"]
        # add the arrow and the widget with appropriate colors
        widgets.extend([right_arrow_sep(fg=_bg, bg=bg), func(**kwargs)])
        bg = _bg
    # reverse the list
    widgets = widgets[::-1]

    # add a spacer if the window_name widget is missing
    if left[-1] != "window_name":
        widgets.append(spacer(**wt.spacer))

    # build the right widgets
    # they are separated by vertical lines
    # no need for a fancy reverse color computation
    for rg in right:
        func, kwargs = table[rg]
        if SEP_STYLE in [sep_styles.vmono, sep_styles.smono]:
            fg = theme.color1
        else:
            fg = kwargs["fg"] if "fg" in kwargs else theme.fg
        # add a separator and the widget
        if "fg" not in kwargs:
            _sep = vertical_sep(fg=theme.fg, bg=theme.bg, width=5, size=100)
        elif SEP_STYLE in [sep_styles.vmono, sep_styles.vcolor]:
            _sep = vertical_sep(fg=fg, bg=theme.bg, width=5, size=100)
        else:
            _sep = slash_sep(fg=fg, bg=theme.bg)
        widgets.extend([_sep, func(**kwargs)])

    return widgets


def init_widgets_screen1(terminal: str) -> list:
    """
        Select the widgets for screen 1
    """
    widgets = _init_widgets(terminal)
    return widgets


def init_widgets_screen2(terminal: str) -> list:
    """
        Select the widgets for screen 2
    """
    widgets = _init_widgets(terminal)
    return widgets
