#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __   __
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  / /_____  __  _______         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   / //_/ _ \/ / / / ___/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/    / ,< /  __/ /_/ (__  )   _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/     /_/|_|\___/\__, /____/   (_)  / .___/\__, /
#                                /____/              /_/                                  /____/             /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile.config import Key
from libqtile.lazy import lazy


def init_keymap(mod, terminal):
    return [
        # A list of available commands that can be bound to keys can be found
        # at https://docs.qtile.org/en/latest/manual/config/lazy.html

        # Switch between windows
        Key([mod], "h",     lazy.layout.left(),  desc="Move focus to left"),
        Key([mod], "l",     lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j",     lazy.layout.down(),  desc="Move focus down"),
        Key([mod], "k",     lazy.layout.up(),    desc="Move focus up"),
        Key([mod], "space", lazy.layout.next(),  desc="Move window focus to other window"),
        Key([mod], "h",     lazy.layout.left(),  desc="Move focus to left"),

        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(),  desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(),  desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(),    desc="Move window up"),

        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod, "control"], "h", lazy.layout.grow_left(),  desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(),  desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(),    desc="Grow window up"),
        Key([mod],            "n", lazy.layout.normalize(),  desc="Reset all window sizes"),

        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
        Key([mod],          "Return", lazy.spawn(terminal),       desc="Launch terminal"),

        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "w",   lazy.window.kill(), desc="Kill focused window"),

        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(),      desc="Shutdown Qtile"),
        Key([mod, "shift"],   "r", lazy.restart(),       desc="Spawn a command using a prompt widget"),
        Key([mod],            "r", lazy.spawncmd(),      desc="Spawn a command using a prompt widget"),

        Key([mod],            "p", lazy.spawn("dmenu_run"),   desc="dmenu_run"),
        Key([mod],            "a", lazy.spawn("dm-hub"),      desc="dm-hub"),
        Key([mod],            "e", lazy.spawn("dm-confedit"), desc="dm-hub"),
        Key([mod],            "y", lazy.spawn("dm-youtube"),  desc="dm-hub"),
    ]
