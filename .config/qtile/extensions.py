# a collection of the built-in extensions of qtile
# with all their arguments inside useable wrappers.

from libqtile import extension

from style import DMFONT


def command_set(commands=None, pre_commands=None):
    """
        class libqtile.extension.CommandSet(**config)[source]
        Give list of commands to be executed in dmenu style.

        ex. manage mocp deamon:

        Key([mod], 'm', lazy.run_extension(extension.CommandSet(
            commands={
                'play/pause': '[ $(mocp -i | wc -l) -lt 2 ] && mocp -p || mocp -G',
                'next': 'mocp -f',
                'previous': 'mocp -r',
                'quit': 'mocp -x',
                'open': 'urxvt -e mocp',
                'shuffle': 'mocp -t shuffle',
                'repeat': 'mocp -t repeat',
                },
            pre_commands=['[ $(mocp -i | wc -l) -lt 1 ] && mocp -S'],
            **Theme.dmenu))),
    """
    return extension.CommandSet(
        background=None,            # defines the normal background color (#RGB or #RRGGBB)
        command=None,               # the command to be launched (string or list with arguments)
        commands=commands,          # dictionary of commands where key is runable command
        dmenu_bottom=False,         # dmenu appears at the bottom of the screen
        dmenu_command='dmenu',      # the dmenu command to be launched
        dmenu_font=DMFONT,          # override the default 'font' and 'fontsize' options for dmenu
        dmenu_height=None,          # defines the height (only supported by some dmenu forks)
        dmenu_ignorecase=False,     # dmenu matches menu items case insensitively
        dmenu_lines=10,             # dmenu lists items vertically, with the given number of lines
        dmenu_prompt="dmenu",       # defines the prompt to be displayed to the left of the input field
        font=DMFONT,                # defines the font name to be used
        fontsize=None,              # defines the font size to be used
        foreground=None,            # defines the normal foreground color (#RGB or #RRGGBB)
        pre_commands=pre_commands,  # list of commands to be executed before getting dmenu answer
        selected_background=None,   # defines the selected background color (#RGB or #RRGGBB)
        selected_foreground=None,   # defines the selected foreground color (#RGB or #RRGGBB)
    )


def dmenu():
    """
        class libqtile.extension.Dmenu(**config)[source]
        Python wrapper for dmenu http://tools.suckless.org/dmenu/
    """
    return extension.Dmenu(
        background=None,           # defines the normal background color (#RGB or #RRGGBB)
        command=None,              # the command to be launched (string or list with arguments)
        dmenu_bottom=False,        # dmenu appears at the bottom of the screen
        dmenu_command='dmenu',     # the dmenu command to be launched
        dmenu_font=None,           # override the default 'font' and 'fontsize' options for dmenu
        dmenu_height=None,         # defines the height (only supported by some dmenu forks)
        dmenu_ignorecase=False,    # dmenu matches menu items case insensitively
        dmenu_lines=None,          # dmenu lists items vertically, with the given number of lines
        dmenu_prompt=None,         # defines the prompt to be displayed to the left of the input field
        font='sans',               # defines the font name to be used
        fontsize=None,             # defines the font size to be used
        foreground=None,           # defines the normal foreground color (#RGB or #RRGGBB)
        selected_background=None,  # defines the selected background color (#RGB or #RRGGBB)
        selected_foreground=None,  # defines the selected foreground color (#RGB or #RRGGBB)
    )


def dmenu_run():
    """
        class libqtile.extension.DmenuRun(**config)[source]
        Special case to run applications.

        config.py should have something like:

        from libqtile import extension
        keys=[
            Key(['mod4'], 'r', lazy.run_extension(extension.DmenuRun(
                dmenu_prompt=">",
                dmenu_font="Andika-8",
                background="#15181a",
                foreground="#00ff00",
                selected_background="#079822",
                selected_foreground="#fff",
                dmenu_height=24,  # Only supported by some dmenu forks
            ))),
        ]
    """
    return extension.DmenuRun(
        background=None,            # defines the normal background color (#RGB or #RRGGBB)
        command=None,               # the command to be launched (string or list with arguments)
        dmenu_bottom=False,         # dmenu appears at the bottom of the screen
        dmenu_command='dmenu_run',  # the dmenu command to be launched
        dmenu_font=None,            # override the default 'font' and 'fontsize' options for dmenu
        dmenu_height=None,          # defines the height (only supported by some dmenu forks)
        dmenu_ignorecase=False,     # dmenu matches menu items case insensitively
        dmenu_lines=None,           # dmenu lists items vertically, with the given number of lines
        dmenu_prompt=None,          # defines the prompt to be displayed to the left of the input field
        font='sans',                # defines the font name to be used
        fontsize=None,              # defines the font size to be used
        foreground=None,            # defines the normal foreground color (#RGB or #RRGGBB)
        selected_background=None,   # defines the selected background color (#RGB or #RRGGBB)
        selected_foreground=None,   # defines the selected foreground color (#RGB or #RRGGBB)
    )


