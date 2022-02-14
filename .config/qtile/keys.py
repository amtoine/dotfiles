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
from style import BAR_GEOMETRY
from style import DMFONT

SCRIPTS = "scripts"
SPC = "space"
ESC = "Escape"
SHI = "shift"
CON = "control"
ALT = "mod1"
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

HOME = os.path.expanduser("~")
DMRUN = f"dmenu_run -h {BAR_GEOMETRY['size']} -p 'Run: ' -fn '{DMFONT}'"
PASS = f"passmenu -l 10 -c -fn '{DMFONT}'"
PASSEDIT = "passedit.sh"
NVIM = " nvim"
SURF = "tabbed -c surf -N -e"
EMACS = "emacsclient -c -a 'emacs'"
AUTOSTART = os.path.expanduser("~/.config/qtile/scripts/qtile-autostart.sh")
KLOCK = "killall -q xautolock"
CHECK = " --hold checkupdates"
UPDT = " --hold sudo pacman -Syu"
TREE = " ncdu -x /"
DISK = " --hold df -h"
PROC = " htop"
CAL = " --hold cal -Y"
NET = " nmcli connection show"
LOG = " bat " + os.path.expanduser("~/.local/share/qtile/qtile.log")
DISCORD = os.path.expanduser("~/Discord/Discord")
SLACK = "slack"
CAPRINE = "caprine"
SIGNAL = "signal-desktop"
THUNDERBIRD = "thunderbird"
MIXER = " alsamixer"
MACHO = ' ' + os.path.expanduser("~/scripts/macho.sh")
WTLDR = " --hold bash " + os.path.expanduser("~/scripts/wtldr.sh")
KB = ' ' + os.path.expanduser("~/.config/qtile/scripts/qtile-kb.sh")
SOUNDS = 1
SOUNDL = 5
SOUNDUP = "amixer -q sset Master {}%+"
SOUNDDOWN = "amixer -q sset Master {}%-"
MUTE = "amixer -q sset Master toggle"
BLUETOGG = "bluetooth.toggle.sh -t"
WALLPAPER = "wallpaper.fzf.sh"
BAR = dict(script="qtile-bar.sh", path=".config/qtile/scripts")
URELOAD = lazy.reload_config(), lazy.ungrab_chord()
URESTART = lazy.restart(), lazy.ungrab_chord()
USHUTDOWN = lazy.shutdown(), lazy.ungrab_chord()
_CONKY = os.path.expanduser('~/.config/qtile/conky/beginner.conkyrc')
CONKY = f"conky --config={_CONKY}"
_HELP = os.path.expanduser('~/.config/qtile/conky/help.conkyrc')
HELP = f"conky --config={_HELP}"
_CLOCK = os.path.expanduser('~/.config/conky/vision/Z333-vision.conkyrc')
CLOCK = f"conky --config {_CLOCK}"
PYTHON = " python"
LGIT = f" lazygit --git-dir={HOME}/.dotfiles --work-tree={HOME}"
TIGA = "config.tiga.sh"
BTOP = " btop --utf-force"
HTOP = " htop"


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


def _uacmd(command):
    """
        TODO
    """
    return lazy.spawn(command), lazy.ungrab_all_chords()


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


def _uscript(script, terminal=None, path=SCRIPTS):
    """
        TODO
    """
    return _script(script, terminal=terminal, path=path), lazy.ungrab_chord()


def _uascript(script, terminal=None, path=SCRIPTS):
    """
        TODO
    """
    script_ = _script(script, terminal=terminal, path=path)
    return script_, lazy.ungrab_all_chords()


