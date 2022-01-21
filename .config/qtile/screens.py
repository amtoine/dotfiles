#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  __________________  ___  ____  _____         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   / ___/ ___/ ___/ _ \/ _ \/ __ \/ ___/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/    (__  ) /__/ /  /  __/  __/ / / (__  )   _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/     /____/\___/_/   \___/\___/_/ /_/____/   (_)  / .___/\__, /
#                                /____/              /_/                                                                    /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile import bar
from libqtile.config import Screen

from widgets import init_widgets_screen1
from themes import bar_theme
from utils import fetch_monitors


def init_screens(terminal):
    """
        TODO
    """
    monitors = fetch_monitors()
    geometries = [
        dict(zip(["x", "y", "width", "height"], monitor[1:]))
        for monitor in monitors
    ]
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(terminal), **bar_theme), **geometry)
        for geometry in geometries
    ]
