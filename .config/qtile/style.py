#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __     _        _
#          __    / /  __ _    / /  __| |_ _  _| |___   _ __ _  _
#      _  / _|  / /  / _` |  / /  (_-<  _| || | / -_)_| '_ \ || |
#     (_) \__| /_/   \__, | /_/   /__/\__|\_, |_\___(_) .__/\_, |
#                       |_|               |__/        |_|   |__/
#
# Description:  this is the most uesr friendly config file for qtile, where
#               one might want to modify things the most.
# Dependencies: nerd-fonts-mononoki
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

from theme import theme
from utils import build_widgets
from utils import build_layouts
from utils import font_sizes
from utils import bars


# the fonts used for the widgets and dmenu respectively
FONT = "mononoki Nerd Font"
DMFONT = "mononoki Nerd Font-20"

# BEGIN_QTILE_BAR_THEME
# this might be automatically edited by ~/.config/qtile/scripts/qtile-bar.sh
# choose from tiny, small, medium, large, huge
ARROW_SIZE, SIZE, GROUP_SIZE = font_sizes.large
# choose from minimal, decreased, normal
BAR = bars.decreased
# END_QTILE_BAR_THEME

# builds the widgets with current theme
# and some styling that depends on the bar
WIDGETS = build_widgets(
    theme=theme,
    battery_fmt="{char}" if BAR in [bars.minimal, bars.decreased] else "{char} {percent:2.0%}",
    clock_fmt=" %H:%M" if BAR == bars.decreased else " %m/%d  %H:%M",
    wlan_co_fmt=" " if BAR == bars.decreased else " {essid} {quality:02d}/70",
    wlan_dis_fmt="睊 " if BAR == bars.decreased else "睊 --/--",
    count_fmt="{}",
    qexit_fmt="襤",
    group_size=GROUP_SIZE,
)
# build the layouts with current theme
# and some border size and margins for the windows
LAYOUTS = build_layouts(
    theme,
    border_width=8,
    margin=8
)

# this is the bar geometry
_border_width = LAYOUTS.border_width // 2
_margin_width = LAYOUTS.border_width // 2
#          N  E  S  W
_border = (0, 0, 0, 0)
_margin = (1, 1, 1, 1)
_border_color = theme.sel_bg
BAR_GEOMETRY = dict(
    size=SIZE,
    opacity=.9 if BAR in [bars.minimal, bars.decreased] else 1.,
    background=theme.bg,
    #       N  E  S  W
    margin=list(map(lambda x: x * _margin_width, _margin)),
    border_width=list(map(lambda x: x * _border_width, _border)),
    border_color=[_border_color] * 4
)
