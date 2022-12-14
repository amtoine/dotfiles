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

import os

from libqtile import bar
from libqtile import qtile
from libqtile import widget

from custom.battery import Battery
from custom.dunst import Dunst
from custom.entropy import Entropy
from custom.moc import MOC
from keys import DMNET
from style import FONT
from style import ARROW_SIZE


def init_widget_defaults() -> dict:
    """
        Gives the widget defaults.
    """
    return dict(
        font=FONT,
        fontsize=40,
        padding=3,
    )


def cst_dunst(fmt, bg="#000000", fg="#ffffff"):
    """
        A simple widget to display the state of the dunst notification server.

        Widget requirements: dunstctl from the dunst package
    """
    return Dunst(
        background=bg,       # Widget background color
        fmt="{} ",           # How to format the text
        font=FONT,           # Default font
        fontsize=None,       # Font size. Calculated if None.
        foreground=fg,       # Foreground colour
        format=fmt,          # How to format the text
        fontshadow=None,     # font shadow color, default is None(no shadow)
        markup=True,         # Whether or not to use pango markup
        max_chars=0,         # Maximum number of characters to display in widget.
        mouse_callbacks={},  # Dict of mouse button press callback functions. Accepts functions and ``lazy`` calls.
        padding=None,        # Padding. Calculated if None.
    )


def cst_entropy(bg="#000000", fg="#ffffff"):
    """
        A simple widget to display the entropy of the system.

        Widget requirements: subprocess
    """
    return Entropy(
        background=bg,             # Widget background color
        fmt="{}",                  # How to format the text
        font=FONT,                 # Default font
        fontsize=None,             # Font size. Calculated if None.
        foreground=fg,             # Foreground colour
        format=" {entropy:>4d}",  # How to format the text
        fontshadow=None,           # font shadow color, default is None(no shadow)
        markup=True,               # Whether or not to use pango markup
        max_chars=0,               # Maximum number of characters to display in widget.
        mouse_callbacks={},        # Dict of mouse button press callback functions. Accepts functions and ``lazy`` calls.
        padding=None,              # Padding. Calculated if None.
    )


def cst_moc(terminal, bg="#000000", fg="#ffffff"):
    """
        A simple widget to interact with the moc music player.

        Widget requirements: the moc music player, subprocess
    """
    return MOC(
        background=bg,          # Widget background color
        fmt="{}",               # How to format the text
        font=FONT,              # Default font
        fontsize=None,          # Font size. Calculated if None.
        foreground=fg,          # Foreground colour
        format="{state} {ct}",  # How to format the text
        fontshadow=None,        # font shadow color, default is None(no shadow)
        markup=True,            # Whether or not to use pango markup
        max_chars=10,           # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn("mocp -G"),
            'Button2': lambda: qtile.cmd_spawn(terminal + " mocp"),
            'Button3': lambda: qtile.cmd_spawn(terminal + " -d " + os.path.expanduser("~/music")),
            'Button4': lambda: qtile.cmd_spawn("mocp -f"),
            'Button5': lambda: qtile.cmd_spawn("mocp -r"),
            'Button6': lambda: qtile.cmd_spawn("mocp -k -10"),
            'Button7': lambda: qtile.cmd_spawn("mocp -k +10"),
        },                      # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,           # Padding. Calculated if None.
    )


