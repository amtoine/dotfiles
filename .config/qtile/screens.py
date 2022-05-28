#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __
#          __    / /  __ _    / /  ___ __ _ _ ___ ___ _ _  ___  _ __ _  _
#      _  / _|  / /  / _` |  / /  (_-</ _| '_/ -_) -_) ' \(_-<_| '_ \ || |
#     (_) \__| /_/   \__, | /_/   /__/\__|_| \___\___|_||_/__(_) .__/\_, |
#                       |_|                                    |_|   |__/
#
# Description:  configure the virtual screens used byt qtile
# Dependencies: none
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

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
