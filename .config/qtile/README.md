# Qtile config written in Python.

The `config.py` script is first called by `qtile` on startup.  
Then the code runs and calls every other script to fully load
the config.

# Gallery
**COMING SOON**

# Install
see the [`qtile` doc](http://docs.qtile.org/en/stable/manual/install/index.html) and this [arch guide](https://www.youtube.com/watch?v=pouX5VvX0_Q):
```bash
sudo pacman -S base-devel <video driver> xorg xorg-xinit qtile
yay -S nerd-fonts-mononoki
sudo pacman -S python-gobject gtk3
sudo pacman -S python python-pip gdk
pip install psutil dbus-next iwlib
cp -r /path/to/dotfiles/.config/qtile ~/.config
```
<!-- https://pygobject.readthedocs.io/en/latest/getting_started.html#arch-getting-started -->

See this [**list**](https://wiki.archlinux.org/title/xorg#Driver_installation) to choose an appropriate video driver.

Some "*lazy*" dependencies, which can be installed automatically with the `install.sh` script:  
- dmenu_run
- passmenu
- nvim
- emacsclient
- tabbed
- killall
- xautolock,
- checkupdates
- pacman
- ncdu
- df
- htop
- cal
- nmcli
- bat
- conky
- discord,
- slack
- caprine
- signal-desktop
- thunderbird
- alsamixer
- python
- btop,
- htop
- dunstctl
- lazygit
- scripts
- blueman-manager
- chromium
- firefox,
- dmscripts
- emacs
- moc
- my scripts
- neovim

# A diagram of the whole project architecture.
```
      ┌─────────┐    ┌─────────┐    ┌────────┐
      │groups.py│◄───┤config.py├───►│mouse.py│
      └─────────┘    └┬───┬──┬─┘    └────────┘
                      │   │  │
         ┌────────────┘   │  └────────────────────┐
         ▼                ▼                       ▼
    ┌───────┐       ┌──────────┐             ┌──────────┐
 ┌─►│keys.py├────┐  │layouts.py│             │screens.py│
 │  └────┬──┘    │  └┬───────┬─┘             └────┬─────┘
 │       ▼       │   │       │                    │
 │┌─────────────┐│   │       │                    │
 ││extensions.py├┼───┼────┐  │                    │
 │└─────────────┘│   │    │  │        ┌──────┐    │
 │               │   │    │  │        │bar.py│◄───*
┌┴─────────┐     │   │    │  │        └┬──┬──┘    │
│widgets.py│◄────┼─*─┼────┼──┼──*──────┘  │       │
└────────┬─┘     │ │ │    │  │  │         │       │
         │       └─┼─┼────┼*─┼──┼──────┐  │       │
         │         │ │    ││ │  │      │  │       │
         │         ▼ ▼    ▼▼ ▼  ▼      ▼  ▼       │
         │   ┌────────┐  ┌────────┐  ┌────────┐   │
         │   │theme.py│◄─┤style.py├─►│utils.py│◄──*
         │   └────────┘  └────────┘  └────────┘   │
         │                 ▲    ▲                 │
         └─────────────────┘    └─────────────────┘
```
