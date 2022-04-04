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
from libqtile import qtile
from libqtile import layout
from libqtile.config import Match
from libqtile.utils import guess_terminal

from groups import init_groups
from keys import init_keymap
from layouts import init_layouts
from mouse import init_mouse
from popups import text_popup
from screens import init_screens
from style import LAYOUTS as lt
from widgets import init_widget_defaults
from utils.utils import guess_shell


mod = "mod4"  # the super (windows or mac) key controls `qtile`
terminal_preferences = [
    "st",
    "alacritty",
    "kitty",
]
shell_preferences = [
    "bash",
    "xonsh",
    "nu",
    "fish",
]
terminal = guess_terminal(preference=terminal_preferences)
shell = guess_shell(preference=shell_preferences)

# initialize everything.
groups, group_names = init_groups(terminal, shell)
keys = init_keymap(mod, terminal, shell, groups)
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
        Match(wm_class='confirmreset'),        # gitk
        Match(wm_class='makebranch'),          # gitk
        Match(wm_class='maketag'),             # gitk
        Match(wm_class='ssh-askpass'),         # ssh-askpass
        Match(title='branchdialog'),           # gitk
        Match(title='pinentry'),               # GPG key password entry
        Match(wm_class='pinentry-gtk-2'),      # gtk
        Match(wm_class="conky"),               # conky
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
def _autostart():
    """
        Runs when `qtile` starts.
        The script mainly loads wallpapers, starts daemons such as `emacs` or
        the `dunst` notification server, etc.
    """
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.run([home])


@hook.subscribe.client_new
def _client_new(client):
    """
        This function is ran everytime a window is created.
        The goal is, for instance, to send some windows to some dedicated
        group, but one could do anything inside this function.
    """
    _, cls = client._wm_class
    # sends all instances of `mpv` to the `V7`, i.e. video group,
    # to minimize conflicts with non floating windows.
    if cls in ["mpv"]:
        client.cmd_togroup(group_names[6])
    # send quickemu virtualmachines to the third terminal group.
    elif cls in ["qemu"]:
        client.cmd_togroup(group_names[2])
    elif cls in ["discord", "Caprine", "Slack", "Signal", "Thunderbird", "Gmail Desktop"]:
        client.cmd_togroup(group_names[4])
    elif cls in ["Steam"]:
        client.cmd_togroup(group_names[5])


@hook.subscribe.setgroup
def _setgroup():
    """
        Run code whenever the user changes group.
    """
    # show a popup in the middle of the scren
    # with the name of the new group
    text_popup(qtile, qtile.current_group.name, centered=True)


@hook.subscribe.layout_change
def _layout_change(layout, group):
    """
        Show the layout name in a popup when changing layout.
    """
    # put the popup relative to the top left corner of current screen.
    x = qtile.current_screen.x + 160
    y = qtile.current_screen.y + 90
    text_popup(qtile, layout.name, x=x, y=y, centered=False)
@hook.subscribe.screens_reconfigured
async def _screens_reconfigured():
    """
        Do something when the screen configuration changes.
    """
    # restart qtile to apply major changes.
    qtile.restart()


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
