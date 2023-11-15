# This is my personal config repository for archlinux.
The following document gives a high level overview of my linux config.  
This particular config has been tested on ArchLinux only (last update on 22-02-20).  
Thus, only `pacman` and `yay` have been used and tested as arch and AUR package managers respectively.  
The reader is highly adviced to search the internet and in particular the [ArchWiki][archlinux], **EVEN in NON arch-based systems!!**

First, an overview of the repo is given in [section 1](#1-overview-and-architecture-toc).  
The software I use and a link to the official doc are presented and linked in [section 2](#2-the-software-i-use-toc).  
In [section 3](#3-the-install-process-toc), the automatic install script is presented.  
Finally, ways to contribute to this project are put forward in [section 4](#4-contribute-toc) for who is interested and a gallery of photos is presented in [section 5](#5-gallery-toc), 
to give an idea of the final rendering of the config.  

If you want a quick brief of what dotfiles really are, I recommend [this video][fireship-dotfiles] of *FireShip*.

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## Table Of Content.
- **1**     [**Overview and architecture.**](#1-overview-and-architecture-toc)
- **2**     [**The software I use.**](#2-the-software-i-use-toc) (**coming soon**)
- **3**     [**The install process**](#3-the-install-process-toc)
- **4**     [**Contribute.**](#4-contribute-toc)
- **5**     [**Gallery.**](#5-gallery-toc) (**coming soon**)

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 1. Overview and architecture. [[toc](#table-of-content)]
This repo has been created using a `bare` repository, i.e. initialization has been done with `git init --bare $HOME/.dotfiles` instead of the
usual `git init`.  This command creates a *bare* repository, meaning that there is no working directory inside it, only `.git` files.
This is normal as *bare* repositories are not meant to host working files, but only track files inside the working directory.  
This makes the process of tracking *dotfiles* much easier! There is no need anymore to copy files into the *dotfiles* repository, track them
and put them back where they should be using symlinks! A simple `alias` of the form `cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
is enough to use `git` on any file inside `$HOME`.

Hence, the architecture of the files above is a perfect mirror, regarding tracked files only, of my system!  

Notes:
- simply replace $HOME with whatever your personal space is called. One can issue `echo $HOME` in a terminal to check this.

If you want more information about *bare* `git` repositories, you can check one of the following resources:
- a [blog post][bare-repo-blog] about *bare* repositories.
- a [video from distrotube][bare-repo-dt] if you want to see the creation of such a repository step by step.

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 2. The software I use. [[toc](#table-of-content)]
**COMING SOON**

> **Note**  
> - the `surf` config has been moved [here](https://github.com/goatfiles-suckless/surf/tree/surf-webkit2/config)
> - the `qtile` config has been moved [here](https://github.com/goatfiles/qtile-config)

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 3. The install process. [[toc](#table-of-content)]
### download Arch
- https://archlinux.org/download/
- https://wiki.archlinux.org/title/USB_flash_installation_medium
- https://wiki.archlinux.org/title/Iwd#iwctl

### some requirements
on Ubuntu, there are some requirements to install before anything else
```
# general
sudo apt install git cmake curl

# nushell
sudo apt install libssl-dev

# neovim
sudo apt install libtool-bin gettext
```

on ArchLinux
```
# minimal
sudo pacman -S openssl openssh vim git libxft cmake unzip xorg xorg-xinit bspwm sxhkd tmux qutebrowser xclip libnotify rofi slock dunst pinentry at-spi2-core gtk3 bluez bluez-utils cronie ranger
```

first of all, we will install Nushell to make our lives easier:
- install Rust and `cargo` via `rustup`
```bash
bash> export CARGO_HOME=~/.local/share/cargo
bash> curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
- install Nushell with `cargo`
```bash
bash> cargo install nu
```
- enter Nushell
```bash
bash> nu
```
- install the dotfiles
```nushell
git clone --bare https://github.com/amtoine/dotfiles /tmp/dotfiles
alias cfg = ^git --git-dir /tmp/dotfiles --work-tree $nu.home-path
cfg reset --hard
cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
```
- install Nupm and a tool to manage Git repositories
```nushell
git clone https://github.com/nushell/nupm /tmp/nupm
git clone https://github.com/amtoine/nu-git-manager /tmp/nu-git-manager

use /tmp/nupm/nupm
nupm install --path /tmp/nupm/
nupm install --path /tmp/nu-git-manager/
```

> **Note**  
> in the following we assume `nupm` and `gm` have been brought into scope with
> ```nushell
> use nupm
> ```
> and
> ```nushell
> use nu-git-manager gm
> ```
> respectively

- pull down repositories
```nushell
const REPOS = [
    [url,                                         bare,  fetch, push];

    [git://git.suckless.org/st,                   false, git,   git],
    [https://github.com/amtoine/nu-git-manager,   false, https, ssh],
    [https://github.com/amtoine/dotfiles,         true,  https, ssh],
    [https://github.com/amtoine/scripts,          false, https, ssh],
    [https://github.com/amtoine/tmux-sessionizer, false, https, ssh],
    [https://github.com/neovim/neovim,            false, https, https],
    [https://github.com/nushell/nu_scripts,       false, https, https],
    [https://github.com/nushell/nupm,             false, https, https],
    [https://github.com/nushell/nushell,          false, https, https],
]

$REPOS | each {|repo|
    if $repo.bare {
        gm clone $repo.url --fetch $repo.fetch --push $repo.push --bare
    } else {
        gm clone $repo.url --fetch $repo.fetch --push $repo.push
    }
}
```
- install Nushell packages
```nushell
const PKGS = [
    github.com/amtoine/nu-git-manager
    github.com/amtoine/scripts/nu_scripts
    github.com/amtoine/scripts/nu-logout
    github.com/amtoine/tmux-sessionizer
    github.com/nushell/nu_scripts
    github.com/nushell/nupm
]

$PKGS | each {|pkg| nupm install --force --path (gm status | get root.path | path join $pkg) }
```
- install Nushell from source
```
cargo install --path (gm list --full-path  | find "nushell/nushell" | get 0)
```
- install the ST terminal emulator
```
# in `st/st`
cp ~/.config/st/config.h .
sudo make clean install
```
- install the Rio terminal emulator from source
```
cargo install --force --locked --git https://github.com/raphamorim/rio
```
- install the Alacritty terminal emulator from source
```
cargo install --force --locked --git https://github.com/alacritty/alacritty
```
- install Neovim from source
```
# in `neovim/neovim`
git checkout v0.9.0
make CMAKE_BUILD_TYPE=Release
sudo make install

# in `amtoine/kickstart.nvim`
tk setup
tk update
```
- install Nix
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
- install some more software
```
cargo install git-delta fd-find ripgrep sd
sudo apt install gnome-screensaver gnome-shell-extensions tmux wl-clipboard bat
```
- enable bluetooth
```
systemctl enable bluetooth
```
- enable cron jobs
```
systemctl enable cronie
```
- install Discord with `use ~/.config/discord/install.nu *` and then `discord install --help`

## Ubuntu-specific instructions
- settings > multitasking > 4 workspaces
- settings > keyboard > default layout to us
- edit `/etc/default/keyboard` with
```bash
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=
XKBOPTIONS=""

BACKSPACE="guess"
```
- settings > keyboard > bindings > custom >
    - bye on `super + shift + q`: `rio --command nu --env-config ~/.config/nushell/env.nu --commands "logout.nu --lock 'gnome-screensaver-command --lock'"`
    - terminal on `super + enter`: `rio --command nu --commands "$env.SHELL = $nu.current-exe; tmux new-session -A -s (random uuid)"`
- disable settings > keyboard > bindings > windows > hide window on `super + h`
- disable settings > keyboard > bindings > system > lock screen on `super + l`
- settings > keyboard > bindings > navigation > move workspace left / right with `super  + h / l`
- settings > keyboard > bindings > navigation > move window to workspace left / right with `super  + shift + h / l`
- settings > keyboard > bindings > navigation > switch windows on `super + j`
- settings > keyboard > bindings > navigation > switch windows directly on `super + k`
- disable settings > power -> screen blank
- disable settings > power > automatic suspend
- run `gsettings set org.gnome.desktop.interface locate-pointer true`

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 4. Contribute. [[toc](#table-of-content)]
YOU can contribute to this project in the wonderfull world of linux, arch and configuration!
- if you like this overview, try to install the config and see what it looks like!
- if you like this config, please share it to whoever could be interested.
- if you stumble upon bugs, ideas, new amazing color palettes or alternatives,
- if you want to be part of the testers for my install script.
do not hesitate to [contact me](https://amtoine.github.io/contact), either via email, github issues or pull requests!

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 5. Gallery. [[toc](#table-of-content)]
**COMING SOON**

[archlinux]:         https://archlinux.org/
[fireship-dotfiles]: https://www.youtube.com/watch?v=r_MpUP6aKiQ
[bare-repo-blog]:    https://www.atlassian.com/git/tutorials/dotfiles
[bare-repo-dt]:      https://www.youtube.com/watch?v=tBoLDpTWVOM&t=879s
