#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __            _     __           __
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  _      __(_)___/ /___ ____  / /______         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   | | /| / / / __  / __ `/ _ \/ __/ ___/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/     | |/ |/ / / /_/ / /_/ /  __/ /_(__  )   _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/       |__/|__/_/\__,_/\__, /\___/\__/____/   (_)  / .___/\__, /
#                                /____/              /_/                                         /____/                      /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

from libqtile import widget
from libqtile.lazy import lazy

from themes import widget_theme as wt


def init_widget_defaults():
    return dict(
        font='sans',
        fontsize=12,
        padding=3,
    )


def _sep(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Sep(**config)[source]
        A visible widget separator

        Supported bar orientations: horizontal and vertical
    """
    return widget.Sep(
        background=bg,        # Widget background color
        foreground=fg,        # Separator line colour.
        linewidth=10,          # Width of separator line.
        mouse_callbacks={},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=2,            # Padding on either side of separator.
        size_percent=20,      # Size as a percentage of bar size (0-100).
    )


def _image(bg="#000000"):
    """
        class libqtile.widget.Image(length=CALCULATED, **config)[source]
        Display a PNG image on the bar
        Supported bar orientations: horizontal and vertical
    """
    return widget.Image(
        background=bg,                                                 # Widget background color
        filename=None,                                                 # Image filename. Can contain '~'
        # filename="~/.config/qtile/icons/python-white.png",
        margin=3,                                                      # Margin inside the box
        margin_x=None,                                                 # X Margin. Overrides 'margin' if set
        margin_y=None,                                                 # Y Margin. Overrides 'margin' if set
        mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm)},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        rotate=0.0,                                                    # rotate the image in degrees counter-clockwise
        scale=True,                                                    # Enable/Disable image scaling
    )


def _thermal_sensor(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.ThermalSensor(**config)[source]
        Widget to display temperature sensor information
        For using the thermal sensor widget you need to have lm-sensors
        installed. You can get a list of the tag_sensors executing "sensors" in
        your terminal. Then you can choose which you want, otherwise it will
        display the first available.
        Widget requirements: psutil.
        Supported bar orientations: horizontal and vertical
    """
    return widget.ThermalSensor(
        background=bg,              # Widget background color
        fmt='{}',                   # How to format the text
        font='sans',                # Default font
        fontshadow=None,            # font shadow color, default is None(no shadow)
        fontsize=None,              # Font size. Calculated if None.
        foreground=fg,              # Foreground colour
        foreground_alert='ff0000',  # Foreground colour alert
        markup=True,                # Whether or not to use pango markup
        max_chars=0,                # Maximum number of characters to display in widget.
        metric=True,                # True to use metric/C, False to use imperial/F
        mouse_callbacks={},         # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,               # Padding. Calculated if None.
        show_tag=False,             # Show tag sensor
        tag_sensor=None,            # Tag of the temperature sensor. For example: "temp1" or "Core 0"
        threshold=70,               # If the current temperature value is above, then change to foreground_alert colour
        update_interval=2,          # Update interval in seconds
    )


def _check_updates(terminal, bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CheckUpdates(**config)[source]
        Shows number of pending updates in different unix systems
        Supported bar orientations: horizontal and vertical
    """
    return widget.CheckUpdates(
        background=bg,                                                                         # Widget background color
        colour_have_updates=fg,                                                                # Colour when there are updates.
        colour_no_updates=fg,                                                                  # Colour when there's no updates.
        custom_command=None,                                                                   # Custom shell command for checking updates (counts the lines of the output)
        custom_command_modify=None,                                                            # Lambda function to modify line count from custom_command
        display_format='Updates: {updates}',                                                   # Display format if updates available
        distro='Arch_checkupdates',                                                            # Name of your distribution
        execute=terminal + " bash -c \"sudo pacman -Syu\"",                                                # Command to execute on click
        fmt='{}',                                                                              # How to format the text
        font='sans',                                                                           # Default font
        fontshadow=None,                                                                       # font shadow color, default is None(no shadow)
        fontsize=None,                                                                         # Font size. Calculated if None.
        foreground=fg,                                                                         # Foreground colour
        markup=True,                                                                           # Whether or not to use pango markup
        max_chars=0,                                                                           # Maximum number of characters to display in widget.
        # mouse_callbacks={'Button1': lambda: lazy.spawn(terminal + ' sudo pacman -Syu')},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        mouse_callbacks={'Button1': lambda: lazy.spawn('kitty bash -c "sudo pacman -Syu"')},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        no_update_string='',                                                                   # String to display if no updates available
        padding=None,                                                                          # Padding. Calculated if None.
        restart_indicator='',                                                                  # Indicator to represent reboot is required. (Ubuntu only)
        update_interval=1800,                                                                  # Update interval in seconds.
    )


def _memory(terminal, bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Memory(**config)[source]
        Displays memory/swap usage
        MemUsed: Returns memory in use
        MemTotal: Returns total amount of memory
        MemFree: Returns amount of memory free
        MemPercent: Returns memory in use as a percentage
        Buffers: Returns buffer amount
        Active: Returns active memory
        Inactive: Returns inactive memory
        Shmem: Returns shared memory
        SwapTotal: Returns total amount of swap
        SwapFree: Returns amount of swap free
        SwapUsed: Returns amount of swap in use
        SwapPercent: Returns swap in use as a percentage
        Widget requirements: psutil.
        Supported bar orientations: horizontal and vertical
    """
    return widget.Memory(
        background=bg,                                                              # Widget background color
        fmt='{}',                                                                   # How to format the text
        font='sans',                                                                # Default font
        fontshadow=None,                                                            # font shadow color, default is None(no shadow)
        fontsize=None,                                                              # Font size. Calculated if None.
        foreground=fg,                                                              # Foreground colour
        format='{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}',                            # Formatting for field names.
        markup=True,                                                                # Whether or not to use pango markup
        max_chars=0,                                                                # Maximum number of characters to display in widget.
        measure_mem='M',                                                            # Measurement for Memory (G, M, K, B)
        measure_swap='M',                                                           # Measurement for Swap (G, M, K, B)
        mouse_callbacks={'Button1': lambda: lazy.spawn(terminal + ' htop')},        # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                                                               # Padding. Calculated if None.
        update_interval=1.0,                                                        # Update interval for the Memory
    )


def _volume(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Volume(**config)[source]
        Widget that display and change volume
        By default, this widget uses amixer to get and set the volume so users
        will need to make sure this is installed. Alternatively, users may set
        the relevant parameters for the widget to use a different application.
        If theme_path is set it draw widget as icons.
        Supported bar orientations: horizontal only
    """
    return widget.Volume(
        background=bg,             # Widget background color
        cardid=None,               # Card Id
        channel='Master',          # Channel
        device='default',          # Device Name
        emoji=False,               # Use emoji to display volume states, only if theme_path is not set.The specified font needs to contain the correct unicode characters.
        fmt='{}',                  # How to format the text
        font='sans',               # Default font
        fontshadow=None,           # font shadow color, default is None(no shadow)
        fontsize=None,             # Font size. Calculated if None.
        foreground=fg,             # Foreground colour
        get_volume_command=None,   # Command to get the current volume
        markup=True,               # Whether or not to use pango markup
        max_chars=0,               # Maximum number of characters to display in widget.
        mouse_callbacks={},        # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        mute_command=None,         # Mute command
        padding=3,                 # Padding left and right. Calculated if None.
        step=2,                    # Volume change for up an down commands in percentage.Only used if volume_up_command and volume_down_command are not set.
        theme_path=None,           # Path of the icons
        update_interval=0.2,       # Update time in seconds.
        volume_app=None,           # App to control volume
        volume_down_command=None,  # Volume down command
        volume_up_command=None,    # Volume up command
    )


def _keyboard_layout(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.KeyboardLayout(**config)[source]
        Widget for changing and displaying the current keyboard layout
        To use this widget effectively you need to specify keyboard layouts you
        want to use (using "configured_keyboards") and bind function
        "next_keyboard" to specific keys in order to change layouts.
        For example:
        Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),
        When running Qtile with the X11 backend, this widget requires setxkbmap
        to be available.
        Supported bar orientations: horizontal and vertical
    """
    return widget.KeyboardLayout(
        background=bg,                # Widget background color
        configured_keyboards=['us'],  # A list of predefined keyboard layouts represented as strings. For example: ['us', 'us colemak', 'es', 'fr'].
        display_map={},               # Custom display of layout. Key should be in format 'layout variant'. For example: {'us': 'us', 'lt sgs': 'sgs', 'ru phonetic': 'ru'}
        fmt='{}',                     # How to format the text
        font='sans',                  # Default font
        fontshadow=None,              # font shadow color, default is None(no shadow)
        fontsize=None,                # Font size. Calculated if None.
        foreground=fg,                # Foreground colour
        markup=True,                  # Whether or not to use pango markup
        max_chars=0,                  # Maximum number of characters to display in widget.
        mouse_callbacks={},           # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        option=None,                  # string of setxkbmap option. Ex., 'compose:menu,grp_led:scroll'
        padding=None,                 # Padding. Calculated if None.
        update_interval=1,            # Update time in seconds.
    )


def _backlight(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Backlight(**config)[source]
        A simple widget to show the current brightness of a monitor.
        If the change_command parameter is set to None, the widget will attempt
        to use the interface at /sys/class to change brightness. Depending on
        the setup, the user may need to be added to the video group to have
        permission to write to this interface. This depends on having
        the correct udev rules the brightness file; these are typically
        installed alongside brightness tools such as brightnessctl (which
        changes the group to 'video') so installing that is an easy way to get
        it working.
        You can also bind keyboard shortcuts to the backlight widget with:
        Supported bar orientations: horizontal and vertical
    """
    return widget.Backlight(
        background=bg,                         # Widget background color
        backlight_name='intel_backlight',          # ACPI name of a backlight device
        brightness_file='brightness',          # Name of file with the current brightness in /sys/class/backlight/backlight_name
        change_command='xbacklight -set {0}',  # Execute command to change value
        fmt='{}',                              # How to format the text
        font='sans',                           # Default font
        fontshadow=None,                       # font shadow color, default is None(no shadow)
        fontsize=None,                         # Font size. Calculated if None.
        foreground=fg,                         # Foreground colour
        format='{percent:2.0%}',               # Display format
        markup=True,                           # Whether or not to use pango markup
        max_brightness_file='max_brightness',  # Name of file with the maximum brightness in /sys/class/backlight/backlight_name
        max_chars=0,                           # Maximum number of characters to display in widget.
        mouse_callbacks={},                    # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                          # Padding. Calculated if None.
        step=10,                               # Percent of backlight every scroll changed
        update_interval=0.2,                   # The delay in seconds between updates
    )


def _bluetooth(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Bluetooth(**config)[source]
        Displays bluetooth status or connected device.
        Uses dbus to communicate with the system bus.
        Widget requirements: dbus-next.
        Supported bar orientations: horizontal and vertical
    """
    return widget.Bluetooth(
        background=bg,                 # Widget background color
        fmt='{}',                      # How to format the text
        font='sans',                   # Default font
        fontshadow=None,               # font shadow color, default is None(no shadow)
        fontsize=None,                 # Font size. Calculated if None.
        foreground=fg,                 # Foreground colour
        hci='/dev_XX_XX_XX_XX_XX_XX',  # hci0 device path, can be found with d-feet or similar dbus explorer.
        markup=True,                   # Whether or not to use pango markup
        max_chars=0,                   # Maximum number of characters to display in widget.
        mouse_callbacks={},            # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                  # Padding. Calculated if None.
    )


def _cpu(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CPU(**config)[source]
        A simple widget to display CPU load and frequency.
        Widget requirements: psutil.
        Supported bar orientations: horizontal and vertical
    """
    return widget.CPU(
        background=bg,                                   # Widget background color
        fmt='{}',                                        # How to format the text
        font='sans',                                     # Default font
        fontshadow=None,                                 # font shadow color, default is None(no shadow)
        fontsize=None,                                   # Font size. Calculated if None.
        foreground=fg,                                   # Foreground colour
        format='CPU {freq_current}GHz {load_percent}%',  # CPU display format
        markup=True,                                     # Whether or not to use pango markup
        max_chars=0,                                     # Maximum number of characters to display in widget.
        mouse_callbacks={},                              # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                                    # Padding. Calculated if None.
        update_interval=1.0,                             # Update interval for the CPU widget
    )


def _current_screen(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CurrentScreen(width=CALCULATED, **config)[source]
        Indicates whether the screen this widget is on is currently active or not
        Supported bar orientations: horizontal and vertical
    """
    return widget.CurrentScreen(
        active_color='00ff00',    # Color when screen is active
        active_text='A',          # Text displayed when the screen is active
        background=bg,            # Widget background color
        fmt='{}',                 # How to format the text
        font='sans',              # Default font
        fontshadow=None,          # font shadow color, default is None(no shadow)
        fontsize=None,            # Font size. Calculated if None.
        foreground=fg,            # Foreground colour
        inactive_color='ff0000',  # Color when screen is inactive
        inactive_text='I',        # Text displayed when the screen is inactive
        markup=True,              # Whether or not to use pango markup
        max_chars=0,              # Maximum number of characters to display in widget.
        mouse_callbacks={},       # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,             # Padding. Calculated if None.
    )


def _hdd(bg="#000000"):
    """
        class libqtile.widget.HDDGraph(**config)[source]
        Display HDD free or used space graph
        Supported bar orientations: horizontal only
    """
    return widget.HDDGraph(
        background=bg,          # Widget background color
        border_color='215578',  # Widget border color
        border_width=2,         # Widget border width
        fill_color='1667EB.3',  # Fill color for linefill graph
        frequency=1,            # Update frequency in seconds
        graph_color='ffBAEB',   # Graph color
        line_width=3,           # Line width
        margin_x=3,             # Margin X
        margin_y=3,             # Margin Y
        mouse_callbacks={},     # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        path='/',               # Partition mount point.
        samples=100,            # Count of graph samples.
        space_type='free',      # free/used
        start_pos='bottom',     # Drawer starting position ('bottom'/'top')
        type='box',        # 'box', 'line', 'linefill'
    )


def _wallpaper(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Wallpaper(**config)[source]
        Supported bar orientations: horizontal and vertical
    """
    return widget.Wallpaper(
        background=bg,                               # Widget background color
        directory='~/repos/wallpapers/wallpapers/',  # Wallpaper Directory
        fmt='{}',                                    # How to format the text
        font='sans',                                 # Default font
        fontshadow=None,                             # font shadow color, default is None(no shadow)
        fontsize=None,                               # Font size. Calculated if None.
        foreground=fg,                               # Foreground colour
        label=None,                                  # Use a fixed label instead of image name.
        markup=True,                                 # Whether or not to use pango markup
        max_chars=4,                                 # Maximum number of characters to display in widget.
        mouse_callbacks={},                          # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        option='fill',                               # How to fit the wallpaper when wallpaper_command isNone. None, 'fill' or 'stretch'.
        padding=None,                                # Padding. Calculated if None.
        random_selection=False,                      # If set, use random initial wallpaper and randomly cycle through the wallpapers.
        wallpaper=None,                              # Wallpaper
        wallpaper_command=['feh', '--bg-fill'],      # Wallpaper command. If None, thewallpaper will be painted without the use of a helper.
    )


def _current_layout(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CurrentLayout(width=CALCULATED, **config)[source]
        Display the name of the current layout of the current group of the
        screen, the bar containing the widget, is on.

        Supported bar orientations: horizontal and vertical
    """
    return widget.CurrentLayout(
        background=bg,        # Widget background color
        fmt='{}',             # How to format the text
        font='sans',          # Default font
        fontshadow=None,      # font shadow color, default is None(no shadow)
        fontsize=None,        # Font size. Calculated if None.
        foreground=fg,        # Foreground colour
        markup=True,          # Whether or not to use pango markup
        max_chars=0,          # Maximum number of characters to display in widget.
        mouse_callbacks={},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,         # Padding. Calculated if None.
    )


def _current_layout_icon(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CurrentLayoutIcon(**config)[source]
        Display the icon representing the current layout of the current group
        of the screen on which the bar containing the widget is.

        If you are using custom layouts, a default icon with question mark will
        be displayed for them. If you want to use custom icon for your own
        layout, for example, FooGrid, then create a file named
        "layout-foogrid.png" and place it in ~/.icons directory. You can as
        well use other directories, but then you need to specify those
        directories in custom_icon_paths argument for this plugin.

        The order of icon search is:

        dirs in custom_icon_paths config argument

        ~/.icons

        built-in qtile icons

        Supported bar orientations: horizontal only
    """
    return widget.CurrentLayoutIcon(
        background=bg,         # Widget background color
        custom_icon_paths=[],  # List of folders where to search icons beforeusing built-in icons or icons in ~/.icons dir. This can also be used to providemissing icons for custom layouts. Defaults to empty list.
        fmt='{}',              # How to format the text
        font='sans',           # Default font
        fontshadow=None,       # font shadow color, default is None(no shadow)
        fontsize=None,         # Font size. Calculated if None.
        foreground=fg,         # Foreground colour
        markup=True,           # Whether or not to use pango markup
        max_chars=0,           # Maximum number of characters to display in widget.
        mouse_callbacks={},    # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,          # Padding. Calculated if None.
        scale=1,               # Scale factor relative to the bar height. Defaults to 1
    )


def _group_box(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.GroupBox(**config)[source]
        A widget that graphically displays the current group. All groups are
        displayed by their label. If the label of a group is the empty string
        that group will not be displayed.

        Supported bar orientations: horizontal only
    """
    return widget.GroupBox(
        active='FFFFFF',                       # Active group font colour
        background=bg,                         # Widget background color
        block_highlight_text_color=None,       # Selected group font colour
        borderwidth=3,                         # Current group border width
        center_aligned=True,                   # center-aligned group box
        disable_drag=False,                    # Disable dragging and dropping of group names on widget
        fmt='{}',                              # How to format the text
        font='sans',                           # Default font
        fontshadow=None,                       # font shadow color, default is None(no shadow)
        fontsize=15,                           # Font size. Calculated if None.
        foreground=fg,                         # Foreground colour
        hide_unused=False,                     # Hide groups that have no windows and that are not displayed on any screen.
        highlight_color=['000000', '282828'],  # Active group highlight color when using 'line' highlight method.
        highlight_method='border',             # Method of highlighting ('border', 'block', 'text', or 'line')Uses *_border color settings
        inactive='404040',                     # Inactive group font colour
        invert_mouse_wheel=False,              # Whether to invert mouse wheel group movement
        margin=3,                              # Margin inside the box
        margin_x=None,                         # X Margin. Overrides 'margin' if set
        margin_y=None,                         # Y Margin. Overrides 'margin' if set
        markup=True,                           # Whether or not to use pango markup
        max_chars=0,                           # Maximum number of characters to display in widget.
        mouse_callbacks={},                    # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        other_current_screen_border='404040',  # Border or line colour for group on other screen when focused.
        other_screen_border='404040',          # Border or line colour for group on other screen when unfocused.
        # padding=None,                          # Padding. Calculated if None.
        # padding_x=None,                        # X Padding. Overrides 'padding' if set
        # padding_y=None,                        # Y Padding. Overrides 'padding' if set
        rounded=True,                          # To round or not to round box borders
        spacing=None,                          # Spacing between groups(if set to None, will be equal to margin_x)
        this_current_screen_border='215578',   # Border or line colour for group on this screen when focused.
        this_screen_border='215578',           # Border or line colour for group on this screen when unfocused.
        urgent_alert_method='border',          # Method for alerting you of WM urgent hints (one of 'border', 'text', 'block', or 'line')
        urgent_border='FF0000',                # Urgent border or line color
        urgent_text='FF0000',                  # Urgent group font color
        use_mouse_wheel=True,                  # Whether to use mouse wheel events
        visible_groups=None,                   # Groups that will be visible. If set to None or [], all groups will be visible.Visible groups are identified by name not by their displayed label.
    )


def _prompt(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Prompt(name='prompt', **config)[source]
        A widget that prompts for user input

        Input should be started using the .start_input() method on this class.

        Supported bar orientations: horizontal and vertical
    """
    return widget.Prompt(
        background=bg,               # Widget background color
        bell_style='audible',        # Alert at the begin/end of the command history. Possible values: 'audible' (X11 only), 'visual' and None.
        cursor=True,                 # Show a cursor
        cursor_color='bef098',       # Color for the cursor and text over it.
        cursorblink=0.5,             # Cursor blink rate. 0 to disable.
        fmt='{}',                    # How to format the text
        font='sans',                 # Default font
        fontshadow=None,             # font shadow color, default is None(no shadow)
        fontsize=None,               # Font size. Calculated if None.
        foreground=fg,               # Foreground colour
        ignore_dups_history=False,   # Don't store duplicates in history
        markup=True,                 # Whether or not to use pango markup
        max_chars=0,                 # Maximum number of characters to display in widget.
        max_history=100,             # Commands to keep in history. 0 for no limit.
        mouse_callbacks={},          # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                # Padding. Calculated if None.
        prompt='{prompt}: ',         # Text displayed at the prompt
        record_history=True,         # Keep a record of executed commands
        visual_bell_color='ff0000',  # Color for the visual bell (changes prompt background).
        visual_bell_time=0.2,        # Visual bell duration (in seconds).
    )


def _window_name(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.WindowName(width=STRETCH, **config)[source]
        Displays the name of the window that currently has focus

        Supported bar orientations: horizontal and vertical
    """
    return widget.WindowName(
        background=bg,             # Widget background color
        empty_group_string=' ',    # string to display when no windows are focused on current group
        fmt='{}',                  # How to format the text
        font='sans',               # Default font
        fontshadow=None,           # font shadow color, default is None(no shadow)
        fontsize=None,             # Font size. Calculated if None.
        for_current_screen=False,  # instead of this bars screen use currently active screen
        foreground=fg,             # Foreground colour
        format='{state}{name}',    # format of the text
        markup=True,               # Whether or not to use pango markup
        max_chars=0,               # Maximum number of characters to display in widget.
        mouse_callbacks={},        # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,              # Padding. Calculated if None.
        parse_text=None,           # Function to parse and modify window names. e.g. function in config that removes excess strings from window name: def my_func(text) for string in [" - Chromium", " - Firefox"]: text=text.replace(string, "") return textthen set option parse_text=my_func
    )


def _chord(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Chord(width=CALCULATED, **config)[source]
        Display current key chord

        Supported bar orientations: horizontal and vertical
    """
    return widget.Chord(
        background=bg,                                     # Widget background color
        chords_colors={'launch': ("#ff0000", "#ffffff")},  # colors per chord in form of tuple ('bg', 'fg').
        fmt='{}',                                          # How to format the text
        font='sans',                                       # Default font
        fontshadow=None,                                   # font shadow color, default is None(no shadow)
        fontsize=None,                                     # Font size. Calculated if None.
        foreground=fg,                                     # Foreground colour
        markup=True,                                       # Whether or not to use pango markup
        max_chars=0,                                       # Maximum number of characters to display in widget.
        mouse_callbacks={},                                # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        name_transform=lambda name: name.upper(),          # preprocessor for chord name it is pure function string -> string
        padding=None,                                      # Padding. Calculated if None.
    )


def _text_box(text='', bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.TextBox(text=' ', width=CALCULATED, **config)[source]
        A flexible textbox that can be updated from bound keys, scripts, and
        qshell.

        Supported bar orientations: horizontal and vertical
    """
    return widget.TextBox(
        text,
        background=bg,          # Widget background color
        fmt='{}',               # How to format the text
        font='sans',            # Text font
        fontshadow=None,        # font shadow color, default is None(no shadow)
        fontsize=None,          # Font pixel size. Calculated if None.
        foreground=fg,          # Foreground colour.
        markup=True,            # Whether or not to use pango markup
        max_chars=0,            # Maximum number of characters to display in widget.
        mouse_callbacks={},     # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,           # Padding left and right. Calculated if None.
    )


def _systray(bg="#000000"):
    """
        class libqtile.widget.Systray(**config)[source]
        A widget that manages system tray.

        Note

        Icons will not render correctly where the bar/widget is drawn with a
        semi-transparent background. Instead, icons will be drawn with a
        transparent background.

        If using this widget it is therefore recommended to use a fully opaque
        background colour or a fully transparent one.

        Supported bar orientations: horizontal and vertical
    """
    return widget.Systray(
        background=bg,       # Widget background color
        icon_size=20,        # Icon width
        mouse_callbacks={},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=5,           # Padding between icons
    )


def _clock(format='%H:%M', bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Clock(**config)[source]
        A simple but flexible text-based clock

        Supported bar orientations: horizontal and vertical
    """
    return widget.Clock(
        background=bg,        # Widget background color
        fmt='{}',             # How to format the text
        font='sans',          # Default font
        fontshadow=None,      # font shadow color, default is None(no shadow)
        fontsize=None,        # Font size. Calculated if None.
        foreground=fg,        # Foreground colour
        format=format,        # A Python datetime format string
        markup=True,          # Whether or not to use pango markup
        max_chars=0,          # Maximum number of characters to display in widget.
        mouse_callbacks={"Button1": lambda: lazy.spawn("dmenu_run")},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,         # Padding. Calculated if None.
        timezone=None,        # The timezone to use for this clock, either as string if pytz or dateutil is installed (e.g. "US/Central" or anything in /usr/share/zoneinfo), or as tzinfo (e.g. datetime.timezone.utc). None means the system local timezone and is the default.
        update_interval=1.0,  # Update interval for the clock
    )


def _battery(format, bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Battery(**config)[source]
        A text-based battery monitoring widget currently supporting FreeBSD

        Supported bar orientations: horizontal and vertical
    """
    return widget.Battery(
        background=bg,            # Widget background color
        battery=0,                # Which battery should be monitored (battery number or name)
        charge_char='\uf0d8',     # Character to indicate the battery is charging
        discharge_char='\uf0d7',  # Character to indicate the battery is discharging
        empty_char='x',           # Character to indicate the battery is empty
        fmt='{}',                 # How to format the text
        font='sans',              # Default font
        fontshadow=None,          # font shadow color, default is None(no shadow)
        fontsize=None,            # Font size. Calculated if None.
        foreground=fg,            # Foreground colour
        format=format,            # Display format
        full_char='=',            # Character to indicate the battery is full
        hide_threshold=None,      # Hide the text when there is enough energy 0 <= x < 1
        low_background=bg,        # Background color on low battery
        low_foreground='FF0000',  # Font color on low battery
        low_percentage=0.1,       # Indicates when to use the low_foreground color 0 < x < 1
        markup=True,              # Whether or not to use pango markup
        max_chars=0,              # Maximum number of characters to display in widget.
        mouse_callbacks={},       # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        notify_below=None,        # Send a notification below this battery level.
        padding=None,             # Padding. Calculated if None.
        show_short_text=True,     # Show "Full" or "Empty" rather than formated text
        unknown_char='?',         # Character to indicate the battery status is unknown
        update_interval=60,       # Seconds between status updates
    )


def _battery_icon(bg="#000000"):
    """
        class libqtile.widget.BatteryIcon(**config)[source]
        Battery life indicator widget.

        Supported bar orientations: horizontal only
    """
    return widget.BatteryIcon(
        background=bg,       # Widget background color
        battery=0,           # Which battery should be monitored
        mouse_callbacks={},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        update_interval=5,   # Seconds between status updates
        # theme_path='/home/docs/checkouts/readthedocs.org/user_builds/qtile/checkouts/stable/libqtile/resources/battery-icons',  # Path of the icons
    )


def _net(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Net(**config)[source]
        Displays interface down and up speed

        Widget requirements: psutil.

        Supported bar orientations: horizontal and vertical
    """
    return widget.Net(
        background=bg,                         # Widget background color
        fmt='{}',                              # How to format the text
        font='sans',                           # Default font
        fontshadow=None,                       # font shadow color, default is None(no shadow)
        fontsize=None,                         # Font size. Calculated if None.
        foreground=fg,                         # Foreground colour
        format='{interface}: {down}↓ {up}↑',   # Display format of down/upload/total speed of given interfaces
        interface="wlp2s0",                    # List of interfaces or single NIC as string to monitor, None to display all active NICs combined
        markup=True,                           # Whether or not to use pango markup
        max_chars=0,                           # Maximum number of characters to display in widget.
        mouse_callbacks={},                    # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                          # Padding. Calculated if None.
        prefix=None,                           # Use a specific prefix for the unit of the speed.
        update_interval=1,                     # The update interval.
        use_bits=False,                        # Use bits instead of bytes per second?
    )


def _quick_exit(bg="#000000", fg="#ffffff", font=wt.font, size=wt.size):
    """
        class libqtile.widget.QuickExit(widget=CALCULATED, **config)[source]
        A button of exiting the running qtile easily. When clicked this button,
        a countdown start. If the button pushed with in the countdown again,
        the qtile shutdown.

        Supported bar orientations: horizontal and vertical
    """
    return widget.QuickExit(
        background=bg,                      # Widget background color
        countdown_format='[ {} seconds ]',  # This text is showed when counting down.
        countdown_start=5,                  # Time to accept the second pushing.
        default_text='[ shutdown ]',        # A text displayed as a button
        fmt='{}',                           # How to format the text
        font=font,                          # Default font
        fontshadow=None,                    # font shadow color, default is None(no shadow)
        fontsize=size,                      # Font size. Calculated if None.
        foreground=fg,                      # Foreground colour
        markup=True,                        # Whether or not to use pango markup
        max_chars=0,                        # Maximum number of characters to display in widget.
        mouse_callbacks={},                 # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                       # Padding. Calculated if None.
        timer_interval=1,                   # A countdown interval.
    )


def _powerline_left_arrow(bg="#000000", fg="#ffffff"):
    return widget.TextBox(
        text='\uf0d9',  # '' character
        font="sans",
        background=bg,
        foreground=fg,
        padding=0,
        fontsize=37
    )


def _powerline_right_arrow(bg="#000000", fg="#ffffff"):
    return widget.TextBox(
        text='\uf0da',  # inverse '' character
        font="sans",
        background=bg,
        foreground=fg,
        padding=0,
        fontsize=37
    )


def _vertical_sep(bg="#000000", fg="#ffffff"):
    return widget.TextBox(
        text='|',
        font="sans",
        background=bg,
        foreground=fg,
        padding=2,
        fontsize=14
    )


def init_widgets_(terminal):
    widgets = [
        # _current_layout_icon(),
        _current_layout(fg=wt.white, bg=wt.grey),
        _vertical_sep(bg=wt.black),
        _current_screen(fg=wt.white, bg=wt.black),
        _vertical_sep(bg=wt.black),
        _group_box(fg=wt.white, bg=wt.black),
        _vertical_sep(bg=wt.black),
        _prompt(fg=wt.white, bg=wt.black),
        _vertical_sep(bg=wt.black),
        _window_name(fg=wt.white, bg=wt.black),
        _vertical_sep(bg=wt.black),

        _sep(fg=wt.white, bg=wt.black),
        # _image(bg=wt.black),
        # _thermal_sensor(fg=wt.white, bg=wt.black),
        _powerline_left_arrow(fg=wt.blue, bg=wt.black),
        _bluetooth(fg=wt.white, bg=wt.blue),
        _powerline_left_arrow(fg=wt.red, bg=wt.blue),
        _volume(fg=wt.white, bg=wt.red),
        _powerline_left_arrow(fg=wt.blue, bg=wt.red),
        _keyboard_layout(fg=wt.white, bg=wt.blue),
        _powerline_left_arrow(fg=wt.red, bg=wt.blue),
        _backlight(fg=wt.white, bg=wt.red),
        _powerline_left_arrow(fg=wt.blue, bg=wt.red),
        _memory(terminal=terminal, fg=wt.white, bg=wt.blue),
        _powerline_left_arrow(fg=wt.red, bg=wt.blue),
        _cpu(fg=wt.white, bg=wt.red),
        _powerline_left_arrow(fg=wt.black, bg=wt.red),
        _hdd(bg=wt.black),
        _powerline_left_arrow(fg=wt.blue, bg=wt.black),
        _wallpaper(fg=wt.white, bg=wt.blue),
        _powerline_left_arrow(fg=wt.red, bg=wt.blue),
        _check_updates(terminal=terminal, fg=wt.white, bg=wt.red),
        _powerline_left_arrow(fg=wt.blue, bg=wt.red),
        _chord(fg=wt.white, bg=wt.green),
        _powerline_left_arrow(fg=wt.red, bg=wt.blue),
        _net(fg=wt.white, bg=wt.red),
        _powerline_left_arrow(fg=wt.blue, bg=wt.red),
        _text_box(text="Press &lt;M-r&gt; to spawn", fg=wt.white, bg=wt.blue),
        _powerline_left_arrow(fg=wt.red, bg=wt.blue),
        _clock(format="%A, %B %d - %H:%M ", fg=wt.white, bg=wt.red),
        _powerline_left_arrow(fg=wt.blue, bg=wt.red),
        _battery_icon(bg=wt.blue),
        _battery(fg=wt.white, bg=wt.blue),
        _powerline_left_arrow(fg=wt.green, bg=wt.blue),
        _quick_exit(fg=wt.white, bg=wt.green),
    ]
    return widgets


def list_left_widgets():
    return [
        # _current_layout_icon(),
        [_current_layout, {"fg": wt.white, "bg": wt.grey}],
        [_current_screen, {"fg": wt.white, "bg": wt.black}],
        [_group_box,      {"fg": wt.white, "bg": wt.grey}],
        [_prompt,         {"fg": wt.white, "bg": wt.black}],
        [_window_name,    {"fg": wt.white, "bg": wt.grey}],
    ]


def list_right_widgets(terminal):
    return [
        [_chord,           {"bg": wt.blue,     "fg": wt.white}],
        [_systray,         {"bg": wt.purple}],
        [_net,             {"bg": wt.lila,     "fg": wt.black}],
        [_volume,          {"bg": wt.purple,   "fg": wt.black}],
        [_backlight,       {"bg": wt.blue,     "fg": wt.black}],
        [_check_updates,   {"bg": wt.cyan,     "fg": wt.black,  "terminal": terminal}],
        [_wallpaper,       {"bg": wt.green,    "fg": wt.black}],
        [_clock,           {"bg": wt.yellow,   "fg": wt.black,  "format": "%a, %m/%d/%y - %H:%M "}],
        [_battery_icon,    {"bg": wt.grey}],
        [_battery,         {"bg": wt.orange,   "fg": wt.black, "format": '{char} {percent:2.0%} {hour:d}:{min:02d}'}],
        [_quick_exit,      {"bg": wt.red,      "fg": wt.black}],
    ]


def _init_widgets(left, right):
    widgets = []
    bg = wt.black
    for func, kwargs in left[::-1]:
        _bg = kwargs["bg"]
        widgets.extend([_powerline_right_arrow(fg=_bg, bg=bg), func(**kwargs)])
        bg = _bg
    widgets = widgets[::-1]

    widgets.append(_sep(fg=wt.white, bg=wt.black))

    bg = wt.black
    for func, kwargs in right:
        _bg = kwargs["bg"]
        widgets.extend([_powerline_left_arrow(fg=_bg, bg=bg), func(**kwargs)])
        bg = _bg

    return widgets


def init_widgets_screen1(terminal):
    """
        Slicing removes unwanted widgets (systray) on Monitors 1,3
    """
    left = list_left_widgets()
    right = list_right_widgets(terminal)
    widgets = _init_widgets(left, right)
    return widgets


def init_widgets_screen2(terminal):
    """
        Monitor 2 will display all widgets in widgets_list
    """
    left = list_left_widgets()
    right = list_right_widgets(terminal)
    del right[5]
    del right[0:2]
    widgets = _init_widgets(left, right)
    return widgets
