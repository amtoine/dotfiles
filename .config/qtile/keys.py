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

import os

from libqtile.config import Key
from libqtile.config import KeyChord
from libqtile.lazy import lazy

from extensions import window_list

HOME = "/home/ants"
SCRIPTS = HOME + "/scripts"
SPC = "space"
SHI = "shift"
CON = "control"
TAB = "Tab"
RET = "Return"
PER = "period"
COM = "comma"
BCL = "bracketleft"
BCR = "bracketright"
SLH = "slash"
F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12 = [f"F{i}" for i in range(1, 13)]
DMENU_RUN = "dmenu_run -c -l 10 -g 4 -p 'Run: '"
BROWSER = "tabbed -c surf -N -e"
PASSMENU = "passmenu -l 10 -c"
AUTOSTART = os.path.expanduser("~/.config/qtile/autostart.sh")
KILL_XAUTOLOCK = "killall -q xautolock"


def _emacs(eval=None):
    """
        TODO
    """
    res = "emacsclient -c -a 'emacs'"
    if eval is not None:
        res += f" --eval '({eval})'"
    return lazy.spawn(res), lazy.ungrab_chord()


def _dmenu(command):
    """
        TODO
    """
    return lazy.spawn(command), lazy.ungrab_chord()


def _script(script, terminal=None):
    """
        TODO
    """
    script = os.path.expanduser(os.path.join('~', "scripts", script))
    if terminal is not None:
        script = terminal + ' ' + script
    return lazy.spawn(script)


def _cmd(command):
    """
        TODO
    """
    return lazy.spawn(command)


