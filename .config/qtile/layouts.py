from libqtile import layout

from style import FONT
from style import LAYOUTS as lt
from theme import theme


def _floating():
    """
        class libqtile.layout.floating.Floating(float_rules: Optional[List[libqtile.config.Match]]=None, no_reposition_rules=None, **config)[source]
        Floating layout, which does nothing with windows but handles focus
        order
    """
    return layout.Floating(
        border_focus=lt.floating.focus,    # Border colour(s) for the focused window.
        border_normal=lt.floating.normal,  # Border colour(s) for un-focused windows.
        border_width=lt.border_width,      # Border width.
        fullscreen_border_width=0,         # Border width for fullscreen.
        max_border_width=0,                # Border width for maximize.
        name="FLOAT",
    )


def _bsp():
    """
        class libqtile.layout.bsp.Bsp(**config)[source]
        This layout is inspired by bspwm, but it does not try to copy its
        features.

        The first client occupies the entire screen space. When a new client is
        created, the selected space is partitioned in 2 and the new client
        occupies one of those subspaces, leaving the old client with the other.

        The partition can be either horizontal or vertical according to the
        dimensions of the current space: if its width/height ratio is above a
        pre-configured value, the subspaces are created side-by-side,
        otherwise, they are created on top of each other. The partition
        direction can be freely toggled. All subspaces can be resized and
        clients can be shuffled around.

        All clients are organized at the leaves of a full binary tree.

        An example key configuration is:

        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
        Key([mod, "mod1"], "j", lazy.layout.flip_down()),
        Key([mod, "mod1"], "k", lazy.layout.flip_up()),
        Key([mod, "mod1"], "h", lazy.layout.flip_left()),
        Key([mod, "mod1"], "l", lazy.layout.flip_right()),
        Key([mod, "control"], "j", lazy.layout.grow_down()),
        Key([mod, "control"], "k", lazy.layout.grow_up()),
        Key([mod, "control"], "h", lazy.layout.grow_left()),
        Key([mod, "control"], "l", lazy.layout.grow_right()),
        Key([mod, "shift"], "n", lazy.layout.normalize()),
        Key([mod], "Return", lazy.layout.toggle_split()),
    """
    return layout.Bsp(
        border_focus=lt.bsp.focus,     # Border colour(s) for the focused window.
        border_normal=lt.bsp.normal,   # Border colour(s) for un-focused windows.
        border_width=lt.border_width,  # Border width.
        fair=True,                     # New clients are inserted in the shortest branch.
        grow_amount=10,                # Amount by which to grow a window/column.
        lower_right=True,              # New client occupies lower or right subspace.
        margin=lt.margin,              # Margin of the layout (int or list of ints [N E S W]).
        name=" BSP",
        ratio=1.6,                     # Width/height ratio that defines the partition direction.
    )


def _columns():
    """
        class libqtile.layout.columns.Columns(**config)[source]
        Extension of the Stack layout.

        The screen is split into columns, which can be dynamically added or
        removed. Each column can present its windows in 2 modes: split or
        stacked. In split mode, all windows are presented simultaneously,
        spliting the column space. In stacked mode, only a single window is
        presented from the stack of windows. Columns and windows can be resized
        and windows can be shuffled around.

        This layout can also emulate wmii's default layout via:

        layout.Columns(num_columns=1, insert_position=1)

        Or the "Vertical", and "Max", depending on the default parameters.

        An example key configuration is:

        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
        Key([mod, "control"], "j", lazy.layout.grow_down()),
        Key([mod, "control"], "k", lazy.layout.grow_up()),
        Key([mod, "control"], "h", lazy.layout.grow_left()),
        Key([mod, "control"], "l", lazy.layout.grow_right()),
        Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left()),
        Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right()),
        Key([mod], "Return", lazy.layout.toggle_split()),
        Key([mod], "n", lazy.layout.normalize()),
    """
    return layout.Columns(
        border_focus=lt.columns.focus,                # Border colour(s) for the focused window.
        border_focus_stack=lt.columns.focus_stack,    # Border colour(s) for the focused window in stacked columns.
        border_normal=lt.columns.normal,              # Border colour(s) for un-focused windows.
        border_normal_stack=lt.columns.normal_stack,  # Border colour(s) for un-focused windows in stacked columns.
        border_on_single=False,                       # Draw a border when there is one only window.
        border_width=lt.border_width,                 # Border width.
        fair=False,                                   # Add new windows to the column with least windows.
        grow_amount=10,                               # Amount by which to grow a window/column.
        insert_position=0,                            # Position relative to the current window where new ones are inserted (0 means right above the current window, 1 means right after).
        margin=lt.margin,                             # Margin of the layout (int or list of ints [N E S W]).
        margin_on_single=None,                        # Margin when only one window. (int or list of ints [N E S W])
        name="COLS",
        num_columns=2,                                # Preferred number of columns.
        split=True,                                   # New columns presentation mode.
        wrap_focus_columns=True,                      # Wrap the screen when moving focus across columns.
        wrap_focus_rows=True,                         # Wrap the screen when moving focus across rows.
        wrap_focus_stacks=True,                       # Wrap the screen when moving focus across stacked.
    )


