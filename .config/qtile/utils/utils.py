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
from libqtile.lazy import lazy

from collections.abc import Sequence
from shutil import which
from libqtile.log_utils import logger

import gi
gi.require_version("Gdk", "3.0")
from gi.repository import Gdk


def fetch_monitors() -> list:
    """
        Returns the list of connected monitors,
        containing their geometries.
        Greatly inspired from
        https://askubuntu.com/questions/639495/how-can-i-list-connected-monitors-with-xrandr
    """
    allmonitors = []

    gdkdsp = Gdk.Display.get_default()
    for i in range(gdkdsp.get_n_monitors()):
        monitor = gdkdsp.get_monitor(i)
        scale = monitor.get_scale_factor()
        geo = monitor.get_geometry()
        allmonitors.append([
            monitor.get_model()] + [n * scale for n in [
                geo.x, geo.y, geo.width, geo.height
            ]
        ])

    return allmonitors




def window_to_previous_screen(qtile,
                              switch_group: bool = False,
                              switch_screen: bool = False
                              ) -> None:
    """
        Sends current window to the previous screen.
        Computes the corresponding group and sends the
        window
    """
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile,
                          switch_group: bool = False,
                          switch_screen: bool = False
                          ) -> None:
    """
        Sends current window to the next screen.
        Computes the corresponding group and sends the
        window
    """
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i + 1)


@lazy.function
def float_to_front(qtile):
    """
        Make all floating windows to float lazily
        to the front on a key stroke.
    """
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()


@lazy.function
def toggle_minimize_all(qtile):
    """Toggle the windows of current group."""
    for group in qtile.groups:
        for window in group.windows:
            window.toggle_minimize()


@lazy.function
def toggle_minimize_current_group(qtile):
    """Toggle all the windows."""
    for window in qtile.current_group.windows:
        window.toggle_minimize()


# system shortcuts
HOME = os.path.expanduser("~")
SCRIPTS = ".local/bin"
QSCRIPTS = ".config/qtile/scripts"


def expand_terminal(terminal: str, fs: int = None, hold: bool = True) -> str:
    """
        Adds appropriate flags to a terminal
        name to allow the execution of commands inside
        the terminal.
        `fs` is an optional font size for st's `-z` switch.
        `hold` is an optional argument for kitty to "--hold".
    """
    if terminal == "kitty":
        flags = ["--hold"] if hold else []
    elif terminal == "st":
        flags = [f"-z {fs}"] if fs is not None else []
        flags += ["-e"]
    elif terminal == "alacritty":
        flags = ["-e"]
    else:
        flags = [""]
    term = ' '.join([terminal, *flags])
    return term


def _cmd(command: str, terminal: str = None, hold: bool = True):
    """
        Runs a command.
        Possibly inside a terminal.
    """
    # add the terminal when the command needs one.
    if terminal is not None:
        command = ' '.join([expand_terminal(terminal, hold=hold), command])
    return lazy.spawn(command, shell=True)


def _ucmd(command: str, terminal: str = None, hold: bool = True):
    """
        Runs a command and ungrabs the current chord.
        Possibly inside a terminal.
        To be used inside a 1-depth chord or at depth one of a
        multi-depth chord.
        Needs to be written as *_cmd("...") inside a Key call.
    """
    return _cmd(command, terminal, hold=hold), lazy.ungrab_chord()


def _uacmd(command: str, terminal: str = None, hold: bool = True):
    """
        Runs a command and ungrabs all the current chords.
        Possibly inside a terminal.
        To be used a multi-depth chord.
        Needs to be written as *_cmd("...") inside a Key call.
    """
    return _cmd(command, terminal, hold=hold), lazy.ungrab_all_chords()


def _rofi(modi: str, ungrab: bool = True):
    """
        Opens `rofi` using a given modi.

        Ungrab by default.
        Needs to be written as *_rofi("...") inside a Key call
        if ungrab is True.
    """
    command = "rofi -show " + modi
    return _ucmd(command) if ungrab else _cmd(command)


def _emacs(eval: str = None, ungrab: bool = True):
    """
        Opens `emacs` using a given optional evaluation.
        First run `emacs --daemon` either during autostart or
        from a background process.

        Ungrab by default.
        Needs to be written as *_emacs("...") inside a Key call
        if ungrab is True.
    """
    command = "emacsclient -c -a 'emacs'"
    if eval is not None:
        command += f" --eval '({eval})'"
    return _ucmd(command) if ungrab else _cmd(command)


def _script(script: str, terminal: str = None, path: str = SCRIPTS):
    """
        Runs a script,
        possibly inside a terminal
        and from a given directory.
    """
    # expanduser to have '/home/user/path/to/script'
    script = os.path.join(HOME, path, script)
    return _cmd(script, terminal)


def _uscript(script: str, terminal: str = None, path: str = SCRIPTS):
    """
        Runs a script,
        possibly inside a terminal
        and from a given directory.

        Ungrabs one layer of chords.
    """
    return _script(script, terminal=terminal, path=path), lazy.ungrab_chord()


def _uascript(script: str, terminal: str = None, path: str = SCRIPTS):
    """
        Runs a script,
        possibly inside a terminal
        and from a given directory.

        Ungrabs all layers of a chord.
    """
    script_ = _script(script, terminal=terminal, path=path)
    return script_, lazy.ungrab_all_chords()


def _scratch(scratchpad: str, dropdown: str):
    """
        Opens a dropdown
        inside a scratchpad.
    """
    return lazy.group[scratchpad].dropdown_toggle(dropdown)


def guess_shell(preference=None):
    """
        Try to guess shell.
    """
    test_shells = []
    if isinstance(preference, str):
        test_shells += [preference]
    elif isinstance(preference, Sequence):
        test_shells += list(preference)
    test_shells += [
        "bash",
        "fish",
        "zsh",
    ]

    for shell in test_shells:
        logger.debug("Guessing shell: {}".format(shell))
        if not which(shell, os.X_OK):
            continue

        logger.info("Shell found: {}".format(shell))
        return shell

    logger.error("Default shell has not been found.")
