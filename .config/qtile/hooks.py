import os
import subprocess

from libqtile import qtile
from libqtile import hook

from groups import init_groups
from popups import text_popup


@hook.subscribe.startup_once
def _autostart():
    """
        Runs when `qtile` starts.
        The script mainly loads wallpapers, starts daemons such as `emacs` or
        the `dunst` notification server, etc.
    """
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.run([home])


_, group_names = init_groups("", "")


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
    if hasattr(qtile, "current_screen"):
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
