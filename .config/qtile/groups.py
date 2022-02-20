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

from libqtile.config import Group
from libqtile.dgroups import simple_key_binder


def init_groups():
    """
        Initializes somes groups to sort windows easier.
    """
    groups = [
        Group("D1",  layout="TALL"),  # development
        Group("I2",  layout="TALL"),  # internet
        Group("S3",  layout="TALL"),  # system
        Group("W4",  layout="TALL"),  # wiki
        Group("C5",  layout="TREE"),  # chat
        Group("M6",  layout="TALL"),  # music
        Group("V7",  layout="WIDE"),  # video
    ]
    # groups = [Group(i) for i in "123456789"]
    return groups


# # Allow MODKEY+[0 through 9] to bind to groups,
# see https://docs.qtile.org/en/stable/manual/config/groups.html
# # MOD4 + index Number : Switch to Group[index]
# # MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder("mod4")
dgroups_app_rules = []  # type: List