def _matrix():
    """
        class libqtile.layout.matrix.Matrix(columns=2, **config)[source]
        This layout divides the screen into a matrix of equally sized cells and
        places one window in each cell. The number of columns is configurable
        and can also be changed interactively.
    """
    return layout.Matrix(
        border_focus=lt.matrix.focus,    # Border colour(s) for the focused window.
        border_normal=lt.matrix.normal,  # Border colour(s) for un-focused windows.
        border_width=lt.border_width,    # Border width.
        margin=lt.margin,                # Margin of the layout (int or list of ints [N E S W])
        name="MATX",
    )


def _max_tile():
    """
        class libqtile.layout.max.Max(**config)[source]
        Maximized layout

        A simple layout that only displays one window at a time, filling the
        screen_rect. This is suitable for use on laptops and other devices with
        small screens. Conceptually, the windows are managed as a stack, with
        commands to switch to next and previous windows in the stack.
    """
    return layout.Max(name=" MAX")


def _monad_tall():
    """
        class libqtile.layout.xmonad.MonadTall(**config)[source]
        Emulate the behavior of XMonad's default tiling scheme.

        Main-Pane:

        A main pane that contains a single window takes up a vertical portion
        of the screen_rect based on the ratio setting. This ratio can be
        adjusted with the cmd_grow_main and cmd_shrink_main or, while the main
        pane is in focus, cmd_grow and cmd_shrink.

        ---------------------
        |            |      |
        |            |      |
        |            |      |
        |            |      |
        |            |      |
        |            |      |
        ---------------------
        Using the cmd_flip method will switch which horizontal side the main
        pane will occupy. The main pane is considered the "top" of the stack.

        ---------------------
        |      |            |
        |      |            |
        |      |            |
        |      |            |
        |      |            |
        |      |            |
        ---------------------
        Secondary-panes:

        Occupying the rest of the screen_rect are one or more secondary panes.
        The secondary panes will share the vertical space of the screen_rect
        however they can be resized at will with the cmd_grow and cmd_shrink
        methods. The other secondary panes will adjust their sizes to smoothly
        fill all of the space.

        ---------------------          ---------------------
        |            |      |          |            |______|
        |            |______|          |            |      |
        |            |      |          |            |      |
        |            |______|          |            |      |
        |            |      |          |            |______|
        |            |      |          |            |      |
        ---------------------          ---------------------
        Panes can be moved with the cmd_shuffle_up and cmd_shuffle_down
        methods. As mentioned the main pane is considered the top of the
        stack; moving up is counter-clockwise and moving down is clockwise.

        The opposite is true if the layout is "flipped".

        ---------------------          ---------------------
        |            |  2   |          |   2   |           |
        |            |______|          |_______|           |
        |            |  3   |          |   3   |           |
        |     1      |______|          |_______|     1     |
        |            |  4   |          |   4   |           |
        |            |      |          |       |           |
        ---------------------          ---------------------
        Normalizing/Resetting:

        To restore all secondary client windows to their default size ratios
        use the cmd_normalize method.

        To reset all client windows to their default sizes, including the
        primary window, use the cmd_reset method.

        Maximizing:

        To toggle a client window between its minimum and maximum sizes simply
        use the cmd_maximize on a focused client.

        Suggested Bindings:

        Key([modkey], "h", lazy.layout.left()),
        Key([modkey], "l", lazy.layout.right()),
        Key([modkey], "j", lazy.layout.down()),
        Key([modkey], "k", lazy.layout.up()),
        Key([modkey, "shift"], "h", lazy.layout.swap_left()),
        Key([modkey, "shift"], "l", lazy.layout.swap_right()),
        Key([modkey, "shift"], "j", lazy.layout.shuffle_down()),
        Key([modkey, "shift"], "k", lazy.layout.shuffle_up()),
        Key([modkey], "i", lazy.layout.grow()),
        Key([modkey], "m", lazy.layout.shrink()),
        Key([modkey], "n", lazy.layout.normalize()),
        Key([modkey], "o", lazy.layout.maximize()),
        Key([modkey, "shift"], "space", lazy.layout.flip()),
    """
    return layout.MonadTall(
        align=0,                              # Which side master plane will be placed (one of MonadTall._left or MonadTall._right)
        border_focus=lt.monad_tall.focus,     # Border colour(s) for the focused window.
        border_normal=lt.monad_tall.normal,   # Border colour(s) for un-focused windows.
        border_width=lt.border_width,         # Border width.
        change_ratio=0.05,                    # Resize ratio
        change_size=20,                       # Resize change in pixels
        margin=lt.margin,                     # Margin of the layout
        max_ratio=0.75,                       # The percent of the screen-space the master pane should occupy at maximum.
        min_ratio=0.25,                       # The percent of the screen-space the master pane should occupy at minimum.
        min_secondary_size=85,                # minimum size in pixel for a secondary pane window
        name="TALL",
        new_client_position='after_current',  # Place new windows: after_current - after the active window. before_current - before the active window, top - at the top of the stack, bottom - at the bottom of the stack,
        ratio=0.6,                            # The percent of the screen-space the master pane should occupy by default.
        single_border_width=None,             # Border width for single window
        single_margin=None,                   # Margin size for single window
    )