def j4_dmenu_desktop():
    """
        class libqtile.extension.J4DmenuDesktop(**config)[source]
        Python wrapper for j4-dmenu-desktop https://github.com/enkore/j4-dmenu-desktop
    """
    return extension.J4DmenuDesktop(
        background=None,                     # defines the normal background color (#RGB or #RRGGBB)
        command=None,                        # the command to be launched (string or list with arguments)
        dmenu_bottom=False,                  # dmenu appears at the bottom of the screen
        dmenu_command='dmenu',               # the dmenu command to be launched
        dmenu_font=None,                     # override the default 'font' and 'fontsize' options for dmenu
        dmenu_height=None,                   # defines the height (only supported by some dmenu forks)
        dmenu_ignorecase=False,              # dmenu matches menu items case insensitively
        dmenu_lines=None,                    # dmenu lists items vertically, with the given number of lines
        dmenu_prompt=None,                   # defines the prompt to be displayed to the left of the input field
        font='sans',                         # defines the font name to be used
        fontsize=None,                       # defines the font size to be used
        foreground=None,                     # defines the normal foreground color (#RGB or #RRGGBB)
        j4dmenu_command='j4-dmenu-desktop',  # the dmenu command to be launched
        j4dmenu_display_binary=False,        # display binary name after each entry
        j4dmenu_generic=True,                # include the generic name of desktop entries
        j4dmenu_terminal=None,               # terminal emulator used to start terminal apps
        j4dmenu_usage_log=None,              # file used to sort items by usage frequency
        j4dmenu_use_xdg_de=False,            # read $XDG_CURRENT_DESKTOP to determine the desktop environment
        selected_background=None,            # defines the selected background color (#RGB or #RRGGBB)
        selected_foreground=None,            # defines the selected foreground color (#RGB or #RRGGBB)
    )


def run_command():
    """
        class libqtile.extension.RunCommand(**config)[source]
        Run an arbitrary command.

        Mostly useful as a superclass for more specific extensions that need to interact with the qtile object.

        Also consider simply using lazy.spawn() or writing a client.
    """
    return extension.RunCommand(
        background=None,           # defines the normal background color (#RGB or #RRGGBB)
        command=None,              # the command to be launched (string or list with arguments)
        font='sans',               # defines the font name to be used
        fontsize=None,             # defines the font size to be used
        foreground=None,           # defines the normal foreground color (#RGB or #RRGGBB)
        selected_background=None,  # defines the selected background color (#RGB or #RRGGBB)
        selected_foreground=None,  # defines the selected foreground color (#RGB or #RRGGBB)
    )


def window_list():
    """
        class libqtile.extension.WindowList(**config)[source]
        Give vertical list of all open windows in dmenu. Switch to selected.
    """
    return extension.WindowList(
        all_groups=True,                  # If True, list windows from all groups; otherwise only from the current group
        background=None,                  # defines the normal background color (#RGB or #RRGGBB)
        command=None,                     # the command to be launched (string or list with arguments)
        dmenu_bottom=False,               # dmenu appears at the bottom of the screen
        dmenu_command='dmenu -c -bw 5',   # the dmenu command to be launched
        dmenu_font=DMFONT,                # override the default 'font' and 'fontsize' options for dmenu
        dmenu_height=None,                # defines the height (only supported by some dmenu forks)
        dmenu_ignorecase=True,            # dmenu matches menu items case insensitively
        dmenu_lines='80',                 # Give lines vertically. Set to None get inline
        dmenu_prompt="Windows:",          # defines the prompt to be displayed to the left of the input field
        font=DMFONT,                      # defines the font name to be used
        fontsize=None,                    # defines the font size to be used
        foreground=None,                  # defines the normal foreground color (#RGB or #RRGGBB)
        item_format='{group}: {window}',  # the format for the menu items
        selected_background=None,         # defines the selected background color (#RGB or #RRGGBB)
        selected_foreground=None,         # defines the selected foreground color (#RGB or #RRGGBB)
    )
