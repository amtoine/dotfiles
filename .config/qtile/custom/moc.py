#!/usr/bin/env python3
# a header could go here

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
