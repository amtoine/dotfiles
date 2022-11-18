from typing import List  # noqa: F401

from libqtile.config import DropDown
from libqtile.config import Group
from libqtile.config import ScratchPad
from libqtile.dgroups import simple_key_binder

from utils.utils import expand_terminal


def init_groups(terminal: str, shell: str):
    """
        Initializes somes groups to sort windows easier.

        Return the list of groups and the list of group names.
    """
    group_opts = [
        ["dv1", "TALL"],  # development
        ["dv2", "TALL"],  # development
        ["dv3", "TREE"],  # development
        ["www", "TALL"],  # internet
        ["cht", "TREE"],  # chat
        ["gam", "TALL"],  # games
        ["vid", "WIDE"],  # video
    ]
    groups = [
        Group(name, layout=layout)
        for name, layout in group_opts
    ]

    scratchpads = [
        ScratchPad(
            "sp1",
            [
                DropDown(
                    "term",   f"{expand_terminal(terminal)} {shell}",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "qshell", f"{expand_terminal(terminal)} qtile shell",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "python", f"{expand_terminal(terminal)} ptpython",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "cfg",    f"{expand_terminal(terminal)} lcfg.sh",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "sound",  f"{expand_terminal(terminal)} pulsemixer",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "music",  f"{expand_terminal(terminal)} mocp",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "clock",  f"{expand_terminal(terminal, fs=12)} termdown -z",
                    x=0.64, y=0.02, width=0.35, height=0.20, opacity=0.90,
                ),
                DropDown(
                    "fm",     f"{expand_terminal(terminal, fs=24)} lf",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "disk",   f"{expand_terminal(terminal, fs=24)} ncdu -x /",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "top",    f"{expand_terminal(terminal, fs=24)} btop",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
                DropDown(
                    "cava",   f"{expand_terminal(terminal, fs=24)} cava",
                    x=0.05, y=0.05, width=0.90, height=0.90, opacity=0.90,
                ),
            ]
        ),
    ]

    # use the zip function to isolate the name of each group.
    return groups + scratchpads, list(list(zip(*group_opts))[0])


# # Allow MODKEY+[0 through 9] to bind to groups,
# see https://docs.qtile.org/en/stable/manual/config/groups.html
# # MOD4 + index Number : Switch to Group[index]
# # MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder("mod4")
dgroups_app_rules = []  # type: List
