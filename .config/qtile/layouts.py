#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __   __                        __
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  / /___ ___  ______  __  __/ /______         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   / / __ `/ / / / __ \/ / / / __/ ___/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/    / / /_/ / /_/ / /_/ / /_/ / /_(__  )   _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/     /_/\__,_/\__, /\____/\__,_/\__/____/   (_)  / .___/\__, /
#                                /____/              /_/                                /____/                             /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile import layout


def init_layouts():
    return [
        layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
        layout.Max(),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Matrix(),
        # layout.MonadTall(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]
