#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __
#          __    / /  __ _    / /  __ _ _ _ ___ _  _ _ __ ___  _ __ _  _
#      _  / _|  / /  / _` |  / /  / _` | '_/ _ \ || | '_ (_-<_| '_ \ || |
#     (_) \__| /_/   \__, | /_/   \__, |_| \___/\_,_| .__/__(_) .__/\_, |
#                       |_|       |___/             |_|       |_|   |__/
#
# Description:  initializes all the groups used in the config.
# Dependencies: none
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

from typing import List  # noqa: F401

from libqtile.config import DropDown
from libqtile.config import Group
from libqtile.config import ScratchPad
from libqtile.dgroups import simple_key_binder


def init_groups():
    """
        Initializes somes groups to sort windows easier.

        Return the list of groups and the list of group names.
    """
    group_opts = [
        ["1 ", "TALL"],  # development
        ["2 ", "TALL"],  # development
        ["3 ", "TREE"],  # development
        [" ",  "TALL"],  # internet
        [" ",  "TREE"],  # chat
        [" ",  "TALL"],  # music
        [" ",  "WIDE"],  # video
    ]
    groups = [
        Group(name, layout=layout)
        for name, layout in group_opts
    ]

    scratchpads = [
        ScratchPad("sp1", [
            DropDown(
                "term",   "st",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
            DropDown(
                "qshell", "st -e qtile shell",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
            DropDown(
                "python", "st -e ptpython",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
            DropDown(
                "lcfg",   "st -e lcfg.sh",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
            DropDown(
                "tcfg",   "st -e tcfg.sh",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
            DropDown(
                "mocp",   "st -e mocp",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
            DropDown(
                "clock",  "st -z 16 -e termdown -z",
                x=0.18, y=0.30, width=0.64, height=0.40, opacity=0.90,
            ),
            DropDown(
                "fm",  "st -z 24 -e lf",
                x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
            ),
        ]),
    ]

    # use the zip function to isolate the name of each group.
    return groups + scratchpads, list(list(zip(*group_opts))[0])


# # Allow MODKEY+[0 through 9] to bind to groups,
# see https://docs.qtile.org/en/stable/manual/config/groups.html
# # MOD4 + index Number : Switch to Group[index]
# # MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder("mod4")
dgroups_app_rules = []  # type: List
