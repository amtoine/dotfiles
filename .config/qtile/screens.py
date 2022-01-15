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
from libqtile import widget
from libqtile.config import Screen


def init_fake_screens():
    return [
        Screen(
            top=bar.Bar(
                [
                    widget.CurrentLayout(),
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Chord(
                        chords_colors={
                            'launch': ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),
                    widget.TextBox("default config", name="default"),
                    widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                    widget.Systray(),
                    widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                    widget.QuickExit(),
                ],
                24,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            ),
            x=0,
            y=0,
            width=1920,
            height=1080
        ),
        Screen(
            top=bar.Bar(
                [
                    widget.CurrentLayout(),
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Chord(
                        chords_colors={
                            'launch': ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),
                    widget.TextBox("default config", name="default"),
                    widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                    widget.Systray(),
                    widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                    widget.QuickExit(),
                ],
                24,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            ),
            x=1920,
            y=0,
            width=1920,
            height=1080
        ),
    ]
