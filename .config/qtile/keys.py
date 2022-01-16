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
from libqtile.config import KeyChord
from libqtile.lazy import lazy


SPC = "space"
SHI = "shift"
CON = "control"
TAB = "Tab"
RET = "Return"
PER = "period"
COM = "comma"
DMENU_RUN = "dmenu_run -c -l 10 -g 4 -p 'Run: '"


def init_keymap(mod, terminal):
    return [
        # A list of available commands that can be bound to keys can be found
        # at https://docs.qtile.org/en/latest/manual/config/lazy.html

        # Switch between windows
        Key([mod],      "h",  lazy.layout.left(),              desc="Move focus to left"),
        Key([mod],      "j",  lazy.layout.down(),              desc="Move focus down"),
        Key([mod],      "k",  lazy.layout.up(),                desc="Move focus up"),
        Key([mod],      "l",  lazy.layout.right(),             desc="Move focus to right"),
        Key([mod],      SPC,  lazy.layout.next(),              desc="Move window focus to other window"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, SHI], "h",  lazy.layout.shuffle_left(),      desc="Move window to the left"),
        Key([mod, SHI], "j",  lazy.layout.shuffle_down(),      desc="Move window down"),
        Key([mod, SHI], "k",  lazy.layout.shuffle_up(),        desc="Move window up"),
        Key([mod, SHI], "l",  lazy.layout.shuffle_right(),     desc="Move window to the right"),
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod, CON], "h",  lazy.layout.grow_left(),         desc="Grow window to the left"),
        Key([mod, CON], "l",  lazy.layout.grow_right(),        desc="Grow window to the right"),
        Key([mod, CON], "j",  lazy.layout.grow_down(),         desc="Grow window down"),
        Key([mod, CON], "k",  lazy.layout.grow_up(),           desc="Grow window up"),
        Key([mod],      "n",  lazy.layout.normalize(),         desc="Reset all window sizes"),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key([mod, SHI], RET,  lazy.layout.toggle_split(),      desc="Toggle between split and unsplit sides of stack"),
        Key([mod],      RET,  lazy.spawn(terminal),            desc="Launch terminal"),
        # Toggle between different layouts as defined below
        Key([mod],      TAB,  lazy.next_layout(),              desc="Toggle between layouts"),
        Key([mod, SHI], TAB,  lazy.prev_layout(),              desc="Toggle between layouts"),
        Key([mod, SHI], "c",  lazy.window.kill(),              desc="Kill focused window"),
        # system
        Key([mod, CON], "r",  lazy.reload_config(),            desc="Reload the config"),
        Key([mod, CON], "q",  lazy.shutdown(),                 desc="Shutdown Qtile"),
        Key([mod, SHI], "r",  lazy.restart(),                  desc="Spawn a command using a prompt widget"),
        # Key([mod],      "r",  lazy.spawncmd(),                 desc="Spawn a command using a prompt widget"),
        Key([mod],      "r",  lazy.spawn(DMENU_RUN),           desc="Spawn a command using a prompt widget"),
        # Switch focus to monitor
        Key([mod],      "s",  lazy.to_screen(0),               desc='Keyboard focus to monitor 1'),
        Key([mod],      "d",  lazy.to_screen(1),               desc='Keyboard focus to monitor 2'),
        Key([mod],      "f",  lazy.to_screen(2),               desc='Keyboard focus to monitor 3'),
        # Switch focus of monitors
        Key([mod],      PER,  lazy.next_screen(),              desc='Move focus to next monitor'),
        Key([mod],      COM,  lazy.prev_screen(),              desc='Move focus to prev monitor'),
        # Treetab controls
        Key([mod, SHI], "h",  lazy.layout.move_left(),         desc='Move up a section in treetab'),
        Key([mod, SHI], "l",  lazy.layout.move_right(),        desc='Move down a section in treetab'),
        # # Window controls
        Key([mod, SHI], "f",  lazy.window.toggle_floating(),   desc='toggle floating'),
        Key([mod],      "f",  lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
        # # Stack controls
        Key([mod, SHI], SPC,  lazy.layout.toggle_split(),      desc='Toggle between split and unsplit sides of stack'),
        # Key([mod, CON], TAB,  lazy.layout.rotate(), lazy.layout.flip(),                           desc='Switch which side main pane occupies (XmonadTall)'),

        # misc
        Key([mod], "b",  lazy.spawn("tabbed -c surf -N -e"),            desc="my web browser."),
        Key([mod], "F1", lazy.spawn("brightnessctl s 8-"),              desc="brightness of the main screen down."),
        Key([mod], "F2", lazy.spawn("brightnessctl s 8+"),              desc="brightness of the main screen up."),
        Key([mod], "F3", lazy.spawn(SCRIPTS + "/hdmi.brightness.sh -"), desc="brightness of the second screen down."),
        Key([mod], "F4", lazy.spawn(SCRIPTS + "/hdmi.brightness.sh +"), desc="brightness of the second screen up."),
        Key([mod], "F5", lazy.spawn(SCRIPTS + "/screenshot.sh window"), desc="take a screenshot of everything or chose a window."),
        Key([mod], "F6", lazy.spawn(SCRIPTS + "/screenshot.sh full"),   desc="take a screenshot of everything or chose a window."),
        Key([mod], "F7", lazy.spawn("kitty " + SCRIPTS + "/lfrun.sh"),  desc="my file explorer."),
        Key([mod], "F8", lazy.spawn(SCRIPTS + "/slock-cst.sh"),         desc="lock the computer."),
        KeyChord([mod], "z", [
            Key([], "g", lazy.layout.grow()),
            Key([], "s", lazy.layout.shrink()),
            Key([], "n", lazy.layout.normalize()),
            Key([], "m", lazy.layout.maximize())],
            mode="Windows"
        ),
        # Emacs programs chord.
        KeyChord([mod], "e", [
            Key([], "e", lazy.spawn("emacsclient -c -a 'emacs'"),                            desc='Launch Emacs'),
            Key([], "b", lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"),         desc='Launch ibuffer inside Emacs'),
            Key([], "d", lazy.spawn("emacsclient -c -a 'emacs' --eval '(dired nil)'"),       desc='Launch dired inside Emacs'),
            Key([], "i", lazy.spawn("emacsclient -c -a 'emacs' --eval '(erc)'"),             desc='Launch erc inside Emacs'),
            Key([], "m", lazy.spawn("emacsclient -c -a 'emacs' --eval '(mu4e)'"),            desc='Launch mu4e inside Emacs'),
            Key([], "n", lazy.spawn("emacsclient -c -a 'emacs' --eval '(elfeed)'"),          desc='Launch elfeed inside Emacs'),
            Key([], "s", lazy.spawn("emacsclient -c -a 'emacs' --eval '(eshell)'"),          desc='Launch the eshell inside Emacs'),
            Key([], "v", lazy.spawn("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"), desc='Launch vterm inside Emacs')
        ],
            # mode="emacs"
        ),
        # Dmenu scripts chord
        KeyChord([mod], "p", [
            Key([], "h", lazy.spawn("dm-hub"),            desc='TODO'),
            Key([], "e", lazy.spawn("dm-confedit"),       desc='Choose a config file to edit'),
            Key([], "i", lazy.spawn("dm-maim"),           desc='Take screenshots via dmenu'),
            Key([], "k", lazy.spawn("dm-kill"),           desc='Kill processes via dmenu'),
            Key([], "l", lazy.spawn("dm-logout"),         desc='A logout menu'),
            Key([], "m", lazy.spawn("dm-man"),            desc='Search manpages in dmenu'),
            Key([], "o", lazy.spawn("dm-bookman"),        desc='Search your qutebrowser bookmarks and quickmarks'),
            Key([], "r", lazy.spawn("dm-reddit"),         desc='Search reddit via dmenu'),
            Key([], "s", lazy.spawn("dm-websearch"),      desc='Search various search engines via dmenu'),
            Key([], "p", lazy.spawn("passmenu -l 10 -c"), desc='Retrieve passwords with dmenu')
        ],
            # mode="dmenu"
        )
    ]
