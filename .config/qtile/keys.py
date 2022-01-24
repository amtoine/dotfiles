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
from extensions import command_set
from style import BAR

SCRIPTS = "scripts"
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
DMENU_RUN = "dmenu_run -l 10 -p 'Run: '"
DMENU_RUN = f"dmenu_run -h {BAR['size']} -p 'Run: '"
EDITOR = " nvim"
SURF = "tabbed -c surf -N -e"
EMACS = "emacsclient -c -a 'emacs'"
PASSMENU = "passmenu -l 10 -c"
AUTOSTART = os.path.expanduser("~/.config/qtile/scripts/qtile-autostart.sh")
KILL_XAUTOLOCK = "killall -q xautolock"
CHECK = " --hold checkupdates"
PACMAN = " sudo pacman -Syu"
NCDU = " ncdu -x /"
DF = " --hold df -h"
HTOP = " htop"
CAL = " --hold cal -Y"
NMCLI = " --hold nmcli connection show"


def _emacs(eval=None):
    """
        TODO
    """
    return (
        lazy.spawn(EMACS if eval is None else EMACS + f" --eval '({eval})'"),
        lazy.ungrab_chord())


def _dmenu(command):
    """
        TODO
    """
    return lazy.spawn(command), lazy.ungrab_chord()


def _script(script, terminal=None, path=SCRIPTS):
    """
        TODO
    """
    script = os.path.expanduser(os.path.join('~', path, script))
    if terminal is not None:
        script = terminal + ' ' + script
    return lazy.spawn(script)


def _cmd(command):
    """
        TODO
    """
    return lazy.spawn(command)


def _mocp(terminal):
    """
        TODO
    """
    cmds = {
        # "play/pause": "[ $(mocp -i | wc -l) -lt 2 ] && mocp -p || mocp -G",
        "play/pause": "mocp -G",
        "next":       "mocp -f",
        "previous":   "mocp -r",
        "quit":       "mocp -x",
        "start":      "mocp -S",
        "open":        terminal + " mocp",
        "shuffle":    "mocp -t shuffle",
        "repeat":     "mocp -t repeat",
    }
    pre_cmds = ["[ $(mocp -i | wc -l) -lt 1 ] && mocp -S"]
    # pre_cmds = ["mocp -S"]
    return lazy.run_extension(command_set(commands=cmds, pre_commands=pre_cmds))


def _sys(command):
    """
        TODO
    """
    return lazy.spawn(command), lazy.ungrab_chord()


def _browser(browser):
    """
        TODO
    """
    return lazy.spawn(browser), lazy.ungrab_chord()


def _rofi(modi):
    """
        TODO
    """
    return lazy.spawn("rofi -show " + modi), lazy.ungrab_chord()