def notify(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Notify(width=CALCULATED, **config)[source]
        A notify widget

        This widget can handle actions provided by notification clients.
        However, only the default action is supported, so if a client provides
        multiple actions then only the default (first) action can be invoked.
        Some programs will provide their own notification windows if the
        notification server does not support actions, so if you want your
        notifications to handle more than one action then specify False for the
        action option to disable all action handling. Unfortunately we cannot
        specify the capability for exactly one action.
        Supported bar orientations: horizontal and vertical
    """
    return widget.Notify(
        action=True,                 # Enable handling of default action upon right click
        audiofile=None,              # Audiofile played during notifications
        background=bg,               # Widget background color
        default_timeout=None,        # Default timeout (seconds) for notifications
        fmt='{}',                    # How to format the text
        font=FONT,                   # Default font
        fontshadow=None,             # font shadow color, default is None(no shadow)
        fontsize=None,               # Font size. Calculated if None.
        foreground=fg,               # Foreground colour
        foreground_low='dddddd',     # Foreground low priority colour
        foreground_urgent='ff0000',  # Foreground urgent priority colour
        markup=True,                 # Whether or not to use pango markup
        max_chars=0,                 # Maximum number of characters to display in widget.
        mouse_callbacks={},          # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                # Padding. Calculated if None.
        parse_text=None,             # Function to parse and modify notifications. e.g. function in config that removes line returns:def my_func(text) return text.replace('n', '')then set option parse_text=my_func
    )


def genpolltext(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.GenPollText(**config)[source]
        A generic text widget that polls using poll function to get the text
        Supported bar orientations: horizontal and vertical
    """
    return widget.GenPollText(
        background=bg,        # Widget background color
        fmt='{}',             # How to format the text
        font=FONT,            # Default font
        fontshadow=None,      # font shadow color, default is None(no shadow)
        fontsize=None,        # Font size. Calculated if None.
        foreground=fg,        # Foreground colour
        func=None,            # Poll Function
        markup=True,          # Whether or not to use pango markup
        max_chars=0,          # Maximum number of characters to display in widget.
        mouse_callbacks={},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,         # Padding. Calculated if None.
        update_interval=600,  # Update interval in seconds, if none, the widget updates whenever it's done.
    )


def genpollurl(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.GenPollUrl(**config)[source]
        A generic text widget that polls an url and parses it using parse
        function
        Supported bar orientations: horizontal and vertical
    """
    return widget.GenPollUrl(
        background=bg,        # Widget background color
        data=None,            # Post Data
        fmt='{}',             # How to format the text
        font=FONT,            # Default font
        fontshadow=None,      # font shadow color, default is None(no shadow)
        fontsize=None,        # Font size. Calculated if None.
        foreground=fg,        # Foreground colour
        headers={},           # Extra Headers
        json=True,            # Is Json?
        markup=True,          # Whether or not to use pango markup
        max_chars=0,          # Maximum number of characters to display in widget.
        mouse_callbacks={},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,         # Padding. Calculated if None.
        parse=None,           # Parse Function
        update_interval=600,  # Update interval in seconds, if none, the widget updates whenever it's done.
        url=None,             # Url
        user_agent='Qtile',   # Set the user agent
        xml=False,            # Is XML?
    )


def df(terminal, bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.DF(**config)[source]
        Disk Free Widget

        By default the widget only displays if the space is less than
        warn_space.

        Supported bar orientations: horizontal and vertical
    """
    return widget.DF(
        background=bg,             # Widget background color
        fmt='{}',                  # How to format the text
        font=FONT,                 # Default font
        fontshadow=None,           # font shadow color, default is None(no shadow)
        fontsize=None,             # Font size. Calculated if None.
        foreground=fg,             # Foreground colour
        format="  {p} {uf}{m}",    # String format (p: partition, s: size, f: free space, uf: user free space, m: measure, r: ratio (uf/s))
        markup=True,               # Whether or not to use pango markup
        max_chars=0,               # Maximum number of characters to display in widget.
        measure='G',               # Measurement (G, M, B)
        mouse_callbacks={
            "Button": lambda: qtile.cmd_spawn(terminal + " ncdu -x /"),
        },                         # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,              # Padding. Calculated if None.
        partition='/',             # the partition to check space
        update_interval=600,       # The update interval.
        visible_on_warn=False,     # Only display if warning
        warn_color='ff0000',       # Warning color
        warn_space=2,              # Warning space in scale defined by the measure option.
    )


def image(terminal, bg="#000000", filename=None):
    """
        class libqtile.widget.Image(length=CALCULATED, **config)[source]
        Display a PNG image on the bar
        Supported bar orientations: horizontal and vertical
    """
    return widget.Image(
        background=bg,      # Widget background color
        filename=filename,  # Image filename. Can contain '~'
        margin=3,           # Margin inside the box
        margin_x=None,      # X Margin. Overrides 'margin' if set
        margin_y=None,      # Y Margin. Overrides 'margin' if set
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal)
        },                  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        rotate=0.0,         # rotate the image in degrees counter-clockwise
        scale=True,         # Enable/Disable image scaling
    )


