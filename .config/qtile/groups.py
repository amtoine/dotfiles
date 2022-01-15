#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  ____ __________  __  ______  _____         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   / __ `/ ___/ __ \/ / / / __ \/ ___/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/    / /_/ / /  / /_/ / /_/ / /_/ (__  )   _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/      \__, /_/   \____/\__,_/ .___/____/   (_)  / .___/\__, /
#                                /____/              /_/                        /____/                /_/                 /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile.lazy import lazy
from libqtile.config import Group
from libqtile.config import Key


def init_groups():
    return [Group(i) for i in "123456789"]


def link_groups_to_keys(groups, keys, mod):
    for i in groups:
        keys.extend([
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),

            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ])
