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

from libqtile import hook
from libqtile import qtile
from libqtile import layout
from libqtile.config import Match
from libqtile.utils import guess_terminal

from groups import init_groups
import hooks
from keys import init_keymap
from layouts import init_layouts
from mouse import init_mouse
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
    "fish",
    "bash",
    "xonsh",
    "nu",
]
use_bar = True

terminal = guess_terminal(preference=terminal_preferences)
shell = guess_shell(preference=shell_preferences)

# initialize everything.
groups, _ = init_groups(terminal, shell)
keys = init_keymap(mod, terminal, shell, groups)
layouts = init_layouts()
widget_defaults = init_widget_defaults()
extension_defaults = widget_defaults.copy()
fake_screens = init_screens(terminal, use_bar=use_bar)

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

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