def thermal_sensor(bg="#000000", fg="#ffffff"):
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
        font=FONT,                  # Default font
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


def check_updates(terminal, bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CheckUpdates(**config)[source]
        Shows number of pending updates in different unix systems
        Supported bar orientations: horizontal and vertical
    """
    return widget.CheckUpdates(
        background=bg,                 # Widget background color
        colour_have_updates=fg,        # Colour when there are updates.
        colour_no_updates=fg,          # Colour when there's no updates.
        custom_command=None,           # Custom shell command for checking updates (counts the lines of the output)
        custom_command_modify=None,    # Lambda function to modify line count from custom_command
        display_format=' {updates}',  # Display format if updates available
        distro='Arch_checkupdates',    # Name of your distribution
        execute="",                    # Command to execute on click
        fmt='{}',                      # How to format the text
        font=FONT,                     # Default font
        fontshadow=None,               # font shadow color, default is None(no shadow)
        fontsize=None,                 # Font size. Calculated if None.
        foreground=fg,                 # Foreground colour
        markup=True,                   # Whether or not to use pango markup
        max_chars=0,                   # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal + " sudo pacman -Syu"),
            'Button2': lambda: qtile.cmd_spawn(terminal + " ncdu -x /"),
            'Button3': lambda: qtile.cmd_spawn(terminal + " --hold checkupdates"),
        },                             # dict of mouse button press callback functions. accepts functions and lazy calls.
        no_update_string=' ',         # String to display if no updates available
        padding=None,                  # Padding. Calculated if None.
        restart_indicator='',          # Indicator to represent reboot is required. (Ubuntu only)
        update_interval=3600,          # Update interval in seconds.
    )


def memory(terminal, bg="#000000", fg="#ffffff"):
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
        background=bg,                   # Widget background color
        fmt='{}',                        # How to format the text
        font=FONT,                       # Default font
        fontshadow=None,                 # font shadow color, default is None(no shadow)
        fontsize=None,                   # Font size. Calculated if None.
        foreground=fg,                   # Foreground colour
        format=' {MemPercent:02.0f}%',  # Formatting for field names.
        markup=True,                     # Whether or not to use pango markup
        max_chars=0,                     # Maximum number of characters to display in widget.
        measure_mem='M',                 # Measurement for Memory (G, M, K, B)
        measure_swap='M',                # Measurement for Swap (G, M, K, B)
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal + ' htop')
        },                               # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                    # Padding. Calculated if None.
        update_interval=1.0,             # Update interval for the Memory
    )


def volume(terminal, bg="#000000", fg="#ffffff"):
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
        fmt=' {:>3s}',            # How to format the text
        font=FONT,                 # Default font
        fontshadow=None,           # font shadow color, default is None(no shadow)
        fontsize=None,             # Font size. Calculated if None.
        foreground=fg,             # Foreground colour
        get_volume_command=None,   # Command to get the current volume
        markup=True,               # Whether or not to use pango markup
        max_chars=0,               # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button2': lambda: qtile.cmd_spawn(terminal + "alsamixer")
        },                                 # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        mute_command=None,         # Mute command
        padding=3,                 # Padding left and right. Calculated if None.
        step=2,                    # Volume change for up an down commands in percentage.Only used if volume_up_command and volume_down_command are not set.
        theme_path=None,           # Path of the icons
        update_interval=0.2,       # Update time in seconds.
        volume_app=None,           # App to control volume
        volume_down_command=None,  # Volume down command
        volume_up_command=None,    # Volume up command
    )


def keyboard_layout(bg="#000000", fg="#ffffff"):
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
        font=FONT,                    # Default font
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


def backlight(bg="#000000", fg="#ffffff"):
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
        backlight_name='intel_backlight',      # ACPI name of a backlight device
        brightness_file='brightness',          # Name of file with the current brightness in /sys/class/backlight/backlight_name
        change_command='xbacklight -set {0}',  # Execute command to change value
        fmt='{}',                              # How to format the text
        font=FONT,                             # Default font
        fontshadow=None,                       # font shadow color, default is None(no shadow)
        fontsize=None,                         # Font size. Calculated if None.
        foreground=fg,                         # Foreground colour
        format='B{percent:2.0%}',              # Display format
        markup=True,                           # Whether or not to use pango markup
        max_brightness_file='max_brightness',  # Name of file with the maximum brightness in /sys/class/backlight/backlight_name
        max_chars=0,                           # Maximum number of characters to display in widget.
        mouse_callbacks={},                    # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                          # Padding. Calculated if None.
        step=10,                               # Percent of backlight every scroll changed
        update_interval=0.2,                   # The delay in seconds between updates
    )


def bluetooth(bg="#000000", fg="#ffffff"):
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
        font=FONT,                     # Default font
        fontshadow=None,               # font shadow color, default is None(no shadow)
        fontsize=None,                 # Font size. Calculated if None.
        foreground=fg,                 # Foreground colour
        hci='/dev_XX_XX_XX_XX_XX_XX',  # hci0 device path, can be found with d-feet or similar dbus explorer.
        markup=True,                   # Whether or not to use pango markup
        max_chars=0,                   # Maximum number of characters to display in widget.
        mouse_callbacks={},            # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                  # Padding. Calculated if None.
    )


def cst_bluetooth(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Bluetooth(**config)[source]
        Displays bluetooth status or connected device.
        Uses dbus to communicate with the system bus.
        Widget requirements: dbus-next.
        Supported bar orientations: horizontal and vertical
    """
    return widget.TextBox(
        "",
        background=bg,          # Widget background color
        fmt='{}',               # How to format the text
        font=FONT,              # Text font
        fontshadow=None,        # font shadow color, default is None(no shadow)
        fontsize=None,          # Font pixel size. Calculated if None.
        foreground=fg,          # Foreground colour.
        markup=True,            # Whether or not to use pango markup
        max_chars=0,            # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn("rofi-bluetooth"),
            'Button3': lambda: qtile.cmd_spawn("blueman-manager"),
        },                                 # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,           # Padding left and right. Calculated if None.
    )


