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
from utils.widgets import build_widgets
from utils.layouts import build_layouts
from utils.constants import font_sizes
from utils.constants import bar_styles
from utils.constants import sep_styles

# the fonts used for the widgets and dmenu respectively
FONT = "mononoki Nerd Font"
DMFONT = "mononoki Nerd Font-20"

# BEGIN_QTILE_BAR_THEME
# this might be automatically edited by ~/.config/qtile/scripts/qtile-bar.sh
# choose from tiny, small, medium, large, huge
ARROW_SIZE, BAR_SIZE, GROUP_SIZE = font_sizes.large
# the bar content
# choose from minimal, decreased, normal
BAR_STYLE = bar_styles.minimal
# the widget separator style
# choose vmono, vcolor, smono, scolor
SEP_STYLE = sep_styles.scolor
# END_QTILE_BAR_THEME

# the following lists contain formats for the widgets, in all the bar styles
# that are available
# the format is    "minimal", "decreased", "normal"
battery_fmts = [
                   "{char}",  "{char}",    "{char} {percent:2.0%}"
]
clock_fmts = [
                   " %H:%M", " %H:%M",   " %m/%d  %H:%M"
]
wlan_co_fmts = [
                   " ",      " ",        " {essid} {quality:02d}/70"
]
wlan_dis_fmts = [
                   "睊 ",      "睊 ",        "睊 --/--"
]
dunst_fmts = [
                   "{state}", "{state}", "{state} {count}"
]
# builds the widgets with current theme
# and some styling that depends on the bar
WIDGETS = build_widgets(
    countdown_fmt="{}",
    qexit_fmt="襤",
    theme=theme,
    battery_fmt=battery_fmts[BAR_STYLE],
    clock_fmt=clock_fmts[BAR_STYLE],
    wlan_co_fmt=wlan_co_fmts[BAR_STYLE],
    wlan_dis_fmt=wlan_dis_fmts[BAR_STYLE],
    dunst_fmt=dunst_fmts[BAR_STYLE],
    group_size=GROUP_SIZE,
)
# build the layouts with current theme
# and some border size and margins for the windows
LAYOUTS = build_layouts(
    theme,
    border_width=2,
    margin=2,
)

# this is the bar geometry
_border_width = 2
_margin_width = 2
#          N  E  S  W
_border = (1, 1, 1, 1)
_margin = (1, 1, 1, 1)
_border_color = theme.fg
BAR_GEOMETRY = dict(
    size=BAR_SIZE,
    opacity=.9 if BAR_STYLE <= bar_styles.decreased else 1.,
    background=theme.bg,
    margin=list(map(lambda x: x * _margin_width, _margin)),
    border_width=list(map(lambda x: x * _border_width, _border)),
    border_color=[_border_color] * 4
)
