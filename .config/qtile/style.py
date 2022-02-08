from utils import build_widgets
from utils import build_layouts
from utils import font_sizes
from utils import bars

from theme import theme


FONT = "mononoki Nerd Font"
DMFONT = "mononoki Nerd Font-20"
ARROW_SIZE, SIZE = font_sizes.small   # from small, medium, large

BAR = bars.minimal  # from minimal, normal

WIDGETS = build_widgets(
    theme,
    battery_fmt="{char}" if BAR == bars.minimal else "{char} {percent:2.0%}",
    clock_fmt=" %H:%M" if BAR == bars.minimal else " %m/%d  %H:%M",
    count_fmt="{}",
    qexit_fmt="襤",
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
    opacity=1,
    background=theme.bg,
    margin=[0, 0, 0, 0],         # N E S W
    border_width=list(map(lambda x: x * _border_width, _border)),
    border_color=[_border_color] * 4
)