def _monad_wide():
    """
        class libqtile.layout.xmonad.MonadWide(**config)[source]
        Emulate the behavior of XMonad's horizontal tiling scheme.

        This layout attempts to emulate the behavior of XMonad wide tiling
        scheme.

        Main-Pane:

        A main pane that contains a single window takes up a horizontal portion
        of the screen_rect based on the ratio setting. This ratio can be
        adjusted with the cmd_grow_main and cmd_shrink_main or, while the main
        pane is in focus, cmd_grow and cmd_shrink.

        ---------------------
        |                   |
        |                   |
        |                   |
        |___________________|
        |                   |
        |                   |
        ---------------------
        Using the cmd_flip method will switch which vertical side the main pane
        will occupy. The main pane is considered the "top" of the stack.

        ---------------------
        |                   |
        |___________________|
        |                   |
        |                   |
        |                   |
        |                   |
        ---------------------
        Secondary-panes:

        Occupying the rest of the screen_rect are one or more secondary panes.
        The secondary panes will share the horizontal space of the screen_rect
        however they can be resized at will with the cmd_grow and cmd_shrink
        methods. The other secondary panes will adjust their sizes to smoothly
        fill all of the space.

        ---------------------          ---------------------
        |                   |          |                   |
        |                   |          |                   |
        |                   |          |                   |
        |___________________|          |___________________|
        |     |       |     |          |   |           |   |
        |     |       |     |          |   |           |   |
        ---------------------          ---------------------
        Panes can be moved with the cmd_shuffle_up and cmd_shuffle_down
        methods. As mentioned the main pane is considered the top of the
        stack; moving up is counter-clockwise and moving down is clockwise.

        The opposite is true if the layout is "flipped".

        ---------------------          ---------------------
        |                   |          |  2  |   3   |  4  |
        |         1         |          |_____|_______|_____|
        |                   |          |                   |
        |___________________|          |                   |
        |     |       |     |          |        1          |
        |  2  |   3   |  4  |          |                   |
        ---------------------          ---------------------
        Normalizing/Resetting:

        To restore all secondary client windows to their default size ratios
        use the cmd_normalize method.

        To reset all client windows to their default sizes, including the
        primary window, use the cmd_reset method.

        Maximizing:

        To toggle a client window between its minimum and maximum sizes simply
        use the cmd_maximize on a focused client.

        Suggested Bindings:

        Key([modkey], "h", lazy.layout.left()),
        Key([modkey], "l", lazy.layout.right()),
        Key([modkey], "j", lazy.layout.down()),
        Key([modkey], "k", lazy.layout.up()),
        Key([modkey, "shift"], "h", lazy.layout.swap_left()),
        Key([modkey, "shift"], "l", lazy.layout.swap_right()),
        Key([modkey, "shift"], "j", lazy.layout.shuffle_down()),
        Key([modkey, "shift"], "k", lazy.layout.shuffle_up()),
        Key([modkey], "i", lazy.layout.grow()),
        Key([modkey], "m", lazy.layout.shrink()),
        Key([modkey], "n", lazy.layout.normalize()),
        Key([modkey], "o", lazy.layout.maximize()),
        Key([modkey, "shift"], "space", lazy.layout.flip()),
    """
    return layout.MonadWide(
        align=0,                              # Which side master plane will be placed (one of MonadTall._left or MonadTall._right)
        border_focus=lt.monad_wide.focus,     # Border colour(s) for the focused window.
        border_normal=lt.monad_wide.normal,   # Border colour(s) for un-focused windows.
        border_width=lt.border_width,         # Border width.
        change_ratio=0.05,                    # Resize ratio
        change_size=20,                       # Resize change in pixels
        margin=lt.margin,                     # Margin of the layout
        max_ratio=0.75,                       # The percent of the screen-space the master pane should occupy at maximum.
        min_ratio=0.25,                       # The percent of the screen-space the master pane should occupy at minimum.
        min_secondary_size=85,                # minimum size in pixel for a secondary pane window
        name="WIDE",
        new_client_position='after_current',  # Place new windows: after_current - after the active window. before_current - before the active window, top - at the top of the stack, bottom - at the bottom of the stack,
        ratio=0.5,                            # The percent of the screen-space the master pane should occupy by default.
        single_border_width=None,             # Border width for single window
        single_margin=None,                   # Margin size for single window
    )


