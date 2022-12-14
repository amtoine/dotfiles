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


class MOC(widget.base.ThreadPoolText):
    """
        A simple widget to interact with the moc music player.

        Widget requirements: the moc music player, subprocess
    """
    defaults = [
        ("update_interval", 1.0, "Update interval for the MOC widget"),
        (
            "format", "{state} {title} {ct}", "MOC display format",
        ),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(MOC.defaults)

    def poll(self):
        sep = "__SEP__"
        fmt = sep.join(["%state", "%file", "%title", "%artist", "%song", "%album", "%tt", "%tl", "%ts", "%ct", "%cs", "%b", "%r"])
        states = {"PAUSE": '', "PLAY": '', "STOP": ''}
        try:
            moc_state = subprocess.check_output(["mocp", f"-Q {fmt}"]).decode("utf-8").strip()
        except subprocess.CalledProcessError:
            moc_state = "FATAL_ERROR"

        if moc_state == "FATAL_ERROR":
            return " --:--"

        variables = dict()
        state, file, title, artist, song, album, tt, tl, ts, ct, cs, b, r = moc_state.split(sep)
        variables["state"] = states[state] if state in states else '?'
        variables["file"] = file
        variables["title"] = title
        variables["artist"] = artist
        variables["song"] = song
        variables["album"] = album
        variables["tt"] = tt
        variables["tl"] = tl
        variables["ts"] = ts
        variables["ct"] = ct
        variables["cs"] = cs
        variables["b"] = b
        variables["r"] = r

        return self.format.format(**variables)
