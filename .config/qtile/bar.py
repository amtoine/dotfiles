# *
# *                  _    __ _ _
# *   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
# *  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
# *  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
# *  |___/
# *          MAINTAINERS:
# *              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
# *              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
# *

import libqtile

from theme import theme
from style import BAR_STYLE
from style import WIDGETS as wt
from style import SEP_STYLE
from utils.constants import sep_styles
from utils.utils import fetch_monitors
import widgets


def _create_widgets_table(terminal: str) -> dict:
    """
        Returns the table of all implemented widget wrappers,
        with the arguments from the WidgetTheme to use for as
        the style.
    """
    # dict of the form {"key": [wrapper, args]}
    return {
        "current_screen": [widgets.current_screen, dict(**wt.current_screen)],
        "current_layout": [widgets.current_layout, dict(**wt.current_layout)],
        "group_box": [widgets.group_box, dict(**wt.group_box)],
        "window_name": [widgets.window_name, dict(**wt.window_name)],
        "chord": [widgets.chord, dict(**wt.chord)],
        "prompt": [widgets.prompt, dict(**wt.prompt)],
        "check_updates": [widgets.check_updates, dict(**wt.check_updates, terminal=terminal)],
        "df": [widgets.df, dict(**wt.df, terminal=terminal)],
        "volume": [widgets.volume, dict(**wt.volume, terminal=terminal)],
        "cst_moc": [widgets.cst_moc, dict(**wt.cst_moc, terminal=terminal)],
        "cst_entropy": [widgets.cst_entropy, dict(**wt.cst_entropy)],
        "wlan": [widgets.wlan, dict(**wt.wlan, terminal=terminal)],
        "net": [widgets.net, dict(**wt.net)],
        "cpu": [widgets.cpu, dict(**wt.cpu, terminal=terminal)],
        "clock": [widgets.clock, dict(**wt.clock, terminal=terminal)],
        "battery": [widgets.battery, dict(**wt.battery)],
        "quick_exit": [widgets.quick_exit, dict(**wt.quick_exit)],
        "spacer": [widgets.spacer, dict(**wt.spacer)],
        "notify": [widgets.notify, dict(**wt.notify)],
        "cst_dunst": [widgets.cst_dunst, dict(**wt.cst_dunst)],
        "systray": [widgets.systray, dict(**wt.systray)],
        "cst_bluetooth": [widgets.cst_bluetooth, dict(**wt.cst_bluetooth)],
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
        ["current_screen", "cst_dunst", "group_box", "window_name"],
        ["chord", "prompt", "volume", "wlan", "cst_bluetooth", "clock", "cpu", "battery", "quick_exit"],
    ],
    # normal
    [
        ["current_screen", "cst_dunst", "current_layout", "group_box", "window_name"],
        ["chord", "prompt", "check_updates", "df", "volume", "cst_moc", "cst_entropy", "wlan", "net", "cst_bluetooth", "cpu", "clock", "systray", "battery", "quick_exit"],
    ]
]


def init_bar_widgets(
        screen: int,
        terminal: str,
        prompt: libqtile.widget.Prompt = None,
        battery: libqtile.widget.Battery = None,
        ) -> list:
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
    widgets_list = []

    # build the left widgets
    # on the left, widget are separated by a powerline like arrow
    bg = theme.bg
    # go in reverse to get the colors in order for the arrow.
    for lf in left[::-1]:
        func, kwargs = table[lf]
        _bg = kwargs["bg"]

        # add the arrow and the widget with appropriate colors
        if lf in ["window_name", "current_layout"]:
            widgets_list.extend([
                widgets.right_arrow_sep(fg=_bg, bg=bg),
                func(**kwargs),
                widgets.right_arrow_sep(fg=bg, bg=_bg)])
        else:
            widgets_list.extend([func(**kwargs)])
        bg = _bg
    # reverse the list
    widgets_list = widgets_list[::-1]

    # add a spacer if the window_name widget is missing
    if left[-1] != "window_name":
        widgets_list.append(widgets.spacer(**wt.spacer))

    # build the right widgets
    # they are separated by vertical lines
    # no need for a fancy reverse color computation
    for rg in right:
        func, kwargs = table[rg]
        if SEP_STYLE in [sep_styles.vmono, sep_styles.smono]:
            fg = theme.color1
        elif "fg" not in kwargs:
            fg = theme.fg
        else:
            fg = kwargs["fg"] if "fg" in kwargs else theme.fg

        # add a separator
        if SEP_STYLE in [sep_styles.vmono, sep_styles.vcolor]:
            _sep = widgets.vertical_sep(fg=fg, bg=theme.bg, width=5, size=100)
        else:
            _sep = widgets.slash_sep(fg=fg, bg=theme.bg)

        # add the widget
        # widget.Prompt is a bit special and needs to be
        # manually mirrored on all monitors, hence the passing
        # of a widget.Prompt object from init to init.
        if rg == "prompt" and prompt is not None:
            widgets_list.extend([_sep, prompt])
        # widget.Battery is also mirrored to avoid
        # having multiple notifications when using
        # a multi monitor setup.
        elif rg == "battery" and battery is not None:
            widgets_list.extend([_sep, battery])
        # add widget unless systray and not on main monitor.
        elif not (screen > 0 and rg == "systray"):
            widgets_list.extend([_sep, func(**kwargs)])

    return widgets_list


def build_prompt(terminal: str) -> libqtile.widget.Prompt:
    """
        Build the special widget.Prompt widget.
        The Prompt widget is a bit special as it does not
        mirror by default on all monitors.
        A common widget.Prompt widget has to be given to
        all bars to allow the prompt to be the same on all
        monitors.
    """
    func, kwargs = _create_widgets_table(terminal)["prompt"]
    return func(**kwargs)


def build_battery(terminal: str) -> libqtile.widget.Battery:
    """
        Build the special widget.Batterywidget.
        The Prompt widget is a bit special as it does not
        mirror by default on all monitors.
        A common widget.Battery widget has to be given to
        all bars not to receive multiple notifications on
        low battery.
    """
    func, kwargs = _create_widgets_table(terminal)["battery"]
    return func(**kwargs)