def init_keymap(mod, terminal):
    """
        A list of available commands that can be bound to keys can be found
        at https://docs.qtile.org/en/latest/manual/config/lazy.html
    """
    km = []

    MOD = [mod]
    km.extend(
        [
            Key(MOD, 'b', _cmd(BROWSER),                      desc="my web browser."),
            Key(MOD, 'r', _cmd(DMENU_RUN),                    desc="Spawn a command using a dmenu prompt"),
            Key(MOD, 'h', lazy.layout.left(),                 desc="Move focus to left"),
            Key(MOD, 'j', lazy.layout.down(),                 desc="Move focus down"),
            Key(MOD, 'k', lazy.layout.up(),                   desc="Move focus up"),
            Key(MOD, 'l', lazy.layout.right(),                desc="Move focus to right"),
            Key(MOD, 'n', lazy.layout.normalize(),            desc="Reset all window sizes"),
            Key(MOD, 's', lazy.to_screen(0),                  desc='Keyboard focus to monitor 1'),
            Key(MOD, 'd', lazy.to_screen(1),                  desc='Keyboard focus to monitor 2'),
            Key(MOD, 'f', lazy.to_screen(2),                  desc='Keyboard focus to monitor 3'),
            Key(MOD, 'f', lazy.window.toggle_fullscreen(),    desc='toggle fullscreen'),
            Key(MOD, 'w', lazy.run_extension(window_list()),  desc="TODO"),
            KeyChord(MOD, 'z', [
                Key([], 'h', lazy.layout.grow(),              desc="TODO"),
                Key([], 'j', lazy.layout.normalize(),         desc="TODO"),
                Key([], 'k', lazy.layout.maximize(),          desc="TODO"),
                Key([], 'l', lazy.layout.shrink(),            desc="TODO"),
                ],
                mode="Windows"
            ),
            KeyChord(MOD, 'e', [
                Key([], 'e', *_emacs(),                       desc='Launch Emacs'),
                Key([], 'b', *_emacs("ibuffer"),              desc='Launch ibuffer inside Emacs'),
                Key([], 'd', *_emacs("dired nil"),            desc='Launch dired inside Emacs'),
                Key([], 'i', *_emacs("erc"),                  desc='Launch erc inside Emacs'),
                Key([], 'm', *_emacs("mu4e"),                 desc='Launch mu4e inside Emacs'),
                Key([], 'n', *_emacs("elfeed"),               desc='Launch elfeed inside Emacs'),
                Key([], 's', *_emacs("eshell"),               desc='Launch the eshell inside Emacs'),
                Key([], 'v', *_emacs("+vterm/here nil"),      desc='Launch vterm inside Emacs')
                ],
                mode="EMACS"
            ),
            KeyChord(MOD, 'p', [
                Key([], 'h', *_dmenu("dm-hub"),               desc='TODO'),
                Key([], 'e', *_dmenu("dm-confedit"),          desc='Choose a config file to edit'),
                Key([], 'i', *_dmenu("dm-maim"),              desc='Take screenshots via dmenu'),
                Key([], 'k', *_dmenu("dm-kill"),              desc='Kill processes via dmenu'),
                Key([], 'l', *_dmenu("dm-logout"),            desc='A logout menu'),
                Key([], 'm', *_dmenu("dm-man"),               desc='Search manpages in dmenu'),
                Key([], 'o', *_dmenu("dm-bookman"),           desc='Search your qutebrowser bookmarks and quickmarks'),
                Key([], 'r', *_dmenu("dm-reddit"),            desc='Search reddit via dmenu'),
                Key([], 's', *_dmenu("dm-websearch"),         desc='Search various search engines via dmenu'),
                Key([], 'p', *_dmenu(PASSMENU),               desc='Retrieve passwords with dmenu')
                ],
                mode="DMENU"
            ),
            Key(MOD, SPC, lazy.layout.next(),                 desc="Move window focus to other window"),
            Key(MOD, RET, _cmd(terminal),                     desc="Launch terminal"),
            Key(MOD, TAB, lazy.next_layout(),                 desc="Toggle between layouts"),
            Key(MOD, PER, lazy.next_screen(),                 desc='Move focus to next monitor'),
            Key(MOD, COM, lazy.prev_screen(),                 desc='Move focus to prev monitor'),
            Key(MOD, BCL, lazy.screen.prev_group(),           desc='TODO'),
            Key(MOD, BCR, lazy.screen.next_group(),           desc='TODO'),
            Key(MOD, SLH, lazy.screen.toggle_group(),         desc='TODO'),
            Key(MOD, F1,  _cmd("brightnessctl s 8-"),         desc="brightness of the main screen down."),
            Key(MOD, F2,  _cmd("brightnessctl s 8+"),         desc="brightness of the main screen up."),
            Key(MOD, F3,  _script("hdmi.brightness.sh -"),    desc="brightness of the second screen down."),
            Key(MOD, F4,  _script("hdmi.brightness.sh +"),    desc="brightness of the second screen up."),
            Key(MOD, F5,  _script("screenshot.sh window"),    desc="take a screenshot of everything or chose a window."),
            Key(MOD, F6,  _script("screenshot.sh full"),      desc="take a screenshot of everything or chose a window."),
            Key(MOD, F7,  _script("slock-cst.sh"),            desc="lock the computer."),
            Key(MOD, F8,  _script("lfrun.sh", terminal),      desc="my file explorer."),
            Key(MOD, F9,  _cmd(KILL_XAUTOLOCK),               desc="TODO"),
            Key(MOD, F10, _cmd(AUTOSTART),                    desc="TODO"),
        ]
    )
    MOD = [mod, CON]
    km.extend(
        [
            Key(MOD, "h", lazy.layout.grow_left(),         desc="Grow window to the left"),
            Key(MOD, "l", lazy.layout.grow_right(),        desc="Grow window to the right"),
            Key(MOD, "j", lazy.layout.grow_down(),         desc="Grow window down"),
            Key(MOD, "k", lazy.layout.grow_up(),           desc="Grow window up"),
            Key(MOD, "r", lazy.reload_config(),            desc="Reload the config"),
            Key(MOD, "q", lazy.shutdown(),                 desc="Shutdown Qtile"),
            Key(MOD, TAB, lazy.layout.rotate(),
                lazy.layout.flip(),                        desc='Switch which side main pane occupies (XmonadTall)'),
        ]
    )
    MOD = [mod, SHI]
    km.extend(
        [
            Key(MOD, "h", lazy.layout.shuffle_left(),      desc="Move window to the left"),
            Key(MOD, "j", lazy.layout.shuffle_down(),      desc="Move window down"),
            Key(MOD, "k", lazy.layout.shuffle_up(),        desc="Move window up"),
            Key(MOD, "l", lazy.layout.shuffle_right(),     desc="Move window to the right"),
            Key(MOD, "c", lazy.window.kill(),              desc="Kill focused window"),
            Key(MOD, "r", lazy.restart(),                  desc="Restarting Qtile"),
            Key(MOD, "h", lazy.layout.move_left(),         desc='Move up a section in treetab'),
            Key(MOD, "l", lazy.layout.move_right(),        desc='Move down a section in treetab'),
            Key(MOD, "f", lazy.window.toggle_floating(),   desc='toggle floating'),

            Key(MOD, RET, lazy.layout.toggle_split(),      desc="Toggle between split and unsplit sides of stack"),
            Key(MOD, TAB, lazy.prev_layout(),              desc="Toggle between layouts"),
        ]
    )
    return km
