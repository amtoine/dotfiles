#!/usr/bin/env python3
# a header could go here

import subprocess
from libqtile import widget


class Entropy(widget.base.ThreadPoolText):
    """
        A simple widget to display the entropy of the system.

        Widget requirements: subprocess
    """
    defaults = [
        ("update_interval", 1.0, "Update interval for the Entropy widget"),
        (
            "format", "ENTROPY {entropy}", "Entropy display format",
        ),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(Entropy.defaults)

    def poll(self):
        variables = dict()

        entropy = subprocess.check_output(["cat", "/proc/sys/kernel/random/entropy_avail"])
        # variables["entropy"] = str(entropy).strip()
        variables["entropy"] = int(entropy.decode("utf-8").strip())

        return self.format.format(**variables)