def _ratio_tile():
    """
        class libqtile.layout.ratiotile.RatioTile(**config)[source]
        Tries to tile all windows in the width/height ratio passed in
    """
    return layout.RatioTile(
        border_focus=lt.ratio.focus,    # Border colour(s) for the focused window.
        border_normal=lt.ratio.normal,  # Border colour(s) for un-focused windows.
        border_width=lt.border_width,   # Border width.
        fancy=False,                    # Use a different method to calculate window sizes.
        margin=lt.margin,               # Margin of the layout (int or list of ints [N E S W])
        name="RTIO",
        ratio=1.618,                    # Ratio of the tiles
        ratio_increment=0.1,            # Amount to increment per ratio increment
    )


def _slice_tile():
    """
        class libqtile.layout.slice.Slice(**config)[source]
        Slice layout

        This layout cuts piece of screen_rect and places a single window on
        that piece, and delegates other window placement to other layout
    """
    return layout.Slice(
        fallback=layout.Max,  # Layout to be used for the non-slice area.
        match=None,           # Match-object describing which window(s) to move to the slice.
        name="SLCE",
        side='left',          # Position of the slice (left, right, top, bottom).
        width=256,            # Slice width.
    )


def _stack():
    """
        class libqtile.layout.stack.Stack(**config)[source]
        A layout composed of stacks of windows

        The stack layout divides the screen_rect horizontally into a set of
        stacks. Commands allow you to switch between stacks, to next and
        previous windows within a stack, and to split a stack to show all
        windows in the stack, or unsplit it to show only the current window.

        Unlike the columns layout the number of stacks is fixed.
    """
    return layout.Stack(
        autosplit=False,                # Auto split all new stacks.
        border_focus=lt.stack.focus,    # Border colour(s) for the focused window.
        border_normal=lt.stack.normal,  # Border colour(s) for un-focused windows.
        border_width=lt.border_width,   # Border width.
        fair=False,                     # Add new windows to the stacks in a round robin way.
        margin=lt.margin,               # Margin of the layout (int or list of ints [N E S W])
        name="STCK",
        num_stacks=3,                   # Number of stacks.
    )


