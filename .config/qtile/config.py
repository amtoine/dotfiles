#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __               __ _
#          __    / /  __ _    / /  __ ___ _ _  / _(_)__ _   _ __ _  _
#      _  / _|  / /  / _` |  / /  / _/ _ \ ' \|  _| / _` |_| '_ \ || |
#     (_) \__| /_/   \__, | /_/   \__\___/_||_|_| |_\__, (_) .__/\_, |
#                       |_|                         |___/  |_|   |__/
#
# Description:  this is the script called by `qtile` when it starts.
# Dependencies: all `qtile` dependencies.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

import os
import subprocess

from libqtile import hook
from libqtile import layout
from libqtile.config import Match
from libqtile.utils import guess_terminal

from groups import init_groups
from keys import init_keymap
from layouts import init_layouts
from mouse import init_mouse
from screens import init_screens
from style import LAYOUTS as lt
from widgets import init_widget_defaults


mod = "mod4"  # the super (windows or mac) key controls `qtile`
preference = [
    "kitty",
    "st",
    "alacritty",
]
terminal = guess_terminal(preference=preference)

# initialize everything.
groups, group_names = init_groups()
keys = init_keymap(mod, terminal, groups)
layouts = init_layouts()
widget_defaults = init_widget_defaults()
extension_defaults = widget_defaults.copy()
fake_screens = init_screens(terminal)

# some mouse related stuff.
mouse = init_mouse(mod)
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False

# special floating config.
floating_layout = layout.Floating(
    # all the window listed below will always float.
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),    # gitk
        Match(wm_class='makebranch'),      # gitk
        Match(wm_class='maketag'),         # gitk
        Match(wm_class='ssh-askpass'),     # ssh-askpass
        Match(title='branchdialog'),       # gitk
        Match(title='pinentry'),           # GPG key password entry
        Match(wm_class='pinentry-gtk-2'),  # gtk
        Match(wm_class="conky"),           # conky
    ],
    border_focus=lt.floating.focus,    # Border colour(s) for the focused window.
    border_normal=lt.floating.normal,  # Border colour(s) for un-focused windows.
    border_width=lt.border_width,      # Border width.
    )
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def autostart():
    """
        Runs when `qtile` starts.
        The script mainly loads wallpapers, starts daemons such as `emacs` or
        the `dunst` notification server, etc.
    """
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.run([home])


@hook.subscribe.client_new
def func(client):
    """
        This function is ran everytime a window is created.
        The goal is, for instance, to send some windows to some dedicated
        group, but one could do anything inside this function.
    """
    # sends all instances of `mpv` to the `V7`, i.e. video, group,
    # to minimize conflicts with non floating windows.
    if "mpv" in client._wm_class:
        client.cmd_togroup(group_names[6])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