def cpu(terminal, bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CPU(**config)[source]
        A simple widget to display CPU load and frequency.
        Widget requirements: psutil.
        Supported bar orientations: horizontal and vertical
    """
    return widget.CPU(
        background=bg,                     # Widget background color
        fmt='{}',                          # How to format the text
        font=FONT,                         # Default font
        fontshadow=None,                   # font shadow color, default is None(no shadow)
        fontsize=None,                     # Font size. Calculated if None.
        foreground=fg,                     # Foreground colour
        format=' {load_percent:>4.1f}%',  # CPU display format
        markup=True,                       # Whether or not to use pango markup
        max_chars=0,                       # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal + ' htop')
        },                                 # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                      # Padding. Calculated if None.
        update_interval=1.0,               # Update interval for the CPU widget
    )


def current_screen(bg="#000000", fg="#ffffff", active="66ff66", inactive="#ff6666"):
    """
        class libqtile.widget.CurrentScreen(width=CALCULATED, **config)[source]
        Indicates whether the screen this widget is on is currently active or
        not
        Supported bar orientations: horizontal and vertical
    """
    return widget.CurrentScreen(
        active_color=active,      # Color when screen is active
        active_text='',          # Text displayed when the screen is active
        background=bg,            # Widget background color
        fmt='{}',                 # How to format the text
        font=FONT,                # Default font
        fontshadow=None,          # font shadow color, default is None(no shadow)
        fontsize=None,            # Font size. Calculated if None.
        foreground=fg,            # Foreground colour
        inactive_color=inactive,  # Color when screen is inactive
        inactive_text='',        # Text displayed when the screen is inactive
        markup=True,              # Whether or not to use pango markup
        max_chars=0,              # Maximum number of characters to display in widget.
        mouse_callbacks={},       # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,             # Padding. Calculated if None.
    )


def hdd(bg="#000000"):
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
        line_width=1,           # Line width
        margin_x=0,             # Margin X
        margin_y=0,             # Margin Y
        mouse_callbacks={},     # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        path='/',               # Partition mount point.
        samples=100,            # Count of graph samples.
        space_type='used',      # free/used
        start_pos='bottom',     # Drawer starting position ('bottom'/'top')
        type='box',             # 'box', 'line', 'linefill'
    )


def wallpaper(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Wallpaper(**config)[source]
        Supported bar orientations: horizontal and vertical
    """
    return widget.Wallpaper(
        background=bg,                               # Widget background color
        directory='~/ghq/github.com/amtoine/wallpapers/wallpapers/',  # Wallpaper Directory
        fmt='{}',                                    # How to format the text
        font=FONT,                                   # Default font
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


def current_layout(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.CurrentLayout(width=CALCULATED, **config)[source]
        Display the name of the current layout of the current group of the
        screen, the bar containing the widget, is on.

        Supported bar orientations: horizontal and vertical
    """
    return widget.CurrentLayout(
        background=bg,        # Widget background color
        fmt=' {}',             # How to format the text
        font=FONT,            # Default font
        fontshadow=None,      # font shadow color, default is None(no shadow)
        fontsize=None,        # Font size. Calculated if None.
        foreground=fg,        # Foreground colour
        markup=True,          # Whether or not to use pango markup
        max_chars=0,          # Maximum number of characters to display in widget.
        mouse_callbacks={},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,         # Padding. Calculated if None.
    )


def current_layout_icon(bg="#000000", fg="#ffffff"):
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
        font=FONT,             # Default font
        fontshadow=None,       # font shadow color, default is None(no shadow)
        fontsize=None,         # Font size. Calculated if None.
        foreground=fg,         # Foreground colour
        markup=True,           # Whether or not to use pango markup
        max_chars=0,           # Maximum number of characters to display in widget.
        mouse_callbacks={},    # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,          # Padding. Calculated if None.
        scale=1,               # Scale factor relative to the bar height. Defaults to 1
    )


def group_box(
    fontsize,
    bg="#000000", fg="#ffffff",
    active="#ff0000", select="#00ff00", line=['000000', '2828ff'],
    inactive="4040ff", other_focus="404040",
    other_unfocus="404040", this_focus="215578",
    this_unfocus="215578", urgent_border="FF0000", urgent_text="FF0000"
):
    """
        class libqtile.widget.GroupBox(**config)[source]
        A widget that graphically displays the current group. All groups are
        displayed by their label. If the label of a group is the empty string
        that group will not be displayed.

        Supported bar orientations: horizontal only
    """
    return widget.GroupBox(
        active=active,                            # Active group font colour
        background=bg,                            # Widget background color
        block_highlight_text_color=select,        # Selected group font colour
        borderwidth=2,                            # Current group border width
        center_aligned=True,                      # center-aligned group box
        disable_drag=True,                        # Disable dragging and dropping of group names on widget
        fmt='{}',                                 # How to format the text
        font=FONT,                                # Default font
        fontshadow=None,                          # font shadow color, default is None(no shadow)
        fontsize=fontsize,                        # Font size. Calculated if None.
        foreground=fg,                            # Foreground colour
        hide_unused=False,                        # Hide groups that have no windows and that are not displayed on any screen.
        highlight_color=line,                     # Active group highlight color when using 'line' highlight method.
        highlight_method="block",                 # Method of highlighting ('border', 'block', 'text', or 'line')Uses *_border color settings
        inactive=inactive,                        # Inactive group font colour
        invert_mouse_wheel=False,                 # Whether to invert mouse wheel group movement
        margin=3,                                 # Margin inside the box
        margin_x=None,                            # X Margin. Overrides 'margin' if set
        margin_y=None,                            # Y Margin. Overrides 'margin' if set
        markup=True,                              # Whether or not to use pango markup
        max_chars=0,                              # Maximum number of characters to display in widget.
        mouse_callbacks={},                       # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        other_current_screen_border=other_focus,  # Border or line colour for group on other screen when focused.
        other_screen_border=other_unfocus,        # Border or line colour for group on other screen when unfocused.
        # padding=None,                             # Padding. Calculated if None.
        # padding_x=None,                           # X Padding. Overrides 'padding' if set
        # padding_y=None,                           # Y Padding. Overrides 'padding' if set
        rounded=True,                             # To round or not to round box borders
        spacing=None,                             # Spacing between groups(if set to None, will be equal to margin_x)
        this_current_screen_border=this_focus,    # Border or line colour for group on this screen when focused.
        this_screen_border=this_unfocus,          # Border or line colour for group on this screen when unfocused.
        urgent_alert_method="border",             # Method for alerting you of WM urgent hints (one of 'border', 'text', 'block', or 'line')
        urgent_border=urgent_border,              # Urgent border or line color
        urgent_text=urgent_text,                  # Urgent group font color
        use_mouse_wheel=False,                    # Whether to use mouse wheel events
        visible_groups=None,                      # Groups that will be visible. If set to None or [], all groups will be visible.Visible groups are identified by name not by their displayed label.
    )


def prompt(bg="#000000", fg="#ffffff"):
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
        font=FONT,                   # Default font
        fontshadow=None,             # font shadow color, default is None(no shadow)
        fontsize=None,               # Font size. Calculated if None.
        foreground=fg,               # Foreground colour
        ignore_dups_history=True,    # Don't store duplicates in history
        markup=True,                 # Whether or not to use pango markup
        max_chars=0,                 # Maximum number of characters to display in widget.
        max_history=100,             # Commands to keep in history. 0 for no limit.
        mouse_callbacks={},          # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,                # Padding. Calculated if None.
        prompt=' : ',               # Text displayed at the prompt. Default: '{prompt}: '
        record_history=True,         # Keep a record of executed commands
        visual_bell_color='ff0000',  # Color for the visual bell (changes prompt background).
        visual_bell_time=0.2,        # Visual bell duration (in seconds).
    )


def window_name(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.WindowName(width=STRETCH, **config)[source]
        Displays the name of the window that currently has focus

        Supported bar orientations: horizontal and vertical
    """
    return widget.WindowName(
        background=bg,              # Widget background color
        empty_group_string='',     # string to display when no windows are focused on current group
        fmt='{}',                   # How to format the text
        font=FONT,                  # Default font
        fontshadow=None,            # font shadow color, default is None(no shadow)
        fontsize=None,              # Font size. Calculated if None.
        for_current_screen=False,   # instead of this bars screen use currently active screen
        foreground=fg,              # Foreground colour
        format='  {state}{name}',  # format of the text
        markup=True,                # Whether or not to use pango markup
        max_chars=0,                # Maximum number of characters to display in widget.
        mouse_callbacks={},         # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,               # Padding. Calculated if None.
        parse_text=None,            # Function to parse and modify window names. e.g. function in config that removes excess strings from window name: def my_func(text) for string in [" - Chromium", " - Firefox"]: text=text.replace(string, "") return textthen set option parse_text=my_func
    )


def chord(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Chord(width=CALCULATED, **config)[source]
        Display current key chord

        Supported bar orientations: horizontal and vertical
    """
    return widget.Chord(
        background=bg,                                     # Widget background color
        chords_colors={'launch': ("#ff0000", "#ffffff")},  # colors per chord in form of tuple ('bg', 'fg').
        fmt='{}',                                          # How to format the text
        font=FONT,                                         # Default font
        fontshadow=None,                                   # font shadow color, default is None(no shadow)
        fontsize=None,                                     # Font size. Calculated if None.
        foreground=fg,                                     # Foreground colour
        markup=True,                                       # Whether or not to use pango markup
        max_chars=0,                                       # Maximum number of characters to display in widget.
        mouse_callbacks={},                                # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        name_transform=lambda name: name.upper(),          # preprocessor for chord name it is pure function string -> string
        padding=None,                                      # Padding. Calculated if None.
    )


def text_box(text='', bg="#000000", fg="#ffffff"):
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
        font=FONT,              # Text font
        fontshadow=None,        # font shadow color, default is None(no shadow)
        fontsize=None,          # Font pixel size. Calculated if None.
        foreground=fg,          # Foreground colour.
        markup=True,            # Whether or not to use pango markup
        max_chars=0,            # Maximum number of characters to display in widget.
        mouse_callbacks={},     # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,           # Padding left and right. Calculated if None.
    )


def systray(bg="#000000"):
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


def clock(terminal, format='%H:%M', bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Clock(**config)[source]
        A simple but flexible text-based clock

        Supported bar orientations: horizontal and vertical
    """
    return widget.Clock(
        background=bg,        # Widget background color
        fmt='{}',             # How to format the text
        font=FONT,            # Default font
        fontshadow=None,      # font shadow color, default is None(no shadow)
        fontsize=None,        # Font size. Calculated if None.
        foreground=fg,        # Foreground colour
        format=format,        # A Python datetime format string
        markup=True,          # Whether or not to use pango markup
        max_chars=0,          # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal + " --hold cal -Y"),
        },                    # dict of mouse button press callback functions. accepts functions and lazy calls.
        padding=None,         # Padding. Calculated if None.
        timezone=None,        # The timezone to use for this clock, either as string if pytz or dateutil is installed (e.g. "US/Central" or anything in /usr/share/zoneinfo), or as tzinfo (e.g. datetime.timezone.utc). None means the system local timezone and is the default.
        update_interval=1.0,  # Update interval for the clock
    )


def battery(format, bg="#000000", fg="#ffffff", low=.15, high=.85):
    """
        class libqtile.widget.Battery(**config)[source]
        A text-based battery monitoring widget currently supporting FreeBSD

        Supported bar orientations: horizontal and vertical
    """
    return Battery(
        background=bg,              # Widget background color
        battery=0,                  # Which battery should be monitored (battery number or name)
        charge_char='',            # Character to indicate the battery is charging
        discharge_char='',         # Character to indicate the battery is discharging
        empty_char='',             # Character to indicate the battery is empty
        fmt='{}',                   # How to format the text
        font=FONT,                  # Default font
        fontshadow=None,            # font shadow color, default is None(no shadow)
        fontsize=None,              # Font size. Calculated if None.
        foreground=fg,              # Foreground colour
        format=format,              # Display format
        full_char='',              # Character to indicate the battery is full
        full_not_charging=True,
        hide_threshold=None,        # Hide the text when there is enough energy 0 <= x < 1
        high_background=None,       # Background color on high battery
        high_foreground="#ffff00",  # Font color on high battery
        high_percentage=high,       # Indicates when to use the high_foreground color 0 < l < x < 1
        low_background=None,        # Background color on low battery
        low_foreground="#ff0000",   # Font color on low battery
        low_percentage=low,         # Indicates when to use the low_foreground color 0 < x < h < 1
        notification_timeout=0,     # Time in seconds to display notification. 0 for no expiry.
        markup=True,                # Whether or not to use pango markup
        max_chars=0,                # Maximum number of characters to display in widget.
        mouse_callbacks={},         # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        notify_below=low*100,       # Send a notification below this battery level.
        notify_above=high*100,      # Send a notification above this battery level.
        padding=None,               # Padding. Calculated if None.
        show_short_text=False,      # Show "Full" or "Empty" rather than formated text
        unknown_char='?',           # Character to indicate the battery status is unknown
        update_interval=10,         # Seconds between status updates
    )


def battery_icon(bg="#000000"):
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


def net(bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Net(**config)[source]
        Displays interface down and up speed

        Widget requirements: psutil.

        Supported bar orientations: horizontal and vertical
    """
    return widget.Net(
        background=bg,       # Widget background color
        fmt='{}',            # How to format the text
        font=FONT,           # Default font
        fontshadow=None,     # font shadow color, default is None(no shadow)
        fontsize=None,       # Font size. Calculated if None.
        foreground=fg,       # Foreground colour
        format=' {down}',   # Display format of down/upload/total speed of given interfaces
        interface="wlp2s0",  # List of interfaces or single NIC as string to monitor, None to display all active NICs combined
        markup=True,         # Whether or not to use pango markup
        max_chars=0,         # Maximum number of characters to display in widget.
        mouse_callbacks={},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=None,        # Padding. Calculated if None.
        prefix=None,         # Use a specific prefix for the unit of the speed.
        update_interval=1,   # The update interval.
        use_bits=False,      # Use bits instead of bytes per second?
    )


def quick_exit(bg="#000000", fg="#ffffff", countdown="[ {} seconds ]", text="[ shutdown ]"):
    """
        class libqtile.widget.QuickExit(widget=CALCULATED, **config)[source]
        A button of exiting the running qtile easily. When clicked this button,
        a countdown start. If the button pushed with in the countdown again,
        the qtile shutdown.

        Supported bar orientations: horizontal and vertical
    """
    return widget.QuickExit(
        background=bg,               # Widget background color
        countdown_format=countdown,  # This text is showed when counting down.
        countdown_start=5,           # Time to accept the second pushing.
        default_text=text,           # A text displayed as a button
        fmt='{}',                    # How to format the text
        font=FONT,                   # Default font
        fontshadow=None,             # font shadow color, default is None(no shadow)
        fontsize=None,               # Font size. Calculated if None.
        foreground=fg,               # Foreground colour
        markup=True,                 # Whether or not to use pango markup
        max_chars=0,                 # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button2': lambda: qtile.cmd_reload_config(),
            'Button3': lambda: qtile.restart(),
        },                           # dict of mouse button press callback functions. accepts functions and lazy calls.
        padding=None,                # Padding. Calculated if None.
        timer_interval=1,            # A countdown interval.
    )


def wlan(terminal, co_fmt=' {essid} {quality:02d}/70', dis_fmt="睊 --/--", bg="#000000", fg="#ffffff"):
    """
        class libqtile.widget.Wlan(**config)[source]
        Displays Wifi SSID and quality.

        Widget requirements: iwlib.

        Supported bar orientations: horizontal only
    """
    return widget.Wlan(
        background=bg,                 # Widget background color
        disconnected_message=dis_fmt,  # String to show when the wlan is diconnected.
        fmt='{}',                      # How to format the text
        font=FONT,                     # Default font
        fontshadow=None,               # font shadow color, default is None(no shadow)
        fontsize=None,                 # Font size. Calculated if None.
        foreground=fg,                 # Foreground colour
        format=co_fmt,                 # Display format. For percents you can use "{essid} {percent:2.0%}" or "{essid} {quality:02d}/70"
        interface='wlp2s0',            # The interface to monitor
        markup=True,                   # Whether or not to use pango markup
        max_chars=0,                   # Maximum number of characters to display in widget.
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(DMNET),
            'Button3': lambda: qtile.cmd_spawn("nm-connection-editor"),
        },                             # dict of mouse button press callback functions. accepts functions and lazy calls.
        padding=None,                  # Padding. Calculated if None.
        update_interval=1,             # The update interval.
    )


def left_arrow_sep(bg="#000000", fg="#ffffff"):
    """
        TODO
    """
    return widget.TextBox(
        text='\uf0d9',  # '' character
        font="Ubuntu Mono",
        background=bg,
        foreground=fg,
        padding=0,
        fontsize=ARROW_SIZE,
    )


def right_arrow_sep(bg="#000000", fg="#ffffff"):
    """
        TODO
    """
    return widget.TextBox(
        text='',
        font="Ubuntu Mono",
        background=bg,
        foreground=fg,
        padding=0,
        fontsize=ARROW_SIZE,
    )


def vertical_sep(bg="#000000", fg="#ffffff", width=10, size=20):
    """
        class libqtile.widget.Sep(**config)[source]
        A visible widget separator

        Supported bar orientations: horizontal and vertical
    """
    return widget.Sep(
        background=bg,        # Widget background color
        foreground=fg,        # Separator line colour.
        linewidth=width,      # Width of separator line.
        mouse_callbacks={},   # Dict of mouse button press callback functions. Accepts functions and lazy calls.
        padding=2,            # Padding on either side of separator.
        size_percent=size,    # Size as a percentage of bar size (0-100).
    )


def slash_sep(bg="#000000", fg="#ffffff"):
    return widget.TextBox(
        text='',
        foreground=fg,
        background=bg,
        padding=0,
        font=FONT,
        fontsize=int(ARROW_SIZE * 1.15),
    )


def spacer(bg="#000000", length=bar.STRETCH):
    """
        class libqtile.widget.Spacer(length=STRETCH, **config)[source]
        Just an empty space on the bar

        Often used with length equal to bar.STRETCH to push bar widgets to the
        right or bottom edge of the screen.

        Parameters
        length :
        Length of the widget. Can be either bar.STRETCH or a length in pixels.

        width :
        DEPRECATED, same as length.

        Supported bar orientations: horizontal and vertical
    """
    return widget.Spacer(
        background=bg,       # Widget background color
        length=length,       # Length of the widget. Can be either bar.STRETCH or a length in pixels.
        mouse_callbacks={},  # Dict of mouse button press callback functions. Accepts functions and lazy calls.
    )