def _tile():
    """
        class libqtile.layout.tile.Tile(**config)[source]
        A layout with two stacks of windows dividing the screen

        The Tile layout divides the screen_rect horizontally into two stacks.
        The maximum amount of "master" windows can be configured; surplus
        windows will be displayed in the slave stack on the right. Within their
        stacks, the windows will be tiled vertically. The windows can be
        rotated in their entirety by calling up() or down() or, if
        shift_windows is set to True, individually.
    """
    return layout.Tile(
        add_after_last=False,          # Add new clients after all the others. If this is True, it overrides add_on_top.
        add_on_top=True,               # Add new clients before all the others, potentially pushing other windows into slave stack.
        border_focus=lt.tile.focus,    # Border colour(s) for the focused window.
        border_normal=lt.tile.normal,  # Border colour(s) for un-focused windows.
        border_on_single=True,         # Whether to draw border if there is only one window.
        border_width=lt.border_width,  # Border width.
        expand=True,                   # Expand the master windows to the full screen width if no slaves are present.
        margin=lt.margin,              # Margin of the layout (int or list of ints [N E S W])
        margin_on_single=True,         # Whether to draw margin if there is only one window.
        master_length=2,               # Amount of windows displayed in the master stack. Surplus windows will be moved to the slave stack.
        master_match=None,             # A Match object defining which window(s) should be kept masters.
        max_ratio=0.85,                # Maximum width of master windows
        min_ratio=0.15,                # Minimum width of master windows
        name="TILE",
        ratio=0.618,                   # Width-percentage of screen size reserved for master windows.
        ratio_increment=0.05,          # By which amount to change ratio when cmd_decrease_ratio or cmd_increase_ratio are called.
        shift_windows=False,           # Allow to shift windows within the layout. If False, the layout will be rotated instead.
    )


def _treetab():
    """
        class libqtile.layout.tree.TreeTab(**config)[source]
        Tree Tab Layout

        This layout works just like Max but displays tree of the windows at the
        left border of the screen_rect, which allows you to overview all opened
        windows. It's designed to work with uzbl-browser but works with other
        windows too.

        The panel at the left border contains sections, each of which contains
        windows. Initially the panel looks like flat lists inside its section,
        and looks like trees if some of the windows are "moved" left or right.

        For example, it looks like below with two sections initially:

        +------------+
        |Section Foo |
        +------------+
        | Window A   |
        +------------+
        | Window B   |
        +------------+
        | Window C   |
        +------------+
        |Section Bar |
        +------------+
        And then it will look like below if "Window B" is moved right and
        "Window C" is moved right too:

        +------------+
        |Section Foo |
        +------------+
        | Window A   |
        +------------+
        |  Window B  |
        +------------+
        |   Window C |
        +------------+
        |Section Bar |
        +------------+
    """
    return layout.TreeTab(
        active_bg=theme.sel_bg,         # Background color of active tab
        active_fg=theme.sel_fg,         # Foreground color of active tab
        bg_color=theme.bg,              # Background color of tabs
        border_width=lt.border_width,   # Width of the border
        font=FONT,                      # Font
        fontshadow=None,                # font shadow color, default is None (no shadow)
        fontsize=15,                    # Font pixel size.
        inactive_bg=theme.color0,           # Background color of inactive tab
        inactive_fg=theme.fg,           # Foreground color of inactive tab
        level_shift=2,                  # Shift for children tabs
        margin_left=6,                  # Left margin of tab panel
        margin_y=2,                     # Vertical margin of tab panel
        name="TREE",
        padding_left=2,                 # Left padding for tabs
        padding_x=2,                    # Left padding for tab label
        padding_y=15,                   # Top padding for tab label
        panel_width=200,                # Width of the left panel
        previous_on_rm=False,           # Focus previous window on close instead of first.
        section_bottom=6,               # Bottom margin of section
        section_fg=theme.color9,        # Color of section label
        section_fontsize=25,            # Font pixel size of section label
        section_left=4,                 # Left margin of section label
        section_padding=4,              # Bottom of margin section label
        section_top=4,                  # Top margin of section label
        sections=["WINDOWS"],           # Foreground color of inactive tab
        urgent_bg=theme.color9,         # Background color of urgent tab
        urgent_fg=theme.color13,        # Foreground color of urgent tab
        vspace=1,                       # Space between tabs
    )


