#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __                    _____
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  _________  ____  / __(_)___ _         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   / ___/ __ \/ __ \/ /_/ / __ `/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/    / /__/ /_/ / / / / __/ / /_/ /   _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/      \___/\____/_/ /_/_/ /_/\__, /   (_)  / .___/\__, /
#                                /____/              /_/                                               /____/        /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile.utils import guess_terminal

from groups import init_groups
from groups import link_groups_to_keys
from keys import init_keymap
from layouts import init_layouts
from mouse import init_mouse
from misc import *
from screens import init_fake_screens
from widgets import init_widget_defaults

mod = "mod4"
terminal = guess_terminal(preference=["kitty", "alacritty"])

keys = init_keymap(mod, terminal)

groups = init_groups()
link_groups_to_keys(groups, keys, mod)

layouts = init_layouts()

widget_defaults = init_widget_defaults()
extension_defaults = widget_defaults.copy()

fake_screens = init_fake_screens()

# Drag floating layouts.
mouse = init_mouse(mod)
