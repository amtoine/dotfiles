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

from bar import init_widgets_screen1
from style import BAR_GEOMETRY
from utils import fetch_monitors


def init_screens(terminal: str) -> list:
    """
        Builds the list of Screen to use for the session.
    """
    # compute the list of monitors
    monitors = fetch_monitors()
    # extract their geometries
    geometries = [
        dict(zip(["x", "y", "width", "height"], monitor[1:]))
        for monitor in monitors
    ]
    # return one Screen object per monitor detected
    # and adapt its position and size to the geometry
    return [
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(terminal),
                        **BAR_GEOMETRY),
            **geometry
        ) for geometry in geometries
    ]
