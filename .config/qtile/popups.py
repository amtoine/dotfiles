#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#                 __           __       _   _ _
#          __    / /  __ _    / /  _  _| |_(_) |___  _ __ _  _
#      _  / _|  / /  / _` |  / /  | || |  _| | (_-<_| '_ \ || |
#     (_) \__| /_/   \__, | /_/    \_,_|\__|_|_/__(_) .__/\_, |
#                       |_|                         |_|   |__/
#
# Description:  a collection of popups wrappers from qtile-extras-git
# Dependencies: qtile-extras-git
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

from qtile_extras.popup.toolkit import PopupGridLayout
from qtile_extras.popup.toolkit import PopupText

from theme import theme
from style import FONT


def text_popup(qtile, text, size=150):
    """
        Opens a popup with a single string of text.
    """
    controls = [
        PopupText(
            font=FONT,
            fontsize=size,
            text=text,
            v_align="center",
            h_align="center",
            row=0,
            col=0,
        ),
    ]

    layout = PopupGridLayout(
        qtile,
        width=int(0.65 * len(text) * size),
        height=int(1.33 * size),
        controls=controls,
        background=theme.color8 + "d0",
        margin=16,
        opacity=1.,
        initial_focus=0,
        rows=1,
        cols=1,
    )

    layout.show(centered=True)
    qtile.call_later(.5, layout.kill)  # kill popup after 1 second
