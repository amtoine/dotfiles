from utils import build_widgets
from utils import build_layouts
from utils import font_sizes
from utils import bars

from theme import theme


FONT = "mononoki Nerd Font"
DMFONT = "mononoki Nerd Font-20"
# BEGIN_QTILE_BAR_THEME
# this might be automatically edited by ~/.config/qtile/scripts/qtile-bar.sh
# choose from tiny, small, medium, large, huge
ARROW_SIZE, SIZE, GROUP_SIZE = font_sizes.small
# choose from minimal, decreased, normal
BAR = bars.decreased
# END_QTILE_BAR_THEME

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
LAYOUTS = build_layouts(
    theme,
    border_width=8,
    margin=8
)

_border_width = LAYOUTS.border_width // 2
_border = (0, 0, 1, 0)
_border_color = theme.sel_bg
BAR_GEOMETRY = dict(
    size=SIZE,
    opacity=.8 if BAR in [bars.minimal, bars.decreased] else 1.,
    background=theme.bg,
    margin=[0, 0, 0, 0],         # N E S W
    border_width=list(map(lambda x: x * _border_width, _border)),
    border_color=[_border_color] * 4
)