def init_keymap(mod, terminal):
    """
        A list of available commands that can be bound to keys can be found
        at https://docs.qtile.org/en/latest/manual/config/lazy.html
    """
    THEME = dict(
        script="qtile-change-theme.sh",
        terminal=terminal + " --hold",
        path=".config/qtile/scripts",
    )

    km = []

    MOD = [mod]
    km.extend(
        [
            # reserved keys for movement.
            Key(MOD, 'h', lazy.layout.left(),                 desc="Move focus to left"),
            Key(MOD, 'j', lazy.layout.down(),                 desc="Move focus down"),
            Key(MOD, 'k', lazy.layout.up(),                   desc="Move focus up"),
            Key(MOD, 'l', lazy.layout.right(),                desc="Move focus to right"),
            KeyChord(MOD, 'b', [
                Key([], 'c', *_ucmd("chromium"),              desc="TODO"),
                Key([], 'f', *_ucmd("firefox"),               desc="TODO"),
                Key([], 's', *_ucmd(SURF),                    desc="TODO"),
                ],
                mode=" BROWSER"
            ),
            KeyChord(MOD, 'c', [
                Key([], 'c', *_ucmd(CAPRINE),                 desc="TODO"),
                Key([], 'd', *_ucmd(DISCORD),                 desc="TODO"),
                Key([], 'g', *_ucmd(SIGNAL),                  desc="TODO"),
                Key([], 'm', *_ucmd(terminal + MACHO),        desc="TODO"),
                Key([], 's', *_ucmd(SLACK),                   desc="TODO"),
                Key([], 't', *_ucmd(THUNDERBIRD),             desc="TODO"),
                Key([], 'w', *_ucmd(terminal + WTLDR),        desc="TODO"),
                ],
                mode=" MISCELLANEOUS"
            ),
            KeyChord(MOD, 'd', [
                Key([], 'd', *_ucmd(DMRUN),                   desc="TODO"),
                Key([], 'e', *_ucmd("dm-confedit"),           desc="Choose a config file to edit"),
                Key([], 'i', *_ucmd("dm-maim"),               desc="Take screenshots via dmenu"),
                Key([], 'h', *_ucmd("dm-hub"),                desc="TODO"),
                Key([], 'k', *_ucmd("dm-kill"),               desc="Kill processes via dmenu"),
                Key([], 'l', *_ucmd("dm-logout"),             desc="A logout menu"),
                Key([], 'm', *_ucmd("dm-man"),                desc="Search manpages in dmenu"),
                Key([], 'n', *_ucmd("dm-note"),               desc="TODO"),
                Key([], 'o', *_ucmd("dm-bookman"),            desc="Search your qutebrowser bookmarks and quickmarks"),
                Key([], 'r', *_ucmd("dm-reddit"),             desc="Search reddit via dmenu"),
                Key([], 's', *_ucmd("dm-websearch"),          desc="Search various search engines via dmenu"),
                ],
                mode=" DMENU"
            ),
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
                Key([], 'b', *_ucmd("mocp -r"),               desc="TODO"),
                Key([], 'm', *_ucmd("mocp -G"),               desc="TODO"),
                Key([], 'n', *_ucmd("mocp -f"),               desc="TODO"),
                Key([], 'o', *_ucmd(terminal + " mocp"),      desc="TODO"),
                Key([], 'p', *_ucmd("mocp -G"),               desc="TODO"),
                Key([], 'q', *_ucmd("mocp -x"),               desc="TODO"),
                Key([], 'r', *_ucmd("mocp -t repeat"),        desc="TODO"),
                Key([], 's', *_ucmd("mocp -t shuffle"),       desc="TODO"),
                Key([], 'u', *_ucmd("mocp -S"),               desc="TODO"),
                Key([], 'h', _cmd("mocp -k -10"),             desc="TODO"),
                Key([], 'j', _cmd("mocp -f"),                 desc="TODO"),
                Key([], 'k', _cmd("mocp -r"),                 desc="TODO"),
                Key([], 'l', _cmd("mocp -k +10"),             desc="TODO"),
                Key([], SPC, _cmd("mocp -G"),                 desc="TODO"),
                Key([], F7,  _cmd(SOUNDDOWN.format(SOUNDL)),  desc="TODO"),
                Key([], F8,  _cmd(MUTE),                      desc="TODO"),
                Key([], F9,  _cmd(SOUNDUP.format(SOUNDL)),    desc="TODO"),
                ],
                mode=" MUSIC"
            ),
            KeyChord(MOD, 'p', [
                Key([], 'e', *_uscript(PASSEDIT, terminal),   desc="TODO"),
                Key([], 'p', *_ucmd(PASS),                    desc="Retrieve passwords with dmenu"),
                ],
                mode="ﳳ PASS"
            ),
            KeyChord(MOD, 'q', [
                Key([], 'a', *_ucmd(AUTOSTART),               desc="TODO"),
                Key([], 'b', *_uscript(**BAR),                desc="TODO"),
                Key([], "c", *URELOAD,                        desc="Reload the config"),
                KeyChord([], 'h', [
                    Key([], 'b', *_uacmd(CONKY),              desc="TODO"),
                    Key([], 'c', *_uacmd(CLOCK),              desc="TODO"),
                    Key([], 'h', *_uacmd(HELP),               desc="TODO"),
                    Key([], 'k', *_uacmd(terminal + KB),      desc="TODO"),
                    ],
                    mode=" HELP"
                ),
                Key([], 'l', *_ucmd(terminal + LOG),          desc="TODO"),
                Key([], "r", *URESTART,                       desc="Restarting Qtile"),
                Key([], "s", *USHUTDOWN,                      desc="Shutdown Qtile"),
                Key([], 't', *_uscript(**THEME),              desc="TODO"),
                Key([], 'w', *_uscript(WALLPAPER, terminal),  desc="TODO"),
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
                mode=" ROFI"
            ),
            KeyChord(MOD, 's', [
                Key([], 'b', *_ucmd("blueman-manager"),       desc="TODO"),
                KeyChord([], 'c', [
                    Key([], 'e', *_uacmd("dm-confedit"),      desc="Choose a config file to edit"),
                    Key([], 'l', *_uacmd(terminal + LGIT),    desc="TODO"),
                    Key([], 't', *_uascript(TIGA, terminal),  desc="TODO"),
                    ],
                    mode=" CONFIG"
                ),
                KeyChord([], 'd', [
                    Key([], 's', *_uacmd(terminal + TREE),    desc="TODO"),
                    Key([], 'u', *_uacmd(terminal + DISK),    desc="TODO"),
                    ],
                    mode=" DISK"
                ),
                Key([], 'f', *_uscript("lfrun.sh", terminal), desc="my file explorer."),
                KeyChord([], 'h', [
                    Key([], 'b', *_uacmd(terminal + BTOP),    desc="TODO"),
                    Key([], 'h', *_uacmd(terminal + HTOP),    desc="TODO"),
                    ],
                    mode=" MONITOR"
                ),
                Key([], 'm', *_ucmd(terminal + MIXER),        desc="TODO"),
                Key([], 'n', *_ucmd(terminal + NET),          desc="TODO"),
                KeyChord([], 't', [
                    Key([], 'a', *_uacmd("alacritty"),        desc="TODO"),
                    Key([], 'k', *_uacmd("kitty"),            desc="TODO"),
                    Key([], 'p', *_uacmd(terminal + PYTHON),  desc="TODO"),
                    Key([], 't', *_uacmd(terminal),           desc="TODO"),
                    ],
                    mode=" TERMINAL"
                ),
                KeyChord([], 'u', [
                    Key([], 'c', *_uacmd(terminal + CHECK),   desc="TODO"),
                    Key([], 'u', *_uacmd(terminal + UPDT),    desc="TODO"),
                    ],
                    mode=" UPDATES"
                ),
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
            Key(MOD, SPC, lazy.layout.next(),              desc="Move window focus to other window"),
            Key(MOD, RET, _cmd(terminal),                  desc="Launch terminal"),

            Key(MOD, F1,  _cmd("brightnessctl s 8-"),      desc="brightness of the main screen down."),
            Key(MOD, F2,  _cmd("brightnessctl s 8+"),      desc="brightness of the main screen up."),
            Key(MOD, F5,  _script("screenshot.sh window"), desc="take a screenshot of everything or chose a window."),
            Key(MOD, F6,  _script("screenshot.sh full"),   desc="take a screenshot of everything or chose a window."),
            Key(MOD, F7,  _cmd(SOUNDDOWN.format(SOUNDL)),  desc="TODO"),
            Key(MOD, F8,  _cmd(MUTE),                      desc="TODO"),
            Key(MOD, F9,  _cmd(SOUNDUP.format(SOUNDL)),    desc="TODO"),
            Key(MOD, F10, _script(BLUETOGG),               desc="TODO"),
            Key(MOD, F12, _script("slock-cst.sh"),         desc="lock the computer."),
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
            Key(MOD, RET,
                lazy.layout.toggle_split().when(layout=["COLS", " BSP"]),
                lazy.layout.flip().when(layout=["TALL", "WIDE"]),         desc="TODO, Toggle between split and unsplit sides of stack"),
            Key(MOD, F7,  _cmd(SOUNDDOWN.format(SOUNDS)),                 desc="TODO"),
            Key(MOD, F9,  _cmd(SOUNDUP.format(SOUNDS)),                   desc="TODO"),
        ]
    )
    MOD = [mod, ALT]
    km.extend(
        [
            Key(MOD, "h", lazy.screen.prev_group(),      desc="TODO"),
            Key(MOD, "j", lazy.prev_screen(),            desc="Move focus to prev monitor"),
            Key(MOD, "k", lazy.next_screen(),            desc="Move focus to next monitor"),
            Key(MOD, "l", lazy.screen.next_group(),      desc="TODO"),
            Key(MOD, 'u', lazy.to_screen(0),             desc="Keyboard focus to monitor 1"),
            Key(MOD, 'i', lazy.to_screen(1),             desc="Keyboard focus to monitor 2"),
            Key(MOD, 'o', lazy.to_screen(2),             desc="Keyboard focus to monitor 3"),
            Key(MOD, "n", lazy.prev_layout(),            desc="Toggle between layouts"),
            Key(MOD, "m", lazy.next_layout(),            desc="Toggle between layouts"),
            Key(MOD, "f", lazy.window.toggle_floating(), desc="toggle floating"),
            Key(MOD, "t", lazy.screen.toggle_group(),    desc="TODO"),
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
            Key(MOD, F1,  _script("hdmi.brightness.sh -"),                        desc="brightness of the second screen down."),
            Key(MOD, F2,  _script("hdmi.brightness.sh +"),                        desc="brightness of the second screen up."),
        ]
    )
    return km
