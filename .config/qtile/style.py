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
