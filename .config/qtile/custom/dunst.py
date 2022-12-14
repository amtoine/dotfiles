#!/usr/bin/env python3
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

import subprocess
from libqtile import widget


class Dunst(widget.base.ThreadPoolText):
    """
        A simple widget to display the state of the dunst notification server.

        Widget requirements: dunstctl from the dunst package
    """
    defaults = [
        ("update_interval", 1.0, "Update interval for the Dunst widget"),
        (
            "format", "DUNST {state} ({count})", "Dunst display format",
        ),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(Dunst.defaults)

    def poll(self):
        variables = dict()

        state = subprocess.check_output(["dunstctl", "is-paused"]).decode("utf-8").strip()
        count = int(
            subprocess.check_output(
                ["dunstctl", "count", "waiting"]).decode("utf-8").strip())
        variables["state"] = "" if count > 0 else "" if state == "false" else ""
        variables["count"] = count

        return self.format.format(**variables)
