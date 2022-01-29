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
from style import BAR
from style import DMFONT

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
F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12 = (
    f"F{i}" for i in range(1, 13)
    )

DMRUN = f"dmenu_run -h {BAR['size']} -p 'Run: ' -fn '{DMFONT}'"
PASS = f"passmenu -l 10 -c -fn '{DMFONT}'"
NVIM = " nvim"
SURF = "tabbed -c surf -N -e"
EMACS = "emacsclient -c -a 'emacs'"
RESTART = os.path.expanduser("~/.config/qtile/scripts/qtile-autostart.sh")
KLOCK = "killall -q xautolock"
CHECK = " --hold checkupdates"
UPDT = " sudo pacman -Syu"
TREE = " ncdu -x /"
DISK = " --hold df -h"
PROC = " htop"
CAL = " --hold cal -Y"
NET = " nmcli connection show"
LOG = " bat " + os.path.expanduser("~/.local/share/qtile/qtile.log")
_DISCORD = "~/Discord/Discord"
CHAT = os.path.expanduser(_DISCORD)
MIXER = " alsamixer"
MACHO = ' ' + os.path.expanduser("~/scripts/macho.sh")
WTLDR = " --hold bash " + os.path.expanduser("~/scripts/wtldr.sh")
KB = ' ' + os.path.expanduser("~/.config/qtile/scripts/qtile-kb.sh")
SOUNDSMALL = 1
SOUNDLARGE = 5
SOUNDUP = "amixer -q sset Master {}%+"
SOUNDDOWN = "amixer -q sset Master {}%-"
MUTE = "amixer -q sset Master toggle"
BLUETOGG = "bluetooth.toggle.sh -t"


def _cmd(command):
    """
        TODO
    """
    return lazy.spawn(command)


def _ucmd(command):
    """
        TODO
    """
    return lazy.spawn(command), lazy.ungrab_chord()


def _rofi(modi):
    """
        TODO
    """
    return _ucmd("rofi -show " + modi)


def _emacs(eval=None):
    """
        TODO
    """
    return _ucmd(EMACS if eval is None else f"{EMACS} --eval '({eval})'")


def _script(script, terminal=None, path=SCRIPTS):
    """
        TODO
    """
    script = os.path.expanduser(os.path.join('~', path, script))
    if terminal is not None:
        script = terminal + ' ' + script
    return _cmd(script)


