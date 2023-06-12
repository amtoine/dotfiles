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
- **3**     [**The install process**](#3-the-install-process-toc) (**coming soon**)
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
**COMING SOON**

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
