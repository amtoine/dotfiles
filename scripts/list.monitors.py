#!/usr/bin/env python3
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   ___      __                                 _ __
#        _______________(_)___  / /______     _/_/  / (_)____/ /_         ____ ___  ____  ____  (_) /_____  __________         ____  __  __
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / / / ___/ __/        / __ `__ \/ __ \/ __ \/ / __/ __ \/ ___/ ___/        / __ \/ / / /
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / / (__  ) /_    _    / / / / / / /_/ / / / / / /_/ /_/ / /  (__  )   _    / /_/ / /_/ /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/_/____/\__/   (_)  /_/ /_/ /_/\____/_/ /_/_/\__/\____/_/  /____/   (_)  / .___/\__, /
#                     /_/                                                                                                  /_/    /____/
#
# Description:  prints the list of connected monitors with their positions and geometries.
#               inspired by https://askubuntu.com/questions/639495/how-can-i-list-connected-monitors-with-xrandr
# Dependencies: gi module
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

import gi
gi.require_version("Gdk", "3.0")
from gi.repository import Gdk


def fetch_monitors():
    allmonitors = []

    gdkdsp = Gdk.Display.get_default()
    for i in range(gdkdsp.get_n_monitors()):
        monitor = gdkdsp.get_monitor(i)
        scale = monitor.get_scale_factor()
        geo = monitor.get_geometry()
        allmonitors.append([
            monitor.get_model()] + [n * scale for n in [
                geo.x, geo.y, geo.width, geo.height
            ]
        ])

    print(allmonitors)


if __name__ == "__main__":
    fetch_monitors()
