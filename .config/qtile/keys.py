# *
# *                  _    __ _ _
# *   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
# *  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
# *  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
# *  |___/
# *          MAINTAINERS:
# *              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
# *              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
# *

import os

from libqtile.config import Key
from libqtile.config import KeyChord
from libqtile.config import ScratchPad
from libqtile.lazy import lazy

from extensions import window_list
from style import BAR_GEOMETRY
from style import DMFONT
from utils.utils import float_to_front
from utils.utils import toggle_minimize_all
from utils.utils import toggle_minimize_current_group
from utils.utils import window_to_next_screen
from utils.utils import window_to_previous_screen
from utils.utils import _cmd
from utils.utils import _ucmd
from utils.utils import _uacmd
from utils.utils import _rofi
from utils.utils import _emacs
from utils.utils import _script
from utils.utils import _uscript
from utils.utils import _uascript
from utils.utils import _scratch
from utils.utils import HOME
from utils.utils import QSCRIPTS
from popups import feh_popup

# some shortcuts for the `qtile` key codes.
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
XBD = "XF86MonBrightnessDown"
XBU = "XF86MonBrightnessUp"
XAL = "XF86AudioLowerVolume"
XAM = "XF86AudioMute"
XAR = "XF86AudioRaiseVolume"

# some shortcuts for lenghty commands
# wrapper around dmenu-related commands
DMRUN = f"dmenu_run -c -l 10 -bw 5 -h {BAR_GEOMETRY['size']} -p 'Run: ' -fn '{DMFONT}'"
DMPASS = f"passmenu -l 10 -bw 5 -c -fn '{DMFONT}'"
DMNET = f"networkmanager_dmenu -i -c -l 20 -bw 5 -fn '{DMFONT}'"
WALLPAPERS = "feh --bg-fill --randomize /usr/share/backgrounds/*"

# web browsers
SURF = "tabbed -c surf -N -e"
VIMB = "tabbed -c vimb -e"

# qtile related commands
AUTOSTART = dict(script="autostart.sh", path=QSCRIPTS)
LOG = "bat " + os.path.expanduser("~/.local/share/qtile/qtile.log")
KB = os.path.join(HOME, QSCRIPTS, "km.sh")
BAR = dict(script="bar.sh", path=QSCRIPTS)
URELOAD = lazy.reload_config(), lazy.ungrab_chord()
URESTART = lazy.restart(), lazy.ungrab_chord()
USHUTDOWN = lazy.shutdown(), lazy.ungrab_chord()
_CONKY = os.path.expanduser('~/.config/conky/qtile.conkyrc')
CONKY = f"conky --config={_CONKY}"
_CLOCK = os.path.expanduser('~/.config/conky/vision/Z333-vision.conkyrc')
CLOCK = f"conky --config {_CLOCK}"

# sound management
SOUNDS = 1
SOUNDL = 5
SOUNDUP = "sound.sh --up --channel Master --step {} --notify"
SOUNDDOWN = "sound.sh --down --channel Master --step {} --notify"
MUTE = "sound.sh --toggle --channel Master --notify"
BLUETOGG = "sound.sh --bluetooth --notify"

# miscellaneous
LCFG = f"lazygit --git-dir={HOME}/.dotfiles --work-tree={HOME}"
TIGA = "tcfg.sh"
EMACS_RESTART = "killall emacs && /usr/bin/emacs --daemon && dunstify 'Emacs' 'server restart successful'"


