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
