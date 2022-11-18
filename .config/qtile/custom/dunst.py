#!/usr/bin/env python3
# a header could go here

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
