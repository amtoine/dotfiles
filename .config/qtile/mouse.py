from libqtile.config import Drag
from libqtile.config import Click
from libqtile.lazy import lazy


def init_mouse(mod: str) -> list:
    """
        Some options for the mouse.
    """
    return [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
    ]
