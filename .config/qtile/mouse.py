#           ___                       personal page: https://amtoine.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/amtoine 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/amtoine/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __
#          __    / /  __ _    / /  _ __  ___ _  _ ___ ___   _ __ _  _
#      _  / _|  / /  / _` |  / /  | '  \/ _ \ || (_-</ -_)_| '_ \ || |
#     (_) \__| /_/   \__, | /_/   |_|_|_\___/\_,_/__/\___(_) .__/\_, |
#                       |_|                                |_|   |__/
#
# Description:  configure the mouse
# Dependencies: none
# License:      https://github.com/amtoine/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile.config import Drag
from libqtile.config import Click
from libqtile.lazy import lazy


def init_mouse(mod: str) -> list:
    """
        Some options for the mouse.
    """
    return [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
    ]