def init_keymap(mod, terminal):
    """
        A list of available commands that can be bound to keys can be found
        at https://docs.qtile.org/en/latest/manual/config/lazy.html
    """
    km = []

    MOD = [mod]
    km.extend(
        [
            Key(MOD, 't', lazy.spawncmd(),                    desc="TODO"),
            Key(MOD, 'd', _cmd(DMENU_RUN),                    desc="Spawn a command using a dmenu prompt"),
            Key(MOD, 'h', lazy.layout.left(),                 desc="Move focus to left"),
            Key(MOD, 'j', lazy.layout.down(),                 desc="Move focus down"),
            Key(MOD, 'k', lazy.layout.up(),                   desc="Move focus up"),
            Key(MOD, 'l', lazy.layout.right(),                desc="Move focus to right"),
            Key(MOD, 'u', lazy.to_screen(0),                  desc='Keyboard focus to monitor 1'),
            Key(MOD, 'i', lazy.to_screen(1),                  desc='Keyboard focus to monitor 2'),
            Key(MOD, 'o', lazy.to_screen(2),                  desc='Keyboard focus to monitor 3'),
            Key(MOD, 'f', lazy.window.toggle_fullscreen(),    desc='toggle fullscreen'),
            Key(MOD, 'w', lazy.run_extension(window_list()),  desc="TODO"),
            Key(MOD, 'n', _cmd(terminal + EDITOR),            desc="TODO"),
            Key(MOD, 'm', _mocp(terminal),                    desc="TODO"),
            KeyChord(MOD, 'r', [
                Key([], 'w', *_rofi("window"),                desc="TODO"),
                Key([], 'r', *_rofi("run"),                   desc="TODO"),
                Key([], 's', *_rofi("ssh"),                   desc="TODO"),
                Key([], 'd', *_rofi("drun"),                  desc="TODO"),
                Key([], 'c', *_rofi("combi"),                 desc="TODO"),
                Key([], 'k', *_rofi("keys"),                  desc="TODO"),
                Key([], 'f', *_rofi("filebrowser"),           desc="TODO"),
                ],
                mode=" ROFI"
            ),
            KeyChord(MOD, 'b', [
                Key([], 's', *_browser(SURF),                 desc="TODO"),
                Key([], 'f', *_browser("firefox"),            desc="TODO"),
                Key([], 'c', *_browser("chromium"),           desc="TODO"),
                ],
                mode=" BROWSER"
            ),
            KeyChord(MOD, 's', [
                Key([], 't', *_sys(terminal),                 desc="TODO"),
                Key([], 'c', *_sys(terminal + CHECK),         desc="TODO"),
                Key([], 'u', *_sys(terminal + PACMAN),        desc="TODO"),
                Key([], 'd', *_sys(terminal + NCDU),          desc="TODO"),
                Key([], 'f', *_sys(terminal + DF),            desc="TODO"),
                Key([], 'h', *_sys(terminal + HTOP),          desc="TODO"),
                Key([], 'y', *_sys(terminal + CAL),           desc="TODO"),
                Key([], 'n', *_sys(terminal + NMCLI),         desc="TODO"),
                Key([], 'b', *_sys("blueman-manager"),        desc="TODO"),
                ],
                mode=" SYSTEM"
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
                mode=" EMACS"
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
                mode=" PROMPT"
            ),
            KeyChord(MOD, 'z', [
                Key([], 'h',
                    lazy.layout.grow_left().when(layout=["COLS", " BSP"]),
                    lazy.layout.grow().when(layout="WIDE"),
                    lazy.layout.shrink_main().when(layout="TALL"),          desc="TODO"),
                Key([], 'j',
                    lazy.layout.grow_down().when(layout=["COLS", " BSP"]),
                    lazy.layout.grow_main().when(layout="WIDE"),
                    lazy.layout.grow().when(layout="TALL"),                 desc="TODO"),
                Key([], 'k',
                    lazy.layout.grow_up().when(layout=["COLS", " BSP"]),
                    lazy.layout.shrink_main().when(layout="WIDE"),
                    lazy.layout.shrink().when(layout="TALL"),               desc="TODO"),
                Key([], 'l',
                    lazy.layout.grow_right().when(layout=["COLS", " BSP"]),
                    lazy.layout.shrink().when(layout="WIDE"),
                    lazy.layout.grow_main().when(layout="TALL"),            desc="TODO"),
                Key([], 'n', lazy.layout.normalize(),                       desc="TODO"),
                Key([], 'm', lazy.layout.maximize(),                        desc="TODO"),
                Key([], 'r', lazy.layout.reset(),                           desc="TODO"),
                Key([], 'z', lazy.ungrab_chord(),                           desc="TODO"),
                Key([], RET, lazy.ungrab_chord(),                           desc="TODO"),
                ],
                mode=" RESIZE"
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
            Key(MOD, F11, _script(
                "qtile-change-theme.sh",
                terminal + " --hold",
                ".config/qtile/scripts"),                     desc="TODO"),
        ]
    )
    MOD = [mod, CON]
    km.extend(
        [
            Key(MOD, 'h',
                lazy.layout.increase_ratio().when(layout="RTIO"),
                lazy.layout.swap_column_left().when(layout=["COLS"]),     desc="TODO"),
            Key(MOD, 'l',
                lazy.layout.decrease_ratio().when(layout="RTIO"),
                lazy.layout.swap_column_right().when(layout=["COLS"]),    desc="TODO"),
            Key(MOD, "r", lazy.reload_config(),                           desc="Reload the config"),
            Key(MOD, "q", lazy.shutdown(),                                desc="Shutdown Qtile"),
            Key(MOD, RET,
                lazy.layout.toggle_split().when(layout=["COLS", " BSP"]),
                lazy.layout.flip().when(layout=["TALL", "WIDE"]),         desc='TODO, Toggle between split and unsplit sides of stack'),
        ]
    )
    MOD = [mod, SHI]
    km.extend(
        [
            Key(MOD, "h",
                lazy.layout.shuffle_left().when(layout=["COLS", " BSP"]),
                lazy.layout.shuffle_up().when(layout="WIDE"),
                lazy.layout.swap_left().when(layout="TALL"),                      desc="TODO"),
            Key(MOD, "j",
                lazy.layout.shuffle_down().when(layout=["COLS", " BSP", "TALL"]),
                lazy.layout.swap_left().when(layout="WIDE"),                      desc="Move window down"),
            Key(MOD, "k",
                lazy.layout.shuffle_up().when(layout=["COLS", " BSP", "TALL"]),
                lazy.layout.swap_right().when(layout="WIDE"),                     desc="Move window up"),
            Key(MOD, "l",
                lazy.layout.shuffle_right().when(layout=["COLS", " BSP"]),
                lazy.layout.shuffle_down().when(layout="WIDE"),
                lazy.layout.swap_right().when(layout="TALL"),                     desc="TODO"),
            Key(MOD, "c", lazy.window.kill(),                                     desc="Kill focused window"),
            Key(MOD, "r", lazy.restart(),                                         desc="Restarting Qtile"),
            Key(MOD, "f", lazy.window.toggle_floating(),                          desc='toggle floating'),
            Key(MOD, TAB, lazy.prev_layout(),                                     desc="Toggle between layouts"),
        ]
    )
    return km