def _vertical_tile():
    """
        class libqtile.layout.verticaltile.VerticalTile(**config)[source]
        Tiling layout that works nice on vertically mounted monitors

        The available height gets divided by the number of panes, if no pane is
        maximized. If one pane has been maximized, the available height gets
        split in master- and secondary area. The maximized pane (master pane)
        gets the full height of the master area and the other panes (secondary
        panes) share the remaining space. The master area (at default 75%) can
        grow and shrink via keybindings.

        -----------------                -----------------  ---
        |               |                |               |   |
        |       1       |  <-- Panes     |               |   |
        |               |        |       |               |   |
        |---------------|        |       |               |   |
        |               |        |       |               |   |
        |       2       |  <-----+       |       1       |   |  Master Area
        |               |        |       |               |   |
        |---------------|        |       |               |   |
        |               |        |       |               |   |
        |       3       |  <-----+       |               |   |
        |               |        |       |               |   |
        |---------------|        |       |---------------|  ---
        |               |        |       |       2       |   |
        |       4       |  <-----+       |---------------|   |  Secondary Area
        |               |                |       3       |   |
        -----------------                -----------------  ---
        Normal behavior. No One maximized pane in the master area maximized
        pane. No and two secondary panes in the specific areas. secondary area.

        -----------------------------------  In some cases VerticalTile can be
        |                                 |  useful on horizontal mounted
        |                1                |  monitors two.
        |                                 |  For example if you want to have a
        |---------------------------------|  webbrowser and a shell below it.
        |                                 |
        |                2                |
        |                                 |
        -----------------------------------
        Suggested keybindings:

        Key([modkey], 'j', lazy.layout.down()),
        Key([modkey], 'k', lazy.layout.up()),
        Key([modkey], 'Tab', lazy.layout.next()),
        Key([modkey, 'shift'], 'Tab', lazy.layout.next()),
        Key([modkey, 'shift'], 'j', lazy.layout.shuffle_down()),
        Key([modkey, 'shift'], 'k', lazy.layout.shuffle_up()),
        Key([modkey], 'm', lazy.layout.maximize()),
        Key([modkey], 'n', lazy.layout.normalize()),
    """
    return layout.VerticalTile(
        border_focus=lt.vertical.focus,    # Border color(s) for the focused window.
        border_normal=lt.vertical.normal,  # Border color(s) for un-focused windows.
        border_width=lt.border_width,      # Border width.
        margin=lt.margin,                  # Border margin (int or list of ints [N E S W]).
        name="VTIL",
    )


def _zoomy():
    """
        class libqtile.layout.zoomy.Zoomy(**config)[source]
        A layout with single active windows, and few other previews at the right
    """
    return layout.Zoomy(
        columnwidth=150,       # Width of the right column
        margin=lt.margin,      # Margin of the layout (int or list of ints [N E S W])
        name="ZOOM",
        property_big='1.0',    # Property value to set on normal window (X11 only)
        property_name='ZOOM',  # Property to set on zoomed window (X11 only)
        property_small='0.1',  # Property value to set on zoomed window (X11 only)
    )


def init_layouts() -> list:
    """
        Returns a list of all the useable layouts.
    """
    return [
        _bsp(),
        _monad_tall(),
        _monad_wide(),
        _max_tile(),
        _columns(),
        _treetab(),
    ]