def init_keymap(mod, terminal):
    """
        A list of available commands that can be bound to keys can be found
        at https://docs.qtile.org/en/latest/manual/config/lazy.html
    """
    km = []

    MOD = [mod]
    km.extend(
        [
            Key(MOD, 'h', lazy.layout.left(),                 desc="Move focus to left"),
            Key(MOD, 'j', lazy.layout.down(),                 desc="Move focus down"),
            Key(MOD, 'k', lazy.layout.up(),                   desc="Move focus up"),
            Key(MOD, 'l', lazy.layout.right(),                desc="Move focus to right"),
            Key(MOD, 'u', lazy.to_screen(0),                  desc="Keyboard focus to monitor 1"),
            Key(MOD, 'i', lazy.to_screen(1),                  desc="Keyboard focus to monitor 2"),
            Key(MOD, 'o', lazy.to_screen(2),                  desc="Keyboard focus to monitor 3"),
            KeyChord(MOD, 'b', [
                Key([], 'c', *_ucmd("chromium"),              desc="TODO"),
                Key([], 'f', *_ucmd("firefox"),               desc="TODO"),
                Key([], 's', *_ucmd(SURF),                    desc="TODO"),
                ],
                mode=" BROWSER"
            ),
            Key(MOD, 'c', _cmd(CHAT),                         desc="TODO"),
            Key(MOD, 'd', _cmd(DMRUN),                        desc="TODO"),
            KeyChord(MOD, 'e', [
                Key([], 'a', *_emacs("org-agenda"),           desc="TODO"),
                Key([], 'b', *_emacs("ibuffer"),              desc="Launch ibuffer inside Emacs"),
                Key([], 'd', *_emacs("dired nil"),            desc="Launch dired inside Emacs"),
                Key([], 'e', *_emacs(),                       desc="Launch Emacs"),
                Key([], 'f', *_emacs("elfeed"),               desc="Launch elfeed inside Emacs"),
                Key([], 'i', *_emacs("erc"),                  desc="Launch erc inside Emacs"),
                Key([], 'm', *_emacs("mu4e"),                 desc="Launch mu4e inside Emacs"),
                Key([], 'n', *_ucmd(terminal + NVIM),         desc="TODO"),
                Key([], 's', *_emacs("eshell"),               desc="Launch the eshell inside Emacs"),
                Key([], 'v', *_emacs("+vterm/here nil"),      desc="Launch vterm inside Emacs"),
                ],
                mode=" EDITOR"
            ),
            Key(MOD, 'f', lazy.window.toggle_fullscreen(),    desc="toggle fullscreen"),
            KeyChord(MOD, 'm', [
                Key([], 'p', *_ucmd("mocp -G"),               desc="TODO"),
                Key([], 'n', *_ucmd("mocp -f"),               desc="TODO"),
                Key([], 'b', *_ucmd("mocp -r"),               desc="TODO"),
                Key([], 'q', *_ucmd("mocp -x"),               desc="TODO"),
                Key([], 'u', *_ucmd("mocp -S"),               desc="TODO"),
                Key([], 'o', *_ucmd(terminal + " mocp"),      desc="TODO"),
                Key([], 's', *_ucmd("mocp -t shuffle"),       desc="TODO"),
                Key([], 'r', *_ucmd("mocp -t repeat"),        desc="TODO"),
                ],
                mode=" MUSIC"
            ),
            KeyChord(MOD, 'p', [
                Key([], 'c', *_ucmd(terminal + MACHO),        desc="TODO"),
                Key([], 'e', *_ucmd("dm-confedit"),           desc="Choose a config file to edit"),
                Key([], 'i', *_ucmd("dm-maim"),               desc="Take screenshots via dmenu"),
                Key([], 'h', *_ucmd("dm-hub"),                desc="TODO"),
                Key([], 'k', *_ucmd("dm-kill"),               desc="Kill processes via dmenu"),
                Key([], 'l', *_ucmd("dm-logout"),             desc="A logout menu"),
                Key([], 'm', *_ucmd("dm-man"),                desc="Search manpages in dmenu"),
                Key([], 'o', *_ucmd("dm-bookman"),            desc="Search your qutebrowser bookmarks and quickmarks"),
                Key([], 'p', *_ucmd(PASS),                    desc="Retrieve passwords with dmenu"),
                Key([], 'r', *_ucmd("dm-reddit"),             desc="Search reddit via dmenu"),
                Key([], 's', *_ucmd("dm-websearch"),          desc="Search various search engines via dmenu"),
                Key([], 't', *_ucmd(terminal + WTLDR),        desc="TODO"),
                ],
                mode=" PROMPT"
            ),
            KeyChord(MOD, 'q', [
                Key([], 'k', *_ucmd(terminal + KB),           desc="TODO"),
                Key([], 'l', *_ucmd(terminal + LOG),          desc="TODO"),
                Key([], 'r', *_ucmd(RESTART),                 desc="TODO"),
                Key([], 't', _script(
                    script="qtile-change-theme.sh",
                    terminal=terminal + " --hold",
                    path=".config/qtile/scripts"),
                    lazy.ungrab_chord(),                      desc="TODO"),
                Key([], 'x', *_ucmd(KLOCK),                   desc="TODO"),
                ],
                mode="  QTILE"
            ),
            KeyChord(MOD, 'r', [
                Key([], 'c', *_rofi(modi="combi"),            desc="TODO"),
                Key([], 'd', *_rofi(modi="drun"),             desc="TODO"),
                Key([], 'f', *_rofi(modi="filebrowser"),      desc="TODO"),
                Key([], 'k', *_rofi(modi="keys"),             desc="TODO"),
                Key([], 'r', *_rofi(modi="run"),              desc="TODO"),
                Key([], 's', *_rofi(modi="ssh"),              desc="TODO"),
                Key([], 'w', *_rofi(modi="window"),           desc="TODO"),
                ],
                mode=" ROFI"
            ),
            KeyChord(MOD, 's', [
                Key([], 'a', *_ucmd("alacritty"),             desc="TODO"),
                Key([], 'b', *_ucmd("blueman-manager"),       desc="TODO"),
                Key([], 'c', *_ucmd(terminal + CHECK),        desc="TODO"),
                Key([], 'd', *_ucmd(terminal + TREE),         desc="TODO"),
                Key([], 'f', *_ucmd(terminal + DISK),         desc="TODO"),
                Key([], 'h', *_ucmd(terminal + PROC),         desc="TODO"),
                Key([], 'k', *_ucmd("kitty"),                 desc="TODO"),
                Key([], 'm', *_ucmd(terminal + MIXER),        desc="TODO"),
                Key([], 'n', *_ucmd(terminal + NET),          desc="TODO"),
                Key([], 't', *_ucmd(terminal),                desc="TODO"),
                Key([], 'u', *_ucmd(terminal + UPDT),         desc="TODO"),
                Key([], 'y', *_ucmd(terminal + CAL),          desc="TODO"),
                ],
                mode=" SYSTEM"
            ),
            Key(MOD, 't', lazy.spawncmd(),                    desc="TODO"),
            Key(MOD, 'w', lazy.run_extension(window_list()),  desc="TODO"),
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
            Key(MOD, SPC, lazy.layout.next(),                  desc="Move window focus to other window"),
            Key(MOD, RET, _cmd(terminal),                      desc="Launch terminal"),
            Key(MOD, TAB, lazy.next_layout(),                  desc="Toggle between layouts"),
            Key(MOD, PER, lazy.next_screen(),                  desc="Move focus to next monitor"),
            Key(MOD, COM, lazy.prev_screen(),                  desc="Move focus to prev monitor"),
            Key(MOD, BCL, lazy.screen.prev_group(),            desc="TODO"),
            Key(MOD, BCR, lazy.screen.next_group(),            desc="TODO"),
            Key(MOD, SLH, lazy.screen.toggle_group(),          desc="TODO"),
            Key(MOD, F1,  _cmd("brightnessctl s 8-"),          desc="brightness of the main screen down."),
            Key(MOD, F2,  _cmd("brightnessctl s 8+"),          desc="brightness of the main screen up."),
            Key(MOD, F5,  _script("screenshot.sh window"),     desc="take a screenshot of everything or chose a window."),
            Key(MOD, F6,  _script("screenshot.sh full"),       desc="take a screenshot of everything or chose a window."),
            Key(MOD, F7,  _cmd(SOUNDDOWN.format(SOUNDLARGE)),  desc="TODO"),
            Key(MOD, F8,  _cmd(MUTE),                          desc="TODO"),
            Key(MOD, F9,  _cmd(SOUNDUP.format(SOUNDLARGE)),    desc="TODO"),
            Key(MOD, F10, _script(BLUETOGG),                   desc="TODO"),

            Key(MOD, F11, _script("lfrun.sh", terminal),       desc="my file explorer."),
            Key(MOD, F12, _script("slock-cst.sh"),             desc="lock the computer."),
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
                lazy.layout.flip().when(layout=["TALL", "WIDE"]),         desc="TODO, Toggle between split and unsplit sides of stack"),
            Key(MOD, F7,  _cmd(SOUNDDOWN.format(SOUNDSMALL)),             desc="TODO"),
            Key(MOD, F9,  _cmd(SOUNDUP.format(SOUNDSMALL)),               desc="TODO"),
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
            Key(MOD, "f", lazy.window.toggle_floating(),                          desc="toggle floating"),
            Key(MOD, "r", lazy.restart(),                                         desc="Restarting Qtile"),
            Key(MOD, TAB, lazy.prev_layout(),                                     desc="Toggle between layouts"),
            Key(MOD, F1,  _script("hdmi.brightness.sh -"),                        desc="brightness of the second screen down."),
            Key(MOD, F2,  _script("hdmi.brightness.sh +"),                        desc="brightness of the second screen up."),
        ]
    )
    return km
