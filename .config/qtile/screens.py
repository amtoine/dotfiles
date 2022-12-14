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

from libqtile import bar
from libqtile.config import Screen

from bar import init_bar_widgets
from bar import build_prompt
from bar import build_battery
from style import BAR_GEOMETRY
from utils.utils import fetch_monitors


def init_screens(terminal: str, use_bar: bool = True) -> list:
    """
        Builds the list of Screen to use for the session.
    """
    # do not forget to mirror the prompt manually
    prompt = build_prompt(terminal)
    battery = build_battery(terminal)

    # compute the list of monitors
    monitors = fetch_monitors()
    # extract their geometries
    geometries = [
        dict(zip(["x", "y", "width", "height"], monitor[1:]))
        for monitor in monitors
    ]
    bars = [
        bar.Bar(
            widgets=init_bar_widgets(i, terminal, prompt=prompt, battery=battery),
            **BAR_GEOMETRY
        ) if use_bar else None for i in range(len(geometries))
    ]

    # return one Screen object per monitor detected
    # and adapt its position and size to the geometry
    return [
        Screen(top=bar, **geometry) for bar, geometry in zip(bars, geometries)
    ]