def init_keymap(mod, terminal, shell, groups):
    """
        A list of available commands that can be bound to keys can be found
        at https://docs.qtile.org/en/latest/manual/config/lazy.html

        This is the main function here, that initializes every key in the
        keymap.
    """
    km = []

    # first of all, enable movement between groups (mod + 1-7)
    # allow to move windows to other groups, with following (mod + ctrl + 1-7)
    # or without following (mod + shift + 1-7).
    for i, group in enumerate(groups):
        if not isinstance(group, ScratchPad):
            km.extend([
                Key([mod],      str(i+1), lazy.group[group.name].toscreen(),                   desc="Switch to group {}".format(group.name)),
                Key([mod, SHI], str(i+1), lazy.window.togroup(group.name, switch_group=False), desc="Move focused window to group {}".format(group.name)),
                Key([mod, CON], str(i+1), lazy.window.togroup(group.name, switch_group=True),  desc="Switch to & move focused window to group {}".format(group.name)),
            ])

    # commands of the form "key"
    MOD = []
    km.extend(
        [
            Key(MOD, XBD, _cmd("hdmi.sh -M -b 20- -n"),       desc="Brightness of the main screen down"),
            Key(MOD, XBU, _cmd("hdmi.sh -M -b 20+ -n"),       desc="Brightness of the main screen up"),
            Key(MOD, XAL, _script(SOUNDDOWN.format(SOUNDL)),  desc="Decrease the sound by 'SOUNDL' (defaults to 5)"),
            Key(MOD, XAM, _script(MUTE),                      desc="Toggle the sound on and off for the selected channel"),
            Key(MOD, XAR, _script(SOUNDUP.format(SOUNDL)),    desc="Increase the sound by 'SOUNDL' (defaults to 5)"),
        ]
    )

    # commands of the form "control + key"
    MOD = [CON]
    km.extend(
        [
            Key(MOD, XAL, _script(SOUNDDOWN.format(SOUNDS)),  desc="Decrease the sound by 'SOUNDS' (defaults to 1)"),
            Key(MOD, XAR, _script(SOUNDUP.format(SOUNDS)),    desc="Increase the sound by 'SOUNDS' (defaults to 1)"),
        ]
    )

    # commands of the form "shift + key"
    MOD = [SHI]
    km.extend(
        [
            Key(MOD, XBD, _script("hdmi.sh -S -b - -n"),      desc="Brightness of the second screen down"),
            Key(MOD, XBU, _script("hdmi.sh -S -b + -n"),      desc="Brightness of the second screen up"),
        ]
    )

    # commands of the form "mod + key"
    MOD = [mod]
    km.extend(
        [
            # reserved keys for movement.
            Key(MOD, 'h', lazy.layout.left(),                 desc="Move focus to left"),
            Key(MOD, 'j', lazy.layout.down(),                 desc="Move focus down"),
            Key(MOD, 'k', lazy.layout.up(),                   desc="Move focus up"),
            Key(MOD, 'l', lazy.layout.right(),                desc="Move focus to right"),

            KeyChord(MOD, 'b', [
                Key([], 'c', *_ucmd("chromium"),              desc="Launch chromium"),
                Key([], 'f', *_ucmd("firefox"),               desc="Launch firefox"),
                Key([], 'n', *_ucmd("nyxt"),                  desc="Launch nyxt"),
                Key([], 'q', *_ucmd("qutebrowser"),           desc="Launch qutebrowser"),
                Key([], 's', *_ucmd(SURF),                    desc="Launch surf"),
                Key([], 'v', *_ucmd(VIMB),                    desc="Launch vimb"),
                ],
                mode=" BROWSER"
            ),
            KeyChord(MOD, 'c', [
                Key([], 'a', *_ucmd("ani-cli -q 480", terminal),  desc="Open the ani-cli service to play anime in the terminal."),
                Key([], 'b', *_ucmd("rofi-bluetooth"),     desc="Manage bluetooth connections with rofi"),
                Key([], 'e', *_ucmd(DMNET),                desc="Manage network connections with dmenu"),
                KeyChord([], 'c', [
                    Key([], 'a', *list(map(lazy.spawn, [
                            "caprine",
                            "discord",
                            "gmail-desktop",
                            "signal-desktop",
                            "slack",
                            "thunderbird"
                        ])), lazy.ungrab_all_chords(),       desc="Open all chat clients"),
                    Key([], 'c', *_uacmd("caprine"),         desc="Open messenger"),
                    Key([], 'd', *_uacmd("discord"),         desc="Open discord"),
                    Key([], 'g', *_uacmd("gmail-desktop"),   desc="Open gmail"),
                    Key([], 'i', *_uacmd("signal-desktop"),  desc="Open signal"),
                    Key([], 'k', *_uacmd("slack"),           desc="Open slack"),
                    Key([], 't', *_uacmd("thunderbird"),     desc="Open thunderbird"),
                    ],
                    mode=" CHAT"
                ),
                Key([], 'm', *_uscript("macho.sh", terminal),   desc="Use the macho wrapper around man"),
                Key([], 'p', *_uscript("pdf.sh"),               desc="Open pdfs in okular."),
                KeyChord([], 'n', [
                    Key([], 'c', *_uacmd("dunstctl close-all"),         desc="Close all notifications on the screen"),
                    Key([], 'h', *_uacmd("dunstctl history-pop"),       desc="Pop a notification from history"),
                    Key([], 'p', *_uacmd("dunstctl set-paused toggle"), desc="Toggle the notifications"),
                    ],
                    mode=" NOTIFICATIONS"
                ),
                KeyChord([], 'r', [
                    Key([], 'e', *_uacmd(EMACS_RESTART),             desc="Force emacs to restart"),
                    Key([], 'q', *URESTART,                          desc="Restart qtile"),
                    Key([], 'w', _cmd(WALLPAPERS),                   desc="Reload random wallpapers"),
                    Key([SHI], 'w', lazy.function(feh_popup),        desc="Show current wallpapers"),
                    ],
                    mode=" RELOAD"
                ),
                Key([], 'w', *_uscript("wtldr.sh", terminal), desc="Use the wtldr wrapper around tldr"),
                Key([], 'z', *_ucmd("zotero"),                desc="Manage papers and pdf documents with zotero"),
                ],
                mode=" MISCELLANEOUS"
            ),
            KeyChord(MOD, 'd', [
                Key([], 'd', *_ucmd(DMRUN),                          desc="Open dmenu_run to run applications"),
                Key([], 'b', *_ucmd(f"dm-setbg -fn '{DMFONT}'"),     desc="Set the background wallpaper with dmenu"),
                Key([], 'e', *_ucmd(f"dm-confedit -fn '{DMFONT}'"),  desc="Choose a config file to edit with dmenu"),
                Key([], 'i', *_ucmd(f"dm-maim -fn '{DMFONT}'"),      desc="Take screenshots via dmenu"),
                Key([], 'h', *_ucmd(f"dm-hub -fn '{DMFONT}'"),       desc="Open the dm-scripts hub"),
                Key([], 'k', *_ucmd(f"dm-kill -fn '{DMFONT}'"),      desc="Kill processes via dmenu"),
                Key([], 'l', *_ucmd(f"dm-logout -fn '{DMFONT}'"),    desc="A logout menu in dmenu"),
                Key([], 'm', *_ucmd(f"dm-man -fn '{DMFONT}'"),       desc="Search manpages in dmenu"),
                Key([], 'n', *_ucmd(f"dm-note -fn '{DMFONT}'"),      desc="Take and copy note with dmenu"),
                Key([], 'o', *_ucmd(f"dm-bookman -fn '{DMFONT}'"),   desc="Search your qutebrowser bookmarks and quickmarks"),
                Key([], 'r', *_ucmd(f"dm-reddit -fn '{DMFONT}'"),    desc="Search reddit via dmenu"),
                Key([], 's', *_ucmd(f"dm-websearch -fn '{DMFONT}'"), desc="Search various search engines via dmenu"),
                Key([], 'w', lazy.run_extension(window_list()),
                    lazy.ungrab_chord(),                             desc="List and choose windows with dmenu"),
                ],
                mode=" DMENU"
            ),
            KeyChord(MOD, 'e', [
                Key([], 'a', *_emacs("org-agenda"),           desc="Launch org-agenda inside Emacs"),
                Key([], 'b', *_emacs("ibuffer"),              desc="Launch ibuffer inside Emacs"),
                Key([], 'd', *_emacs("dired nil"),            desc="Launch dired inside Emacs"),
                Key([], 'e', *_emacs(),                       desc="Launch Emacs"),
                Key([], 'f', *_emacs("elfeed"),               desc="Launch elfeed inside Emacs"),
                Key([], 'i', *_emacs("erc"),                  desc="Launch erc inside Emacs"),
                Key([], 'm', *_emacs("mu4e"),                 desc="Launch mu4e inside Emacs"),
                Key([], 'n', *_ucmd("nvim", terminal),        desc="Launch neovim"),
                Key([], 's', *_emacs("eshell"),               desc="Launch the eshell inside Emacs"),
                Key([], 'v', *_emacs("+vterm/here nil"),      desc="Launch vterm inside Emacs"),
                ],
                mode=" EDITOR"
            ),
            Key(MOD, 'f', lazy.window.toggle_fullscreen(),    desc="Toggle fullscreen for current window"),
            KeyChord(MOD, 'm', [
                Key([], 'b', *_ucmd("mocp -r"),                 desc="Previous song"),
                Key([], 'm', *_ucmd("mocp -G"),                 desc="Toggle pause"),
                Key([], 'n', *_ucmd("mocp -f"),                 desc="Next song"),
                Key([], 'o', *_ucmd("mocp", terminal),          desc="Open moc in a window"),
                Key([], 'p', *_ucmd("mocp -G"),                 desc="Toggle pause"),
                Key([], 'q', *_ucmd("mocp -x"),                 desc="Stop the music"),
                Key([], 'r', *_ucmd("mocp -t repeat"),          desc="Toggle the 'repeat' option"),
                Key([], 's', *_ucmd("mocp -t shuffle"),         desc="Toggle the 'shuffle' option"),
                Key([], 'h', _cmd("mocp -k -10"),               desc="Go 10 sec backward in music"),
                Key([], 'j', _cmd("mocp -f"),                   desc="Next song"),
                Key([], 'k', _cmd("mocp -r"),                   desc="Previous song"),
                Key([], 'l', _cmd("mocp -k +10"),               desc="Go 10 sec forward in music"),
                Key([], SPC, _cmd("mocp -G"),                   desc="Toggle pause without ungrabing the music chord"),
                Key([], F7,  _script(SOUNDDOWN.format(SOUNDL)), desc="Decrease the sound by 'SOUNDL' (defaults to 5)"),
                Key([], F8,  _script(MUTE),                     desc="Toggle the sound on and off for the selected channel"),
                Key([], F9,  _script(SOUNDUP.format(SOUNDL)),   desc="Decrease the sound by 'SOUNDL' (defaults to 5)"),
                ],
                mode=" MUSIC"
            ),
            KeyChord(MOD, 'p', [
                Key([], 'e', *_uscript("pedit.sh"),           desc="Edit passwords and credentials"),
                Key([], 'p', *_ucmd(DMPASS),                  desc="Retrieve passwords with dmenu"),
                ],
                mode="ﳳ PASS"
            ),
            KeyChord(MOD, 'q', [
                Key([], 'a', *_uscript(**AUTOSTART),          desc="Run the ./scripts/qtile-autostart.sh script"),
                Key([], 'b', *_uscript(**BAR),                desc="Change the bar"),
                Key([], "c", *URELOAD,                        desc="Reload the config"),
                KeyChord([], 'h', [
                    Key([], 'c', *_uacmd(CLOCK),              desc="Show a clock with weather"),
                    Key([], 'h', *_uacmd(CONKY),              desc="Open the begin help conky"),
                    Key([], 'k', *_uacmd(KB),                 desc="Open a tool to explore the keymap"),
                    ],
                    mode=" HELP"
                ),
                Key([], 'l', *_ucmd(LOG, terminal),           desc="Open the log file inside a terminal"),
                Key([], 'q', *_ucmd("archlinux-logout"),      desc="Show some options for logout in a window."),
                Key([], "r", *URESTART,                       desc="Restart Qtile"),
                Key([], "s", *USHUTDOWN,                      desc="Shutdown Qtile"),
                Key([], 't', *_uscript("themes.sh -d", terminal),       desc="Change the theme"),
                Key([], 'w', *_uscript("wfzf.sh -d"),         desc="Change the wallpapers"),
                ],
                mode="  QTILE"
            ),
            KeyChord(MOD, 'r', [
                Key([], 'b', *_ucmd("rofi-bluetooth"),        desc="Manages bluetooth connections with rofi"),
                Key([], 'c', *_rofi(modi="combi"),            desc="Run rofi with combi"),
                Key([], 'd', *_rofi(modi="drun"),             desc="Run rofi with drun"),
                Key([], 'f', *_rofi(modi="filebrowser"),      desc="Run rofi with filebrowser"),
                Key([], 'k', *_rofi(modi="keys"),             desc="Run rofi with keys"),
                Key([], 'r', *_rofi(modi="run"),              desc="Run rofi"),
                Key([], 's', *_rofi(modi="ssh"),              desc="Run rofi with ssh"),
                Key([], 'w', *_rofi(modi="window"),           desc="Run rofi with window"),
                ],
                mode=" ROFI"
            ),
            KeyChord(MOD, 's', [
                Key([], 'b', *_ucmd("blueman-manager"),       desc="Open the blueman bluetooth manager"),
                KeyChord([], 'c', [
                    Key([], 'e', *_uacmd("dm-confedit"),      desc="Choose a config file to edit"),
                    Key([], 'l', *_uacmd(LCFG, terminal),     desc="Open lazygit to manage the dotfiles bare repo"),
                    Key([], 't', *_uascript(TIGA, terminal),  desc="Open tig to manage the dotfiles bare repo"),
                    ],
                    mode=" CONFIG"
                ),
                KeyChord([], 'd', [
                    Key([], 's', *_uacmd("ncdu -x /", terminal), desc="Scans the whole '/' partition with ncdu"),
                    Key([], 'u', *_uacmd("df -h", terminal),     desc="Show partition usage with df"),
                    ],
                    mode=" DISK"
                ),
                Key([], 'f', *_uscript("lfrun.sh", terminal), desc="Open the file explorer in a new window"),
                KeyChord([], 'h', [
                    Key([], 'b', *_uacmd("btop --utf-force", terminal), desc="Open btop in new window"),
                    Key([], 'h', *_uacmd("htop", terminal),             desc="Open htop in new window"),
                    ],
                    mode=" MONITOR"
                ),
                Key([], 'm', *_ucmd("alsamixer", terminal),   desc="Open alsamixer in new window"),
                Key([], 'n', *_ucmd("nmcli c s", terminal),   desc="Show the connected network with nmcli"),
                KeyChord([], 'p', [
                    Key([], 'b', *_uascript("pcm.sh -bn"),    desc="Toggle picom on/off"),
                    Key([], 't', *_uascript("pcm.sh -tn"),    desc="Toggle the blur effect"),
                    ],
                    mode=" PICOM"
                ),
                KeyChord([], 't', [
                    Key([], 'a', *_uacmd(shell, "alacritty"),    desc="Open alacritty in new window"),
                    Key([], 'k', *_uacmd(shell, "kitty", False), desc="Open kitty in new window"),
                    Key([], 'p', *_uacmd("python", terminal),    desc="Open a python interpreter in new window"),
                    Key([], 's', *_uacmd(shell, "st"),           desc="Open st in new window"),
                    Key([], 't', *_uacmd(terminal),              desc="Open the qtile terminal"),
                    ],
                    mode=" TERMINAL"
                ),
                KeyChord([], 'u', [
                    Key([], 'c', *_uacmd("checkupdates", terminal),     desc="Check pacman for new updates"),
                    Key([], 'u', *_uacmd("sudo pacman -Syu", terminal), desc="Updates the system"),
                    ],
                    mode=" UPDATES"
                ),
                Key([], 'y', *_ucmd("cal -Y", terminal),      desc="Open a calendar of current year"),
                KeyChord([], 'x', [
                    Key([], 'd', *_uascript("xal.sh -dn"),    desc="Disable the autolock"),
                    Key([], 'e', *_uascript("xal.sh -en"),    desc="Enable the autolock"),
                    ],
                    mode=" XAUTOLOCK"
                ),
                ],
                mode=" SYSTEM"
            ),
            Key(MOD, 't', lazy.spawncmd(),                    desc="The qtile command prompt"),
            KeyChord(MOD, 'z', [
                Key([], 'h',
                    lazy.layout.grow_left().when(layout=["COLS", " BSP"]),
                    lazy.layout.grow().when(layout="WIDE"),
                    lazy.layout.shrink_main().when(layout="TALL"),          desc="Resize towards left"),
                Key([], 'j',
                    lazy.layout.grow_down().when(layout=["COLS", " BSP"]),
                    lazy.layout.grow_main().when(layout="WIDE"),
                    lazy.layout.grow().when(layout="TALL"),                 desc="Resize towards bottom"),
                Key([], 'k',
                    lazy.layout.grow_up().when(layout=["COLS", " BSP"]),
                    lazy.layout.shrink_main().when(layout="WIDE"),
                    lazy.layout.shrink().when(layout="TALL"),               desc="Resize towards top"),
                Key([], 'l',
                    lazy.layout.grow_right().when(layout=["COLS", " BSP"]),
                    lazy.layout.shrink().when(layout="WIDE"),
                    lazy.layout.grow_main().when(layout="TALL"),            desc="Resize towards right"),
                Key([], 'n', lazy.layout.normalize(),                       desc="Normalize the windows of current group"),
                Key([], 'm', lazy.layout.maximize(),                        desc="Maximize the current window size"),
                Key([], 'r', lazy.layout.reset(),                           desc="Reset the sizes of current group"),
                Key([], 'z', lazy.ungrab_chord(),                           desc="Quickly exit resize chord"),
                Key([], RET, lazy.ungrab_chord(),                           desc="Quickly exit resize chord"),
                ],
                mode=" RESIZE"
            ),
            Key(MOD, SPC, lazy.layout.next(),                desc="Move window focus to other window"),
            Key(MOD, RET, _cmd(shell, terminal, False),      desc="Launch terminal"),

            Key(MOD, F1,  _cmd("flameshot gui"),             desc="Take a quick screenshot with flameshot"),
            Key(MOD, F2,  _script("flameshot-screen.sh"),    desc="Take a screenshot of a screen with flameshot"),
            Key(MOD, F3,  _script("scrot.sh window"),        desc="Take a screenshot of a window with scrot"),
            Key(MOD, F4,  _script("scrot.sh full"),          desc="Take a screenshot of everything with scrot"),
            Key(MOD, F10, _script(BLUETOGG),                 desc="Toggle a bluetooth device on and off"),
            Key(MOD, F12, _script("slock.sh"),               desc="Lock the computer"),
        ]
    )

    # commands of the form "mod + ctrl + key"
    MOD = [mod, CON]
    km.extend(
        [
            # controls the layout with "mod + ctrl + hl"
            Key(MOD, 'h',
                lazy.layout.increase_ratio().when(layout="RTIO"),
                lazy.layout.swap_column_left().when(layout=["COLS"]),     desc="Increase the ratio in 'ratio', swap left in 'columns'"),
            Key(MOD, 'l',
                lazy.layout.decrease_ratio().when(layout="RTIO"),
                lazy.layout.swap_column_right().when(layout=["COLS"]),    desc="Decrease the ratio in 'ratio', swap right in 'columns'"),
            Key(MOD, "m", toggle_minimize_current_group,                  desc="Toggle windows of current group"),
            Key(MOD, RET,
                lazy.layout.toggle_split().when(layout=["COLS", " BSP"]),
                lazy.layout.flip().when(layout=["TALL", "WIDE"]),         desc="Toggle between split and unsplit sides of stack"),
            Key(MOD, PER, lazy.function(window_to_next_screen,
                                        switch_screen=True),              desc="Send a window to the next screen, with following"),
            Key(MOD, COM, lazy.function(window_to_previous_screen,
                                        switch_screen=True),              desc="Send a window to the previous screen, with following"),
        ]
    )

    # commands of the form "mod + alt + key"
    # meant to control groups and windows.
    MOD = [mod, ALT]
    km.extend(
        [
            Key(MOD, "h", lazy.screen.prev_group(),      desc="Move to previous group in current screen"),
            Key(MOD, "j", lazy.prev_screen(),            desc="Move focus to previous monitor"),
            Key(MOD, "k", lazy.next_screen(),            desc="Move focus to next monitor"),
            Key(MOD, "l", lazy.screen.next_group(),      desc="Move to next group in current screen"),
            Key(MOD, 'u', lazy.to_screen(0),             desc="Keyboard focus to monitor 1"),
            Key(MOD, 'i', lazy.to_screen(1),             desc="Keyboard focus to monitor 2"),
            Key(MOD, 'o', lazy.to_screen(2),             desc="Keyboard focus to monitor 3"),
            Key(MOD, "n", lazy.prev_layout(),            desc="Toggle between layouts"),
            Key(MOD, "m", lazy.next_layout(),            desc="Toggle between layouts"),
            Key(MOD, "f", lazy.window.toggle_floating(), desc="Toggle floating mode for current window"),
            Key(MOD, "t", lazy.screen.toggle_group(),    desc="Go to previously seen group"),
            Key(MOD, F1,  _scratch("sp1", "term"),       desc="Open a terminal in first scratchpad"),
            Key(MOD, F2,  _scratch("sp1", "python"),     desc="Open a python shell in first scratchpad"),
            Key(MOD, F3,  _scratch("sp1", "cfg"),        desc="Open git manager on the dotfiles in first scratchpad"),
            Key(MOD, F4,  _scratch("sp1", "fm"),         desc="Open a file manager in first scratchpad"),
            Key(MOD, F6,  _scratch("sp1", "clock"),      desc="Open a clock in first scratchpad"),
            Key(MOD, F7,  _scratch("sp1", "disk"),       desc="Show the disk usage in first scratchpad"),
            Key(MOD, F8,  _scratch("sp1", "top"),        desc="Open the process monitor in first scratchpad"),
            Key(MOD, F9,  _scratch("sp1", "sound"),      desc="Open the sound manager of the system in first scratchpad"),
            Key(MOD, F10, _scratch("sp1", "music"),      desc="Open the music player in first scratchpad"),
            Key(MOD, F11, _scratch("sp1", "cava"),       desc="Open the cava sound visualizer in first scratchpad"),
        ]
    )

    # commands of the form "mod + shift + key"
    MOD = [mod, SHI]
    km.extend(
        [
            # moves windows inside a group with "mod + shift + hjkl"
            # behaviour adapts depending on the layout.
            Key(MOD, "h",
                lazy.layout.shuffle_left().when(layout=["COLS", " BSP"]),
                lazy.layout.shuffle_up().when(layout="WIDE"),
                lazy.layout.swap_left().when(layout="TALL"),                      desc="Move window left"),
            Key(MOD, "j",
                lazy.layout.shuffle_down().when(layout=["COLS", " BSP", "TALL"]),
                lazy.layout.swap_left().when(layout="WIDE"),                      desc="Move window down"),
            Key(MOD, "k",
                lazy.layout.shuffle_up().when(layout=["COLS", " BSP", "TALL"]),
                lazy.layout.swap_right().when(layout="WIDE"),                     desc="Move window up"),
            Key(MOD, "l",
                lazy.layout.shuffle_right().when(layout=["COLS", " BSP"]),
                lazy.layout.shuffle_down().when(layout="WIDE"),
                lazy.layout.swap_right().when(layout="TALL"),                     desc="Move window right"),
            Key(MOD, "c", lazy.window.kill(),                                     desc="Kill focused window"),
            Key(MOD, "f", float_to_front,                                         desc="Brings all floating windows to the front"),
            Key(MOD, "m", toggle_minimize_all,                                    desc="Toggle all windows"),
            Key(MOD, F1,  _cmd("flameshot launcher"),                             desc="Take a screenshot with flameshot"),
            Key(MOD, PER, lazy.function(window_to_next_screen),                   desc="Send a window to the next screen, without following"),
            Key(MOD, COM, lazy.function(window_to_previous_screen),               desc="Send a window to the previous screen, without following"),
        ]
    )
    return km
