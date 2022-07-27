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
- **2**     [**The software I use.**](#2-the-software-i-use-toc)
- **3**     [**The install process**](#3-the-install-process-toc)
- **3.1**   [**Manual Installation**](#31-manual-installation-deprecated-see-the-automatic-install-instead-toc)
- **3.2**   [**Dependencies**](#32-dependencies-toc)
- **3.3**   [**Install script**](#33-install-script-toc)
- **3.3.1** [**DISCLAIMERS**](#331-disclaimers-toc)
- **3.3.2** [**Install the config**](#332-install-the-config-toc)
- **3.3.3** [**Uninstall the config**](#333-uninstall-the-config-toc)
- **4**     [**Contribute.**](#4-contribute-toc)
- **5**     [**Gallery.**](#5-gallery-toc)

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
**A lot of things have been going on on my *GitHub* account recently, e.g. a lot of refactoring.**

**For now, I consider that part of the README deprecated and thus hide it.**

**But I still chose to keep it in the README anyway as some of the information is probably still relevant.**

<details> 
  <summary>WORK IN PROGRESS</summary>

The documentation of my dotfiles is scattered across this repo but can be found in a more dedicated fashion on my [personal website][mysite] under the [`config/doc/`][mydoc] domain.  
In this section, some general ideas are given and the lists of the programs, scripts and other stuff I use are put forward.

(\*) comes from another repo.  
(\*\*) the associated documentation page.

### The list of all the entries:
- [around boot time](#around-boot-time-list)  
- [window managers](#window-managers-list)  
- [image viewers and wallpaper](#image-viewers-and-wallpaper-list)  
- [terminal emulators](#terminal-emulators-list)  
- [text editors](#text-editors-list)  
- [browsers](#browsers-list)  
- [screen locks](#screen-locks-list)  
- [process monitors](#process-monitors-list)  
- [shells](#shells-list)  
- [music players](#music-players-list)  
- [video players](#video-players-list)  
- [scripts](#scripts-list)  
- [packages](#packages-list)  
- [file explorers](#file-explorers-list)  
- [notification servers](#notification-servers-list)  
- [chat clients](#chat-clients-list)  
- [password managers](#password-managers-list)  
- [python virtual environment managers](#python-virtual-environment-managers-list)  
- [miscellaneous](#miscellaneous-list)  

#### Around [boot time](.config/etc) [[list](#the-list-of-all-the-entries)]
- [x] a prettier [`grub`] theme.
- [x] [`sddm`] as a login manager.
- [x] [`/etc/issue`] to greet the user on other `tty`s

#### Window managers [[list](#the-list-of-all-the-entries)]
- [x] [`qtile`] ([\*\*][mydoc-qtile])
- [ ] [`bspwm`] ([\*\*][mydoc-bspwm])
- [ ] [`sxhkd`], mandatory with `bspwm` ([\*\*][mydoc-sxhkd])
- [ ] [`spectrWM`] ([\*\*][mydoc-spectrWM])

#### Image viewers and wallpaper [[list](#the-list-of-all-the-entries)]
- [x] `feh` but there is nothing to configure really.
- [x] my [personal wallpapers][my-wallpapers], set with `feh` on startup (\*) ([\*\*][mydoc-wallpapers])
- [ ] [`nitrogen`] ([\*\*][mydoc-nitrogen])
- [ ] [`nsxiv`]

#### Terminal emulators [[list](#the-list-of-all-the-entries)]
- [x] [`kitty`] (\*) ([\*\*][mydoc-kitty])
- [ ] [`alacritty`] ([\*\*][mydoc-alacritty])
- I plan on trying out the [suckless terminal](https://st.suckless.org/), `st`, in the future.

#### Text editors [[list](#the-list-of-all-the-entries)]
- [x] [my fork][my-neovim] of [LunarVim's neovim config][nvim]  (\*) ([\*\*][mydoc-neovim])
- [x] [`doom emacs`]
- [ ] [`vim`] ([\*\*][mydoc-vim])

#### Browsers [[list](#the-list-of-all-the-entries)]
- [x] [`surf`] (\*) ([\*\*][mydoc-surf])
- [x] [my fork][my-surf] of [suckless surf][surf] (\*) ([\*\*][mydoc-surf])
- [x] [my fork][my-tabbed] of [suckless tabbed][tabbed] (\*) ([\*\*][mydoc-tabbed])
- [x] [`vimb`]
- [x] [`qutebrowser`]
- [x] `firefox`, only log into the firefox account to synchronize.
- [ ] `chromium`, only for very specific things.

#### Screen locks [[list](#the-list-of-all-the-entries)]
- [x] [my fork][my-slock] of [suckless slock][slock] (\*) ([\*\*][mydoc-slock])
- [ ] [`xscreensaver`] ([\*\*][mydoc-xscreensaver])

#### Process monitors [[list](#the-list-of-all-the-entries)]
- [x] [`htop`] ([\*\*][mydoc-htop])
- [ ] [`bashtop`]
- [ ] [`bpytop`]
- [ ] [`btop`]

#### Shells [[list](#the-list-of-all-the-entries)]
- [x] [`fish`] ([\*\*][mydoc-fish])
- [x] [`omf`]
- [x] [`fisher`]
- [ ] [`bash`] ([\*\*][mydoc-bash])
- [ ] [`zsh`] ([\*\*][mydoc-zsh])

#### Music players [[list](#the-list-of-all-the-entries)]
- [x] [`moc`] ([\*\*][mydoc-moc])
- [ ] [`mpd`] ([\*\*][mydoc-mpd])
- [ ] [`ncmcpp`] ([\*\*][mydoc-ncmcpp])

#### Video players [[list](#the-list-of-all-the-entries)]
- [x] [`mpv`] ([\*\*][mydoc-mpv])

#### Scripts [[list](#the-list-of-all-the-entries)]
- [x] all my [`scripts`]
- [x] [`dmscripts`]

#### Packages [[list](#the-list-of-all-the-entries)]
- [x] [`pkgslists`]

#### File explorers [[list](#the-list-of-all-the-entries)]
- [x] [`lf`] ([\*\*][mydoc-lf])
- [ ] [`dmenufm`] ([\*\*][mydoc-dmenufm])
- [ ] [`vifm`] ([\*\*][mydoc-vifm])
- [ ] `ranger`

#### Notification servers [[list](#the-list-of-all-the-entries)]
- [x] [`dunst`]

#### Chat clients [[list](#the-list-of-all-the-entries)]
- [x] `discord`
- [x] `thunderbird`
- [x] `slack`
- [x] `signal`
- [x] `messenger`

#### Password managers [[list](#the-list-of-all-the-entries)]
- [x] `bitwarden` on `firefox`
- [x] `pass` everywhere else

#### Miscellaneous [[list](#the-list-of-all-the-entries)]
- [x] [`git`] ([\*\*][mydoc-git])
- [x] [`lazygit`] ([\*\*][mydoc-lazygit])
- [x] [`tig`] ([\*\*][mydoc-tig])
- [x] [my fork][my-dmenu] of [suckless dmenu][dmenu] (\*) ([\*\*][mydoc-dmenu])
- [x] [`conky`]
- [x] [`x`] ([\*\*][mydoc-x])
- [ ] [`lazycli`] ([\*\*][mydoc-lazycli])
- [ ] [`starship`] ([\*\*][mydoc-starship])
- [ ] [my fork][my-polybar-themes] of [polybar-themes] (\*) ([\*\*][mydoc-polybar-themes])
- [ ] [`neofetch`] ([\*\*][mydoc-neofetch])
- [ ] [`rofi`] ([\*\*][mydoc-rofi])
- [ ] [`tmux`] ([\*\*][mydoc-tmux])
- [ ] [`jgmenu`]

(\*) comes from another repo.  
(\*\*) the associated documentation page.
</details>

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 3. The install process. [[toc](#table-of-content)]
One has two ways to install the configs of this repo, the [manual way](#31-manual-installation-deprecated-see-the-automatic-install-instead-toc) and the [automatic way](#33-install-script-toc).  
One is encouraged to create a Virtual Machine, e.g. with `virtualbox`, clone the minimal arch installation to have backup machines, and then try out the config from there.

### 3.1. Manual Installation (**DEPRECATED**, see the [automatic install](#33-install-script-toc) instead). [[toc](#table-of-content)]
The idea is to manually:
- backup your config files.
- copy mine in replacement.

For instance, let us say that you want to replace your `vim` config with mine, you can directly:
- clone the repo with `git clone https://github.com/amtoine/dotfiles.git` or `git clone git@github.com:amtoine/dotfiles.git`.
- place your version of the `.vimrc` file inside a backup directory or archive.
- copy my `.vimrc` file in replacement of yours.
- follow additional instructions in the dedicated section ([here][mydoc-vim]).
- enjoy your new `vim` experience!

### 3.2. Dependencies. [[toc](#table-of-content)]
In this config, some parts, i.e. commands and programs like window managers or text editors, require some dependencies.  
To install dependencies, one has three options:
- install them by hand, individually -> use `pacman -F <command>` or `yay -F <command>` to find the name of the package
containing the command. Then issue `pacman -S <package>` or `yay -S <package>` to install them.
- install all the packages I have on my system by using the lists in [`pkgslists`] and `pacman` or `yay` to install them.
- use the automatic install process [below](#33-install-script-toc).

### 3.3. Install script. [[toc](#table-of-content)]
**As stated in section 2, a lot of refactoring has been done on my whole *GitHub* account.**

**I keep the following section for those how really know what they are doing, but do not feel comfortable enough to leave it open by default.**

<details> 
  <summary>WORK IN PROGRESS</summary>

#### 3.3.1. DISCLAIMERS. [[toc](#table-of-content)]
This is the first time I develop such a complicated and sometimes critical, e.g. when editing `x` or `bspwm` config files, file-modifying-and-removing-and-moving script.  
It has only been tested a very few times on a fake home directory on my arch linux machine and on a raspberry pi running the `raspberry` distro (previously `raspbian`).
It looks pretty functional to me as a first draft, however:
  - (1) I plan on testing this a lot more, with testers from relatives of mine (**if YOU want to contribute, see the [contribute section](#4-contribute-toc)**).
  - (2) this first draft is far from perfect and might not be super user-friendly nor understandable right away, though I tried to make it so. If you have any idea to enhance it, feel free to [contact me](https://amtoine.github.io/public/contact)!
  - (3) there might be, I hope not too many, bugs in the script. As it can be pretty critical depending on the part of the installation where the bug happens (if any ;)), I warn you: **RUNNING THIS SCRIPT ON YOUR PERSONAL MACHINE IS NOT MY RESPONSIBILITY** by any means. If **ANYTHING BAD HAPPENS**, I would **NOT BE TAKEN AS RESPONSIBLE**. However, I would be very pleased to help you if anything unexpected happens, it almost goes without saying ;).

Oh my, I might look a bit dramatical on this ^^  
But as it is the first time, as I said, that I do such a thing in public, I do not want to broadcast mistakes nor be taken responsible for not warning potential users.

#### 3.3.2. Install the config. [[toc](#table-of-content)]
**THE INSTALLATION SCRIPT IS FINALLY THERE!!**  
Simply run:
```bash
curl -fsFLo /tmp/amtoine.install.sh https://raw.githubusercontent.com/amtoine/dotfiles/main/.local/bin/install.sh
chmod +x /tmp/amtoine.install.sh
/tmp/amtoine.install.sh --help
```
to pull the script down and directly show the help message, and then
```bash
/tmp/amtoine.install.sh [switches]
```
to run the install process.
Or one can directly run
```bash
curl -fsFLo /tmp/amtoine.install.sh https://raw.githubusercontent.com/amtoine/dotfiles/main/.local/bin/install.sh; /tmp/amtoine.install.sh --all
curl -fsFLo /tmp/amtoine.install.sh https://raw.githubusercontent.com/amtoine/dotfiles/main/.local/bin/install.sh; /tmp/amtoine.install.sh --interactive
```
for a direct full/interactive install process respectively.

#### 3.3.3. Uninstall the config. [[toc](#table-of-content)]
**NOT AVAILABLE NOW** but should simply be the mirror of the previous.
</details>

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 4. Contribute. [[toc](#table-of-content)]
YOU can contribute to this project in the wonderfull world of linux, arch and configuration!
- if you like this overview, try to install the config and see what it looks like!
- if you like this config, please share it to whoever could be interested.
- if you stumble upon bugs, ideas, new amazing color palettes or alternatives,
- if you want to be part of the testers for my install script.
do not hesitate to [contact me](https://amtoine.github.io/public/contact), either via email, github issues or pull requests!

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 5. Gallery. [[toc](#table-of-content)]
**COMING SOON**

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
<!-- my files -->
[`pkgslists`]:    .pkgslists
[`alacritty`]:    .config/alacritty/alacritty.yml
[`bashtop`]:      .config/bashtop/bashtop.cfg
[`bpytop`]:       .config/bpytop/bpytop.conf
[`bspwm`]:        .config/bspwm/
[`btop`]:         .config/btop/btop.conf
[`dmscripts`]:    .config/dmscripts/config
[`dmenufm`]:      .config/dmenufm/dmenufm.conf
[`git`]:          .gitconfig
[`htop`]:         .config/htop/htoprc
[`kitty`]:        .config/kitty/kitty.conf
[`lf`]:           .config/lf/lfrc
[`lazygit`]:      .config/lazygit
[`lazycli`]:      .config/lazycli
[`mpd`]:          .config/mpd/mpd.conf
[`moc`]:          .moc/config
[`mpv`]:          .config/mpv
[`ncmcpp`]:       .config/ncmcpp/config
[`neofetch`]:     .config/neofetch
[`nitrogen`]:     .config/nitrogen/nitrogen.cfg
[`qtile`]:        .config/qtile
[`rofi`]:         .config/rofi/config.rasi
[`spectrWM`]:     .config/spectrwm
[`sxhkd`]:        .config/sxhkd/sxhkdrc
[`starship`]:     .config/starship.toml
[`surf`]:         .config/surf
[`vimb`]:         .config/vimb
[`tig`]:          .config/tig/config
[`tmux`]:         .tmux.conf
[`vifm`]:         .config/vifm
[`vim`]:          .vimrc
[`x`]:            .xinitrc
[`xscreensaver`]: .xscreensaver

[`bash`]:         .bashrc
[`fish`]:         .config/fish
[`omf`]:          .config/omf
[`fisher`]:       .config/fish/fish_plugins
[`zsh`]:          .zshrc

[`grub`]:         .config/etc/default/grub
[`sddm`]:         .config/etc/issue
[`/etc/issue`]:   .config/etc/sddm.conf

[`doom emacs`]:   .doom.d
[`nsxiv`]:        .config/nsxiv/
[`dunst`]:        .config/dunst/

[`conky`]:        .config/conky/
[`jgmenu`]:       .config/jgmenu.csv

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
<!-- my links -->
[archlinux]:            https://archlinux.org/
[fireship-dotfiles]:    https://www.youtube.com/watch?v=r_MpUP6aKiQ
[bare-repo-blog]:       https://www.atlassian.com/git/tutorials/dotfiles
[bare-repo-dt]:         https://www.youtube.com/watch?v=tBoLDpTWVOM&t=879s
[mysite]:               https://amtoine.github.io/public
[mydoc]:                https://amtoine.github.io/public/doc/config

<!-- programs -->
[mydoc-alacritty]:      https://amtoine.github.io/public/doc/config/dotfiles/alacritty
[mydoc-bash]:           https://amtoine.github.io/public/doc/config/dotfiles/bash
[mydoc-bspwm]:          https://amtoine.github.io/public/doc/config/dotfiles/bspwm
[mydoc-bashtop]:        https://amtoine.github.io/public/doc/config/dotfiles/bashtop
[mydoc-bpytop]:         https://amtoine.github.io/public/doc/config/dotfiles/bpytop
[mydoc-btop]:           https://amtoine.github.io/public/doc/config/dotfiles/btop
[mydoc-dmenufm]:        https://amtoine.github.io/public/doc/config/dotfiles/dmenufm
[mydoc-fish]:           https://amtoine.github.io/public/doc/config/dotfiles/fish
[mydoc-git]:            https://amtoine.github.io/public/doc/config/dotfiles/git
[mydoc-htop]:           https://amtoine.github.io/public/doc/config/dotfiles/htop
[mydoc-lf]:             https://amtoine.github.io/public/doc/config/dotfiles/lf
[mydoc-lazygit]:        https://amtoine.github.io/public/doc/config/dotfiles/lazygit
[mydoc-lazycli]:        https://amtoine.github.io/public/doc/config/dotfiles/lazycli
[mydoc-mpd]:            https://amtoine.github.io/public/doc/config/dotfiles/mpd
[mydoc-moc]:            https://amtoine.github.io/public/doc/config/dotfiles/moc
[mydoc-mpv]:            https://amtoine.github.io/public/doc/config/dotfiles/mpv
[mydoc-ncmcpp]:         https://amtoine.github.io/public/doc/config/dotfiles/ncmcpp
[mydoc-neofetch]:       https://amtoine.github.io/public/doc/config/dotfiles/neofetch
[mydoc-nitrogen]:       https://amtoine.github.io/public/doc/config/dotfiles/nitrogen
[mydoc-qtile]:          https://amtoine.github.io/public/doc/config/dotfiles/qtile
[mydoc-rofi]:           https://amtoine.github.io/public/doc/config/dotfiles/rofi
[mydoc-spectrwm]:       https://amtoine.github.io/public/doc/config/dotfiles/spectrwm
[mydoc-sxhkd]:          https://amtoine.github.io/public/doc/config/dotfiles/sxhkd
[mydoc-starship]:       https://amtoine.github.io/public/doc/config/dotfiles/starship
[mydoc-tig]:            https://amtoine.github.io/public/doc/config/dotfiles/tig
[mydoc-tmux]:           https://amtoine.github.io/public/doc/config/dotfiles/tmux
[mydoc-vifm]:           https://amtoine.github.io/public/doc/config/dotfiles/vifm
[mydoc-vim]:            https://amtoine.github.io/public/doc/config/dotfiles/vim
[mydoc-x]:              https://amtoine.github.io/public/doc/config/dotfiles/x
[mydoc-xscreensaver]:   https://amtoine.github.io/public/doc/config/dotfiles/xscreensaver
[mydoc-zsh]:            https://amtoine.github.io/public/doc/config/dotfiles/zsh

<!-- other stuff -->
[`scripts`]:            .local/bin
[virtualenvs-en]:       https://virtualenvwrapper.readthedocs.io/en/latest/
[virtualenvs-fr]:       https://python-guide-pt-br.readthedocs.io/fr/latest/dev/virtualenvs.html
[dmenu]:                https://git.suckless.org/dmenu/
[dmscripts-dt]:         https://gitlab.com/dwt1/dmscripts.git
[kitty]:                https://github.com/kovidgoyal/kitty
[oh-my-bash]:           https://github.com/ohmybash/oh-my-bash
[oh-my-fish]:           https://github.com/oh-my-fish/oh-my-fish
[oh-my-zsh]:            https://github.com/ohmyzsh/ohmyzsh
[nvim]:                 https://github.com/LunarVim/Neovim-from-scratch
[polybar-themes]:       https://github.com/adi1090x/polybar-themes
[surf]:                 https://git.suckless.org/surf/
[tabbed]:               https://git.suckless.org/tabbed/
[slock]:                https://git.suckless.org/slock/
[my-wallpapers]:        https://github.com/amtoine/wallpapers
[my-dmenu]:             https://github.com/amtoine/dmenu
[my-dmscripts]:         https://github.com/amtoine/dmscripts
[my-kitty]:             https://github.com/amtoine/kitty
[my-oh-my-bash]:        https://github.com/amtoine/oh-my-bash
[my-oh-my-fish]:        https://github.com/amtoine/oh-my-fish
[my-oh-my-zsh]:         https://github.com/amtoine/ohmyzsh
[my-neovim]:            https://github.com/amtoine/neovim
[my-polybar-themes]:    https://github.com/amtoine/polybar-themes
[my-surf]:              https://github.com/amtoine/surf
[my-tabbed]:            https://github.com/amtoine/tabbed
[my-slock]:             https://github.com/amtoine/slock
[mydoc-wallpapers]:     https://amtoine.github.io/public/doc/config/wallpapers
[mydoc-dmenu]:          https://amtoine.github.io/public/doc/config/dmenu
[mydoc-dmscripts]:      https://amtoine.github.io/public/doc/config/dmscripts
[mydoc-kitty]:          https://amtoine.github.io/public/doc/config/kitty
[mydoc-oh-my-bash]:     https://amtoine.github.io/public/doc/config/bash
[mydoc-oh-my-fish]:     https://amtoine.github.io/public/doc/config/fish
[mydoc-oh-my-zsh]:      https://amtoine.github.io/public/doc/config/zsh
[mydoc-neovim]:         https://amtoine.github.io/public/doc/config/neovim
[mydoc-polybar-themes]: https://amtoine.github.io/public/doc/config/polybar
[mydoc-surf]:           https://amtoine.github.io/public/doc/config/surf
[mydoc-tabbed]:         https://amtoine.github.io/public/doc/config/tabbed
[mydoc-slock]:          https://amtoine.github.io/public/doc/config/slock

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
<!-- gallery -->
[mygallery-nitrogen]:   https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-nitrogen.png
[mygallery-bar]:        https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-bar.png
[mygallery-spectrwm1]:  https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-spectrwm1.png
[mygallery-spectrwm2]:  https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-spectrwm2.png
[mygallery-htop]:       https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-htop.png
[mygallery-git]:        https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-git.png
[mygallery-vim]:        https://amtoine.github.io/public/res/doc/config/dotfiles/gallery-vim.png
