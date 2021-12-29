# This is my personal config repository for archlinux.
The following document gives a high level overview of my linux config.  
This particular config has been tested on ArchLinux only (last update on 11/14/21).  
Thus, only `pacman` and `yay` have been used and tested as arch and AUR packages managers respectively.  
The reader is highly adviced to search the internet and in particular the [ArchWiki][archlinux], **EVEN in NON arch-based systems!!**

First, an overview of the repo is given with the project architecture and a brief explaination of all the files involved in [section 1](#1-overview-and-architecture-toc).  
The documentation is presented and linked in [section 2](#2-documentation-toc).  
Finally, ways to contribute to this project are put forward in [section 3](#3-contribute-toc) for who is interested and a gallery of photos is presented in [section 4](#4-gallery-toc), 
to give an idea of the final rendering of the config.  

If you want a quick brief of what dotfiles really are, I recommend [this video][fireship-dotfiles] of *FireShip*.

**AN INSTALLATION SCRIPT IS AVAILABLE AS A DRAFT**  
Check the [inst branch](https://github.com/a2n-s/dotfiles/tree/inst) if you are interested.

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## Table Of Content.
- **1** [**Overview and architecture.**](#1-overview-and-architecture-toc)
- **2** [**Documentation.**](#2-documentation-toc)
- **3** [**Automatic install and uninstall.**](#3-automatic-install-and-uninstall-toc)
- **4** [**Contribute.**](#4-contribute-toc)
- **5** [**Gallery.**](#5-gallery-toc)

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 1. Overview and architecture. [[toc](#table-of-content)]
Below is a snapshot of the architecture of the config project.  
This repo has been created using a `bare` repository, i.e. initialization has been done with `git init --bare $HOME/.dotfiles` instead of the
usual `git init`.  This command creates a *bare* repository, meaning that there is no working directory inside it, only git files.
This is normal as *bare* repositories are not meant to host working files, but only track outside files.  
This makes the process of tracking *dotfiles* much easier! There is no need anymore to copy files into the *dotfiles* repository, track them
and put them back where they should be using symlinks! A simple `alias` of the form `cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
is enough.

Hence, the architecture below is a perfect mirror, regarding tracked files only, of my system!  

Notes:
- simply replace $HOME with whatever your personal space is called. One can issue `echo $HOME` in a terminal to check this.
- flags are given right before file names -> **[d]** indicates a directory, **[l]** a symbolic link and **[-]** a file.

If you want more information about *bare* `git` repositories, you can check one of the following resources:
- a [blog post][bare-repo-blog] about *bare* repositories.
- a [video from dt][bare-repo-dt] if you want to see the creation of such a repository step by step.
```
$HOME
|-- [d]  .config                                     -- main config directory
|   |-- [-]  alacritty/alacritty.yml                   --  the alacritty terminal emulator.
|   |-- [-]  bspwm/bspwmrc
|   |-- [-]  dmscripts/config
|   |-- [d]  fish                                      -- the fish shell
|   |-- [-]  htop/htoprc                               -- my process monitor.
|   |-- [-]  kitty/kitty.conf                          -- terminal emulator.
|   |-- [d]  lazygit                                   -- the lazy git tui tool.
|   |-- [-]  lf/lfrc                                   -- file explorer.
|   |-- [-]  mpd/mpd.conf                              -- music server deamon, crashes for some reason...
|   |-- [d]  mpv
|   |-- [-]  ncmpcpp/config                            -- music client.
|   |-- [d]  neofetch                                  -- a logo printer.
|   |-- [-]  nitrogen/nitrogen.cfg                     -- a wallpaper manager.
|   |-- [d]  spectrwm                                  -- the spectrWM tilling window manager.
|   |-- [d]  surf                                      -- the suckless web browser.
|   |-- [-]  sxhkd/sxhkdrc                             -- the simple x hot key daemon.
|   |-- [d]  vifm                                      -- a file manager.
|   |-- [-]  tigrc                                     -- shows git diffs in a pretty way.
|   `-- [-]  starship.toml                             -- a fast and customizable terminal prompt.
|-- [d]  .pkgslists                                  -- packages.
|   |-- [-]  README.md
|   |-- [-]  allpkglist.txt                            -- the list of all installed packages.
|   |-- [-]  foreignpkglist.txt                        -- the list of AUR packages.
|   |-- [-]  optdeplist.txt                            -- the list of optional packages.
|   `-- [-]  pkglist.txt                               -- the list of arch packages.
|-- [d]  scripts                                     -- my scripts.
|   |-- [-]  _countdown.sh                             -- a countdown with alarm (deprecated).
|   |-- [-]  _parse_git_info.sh                        -- parses the repo information if available.
|   |-- [-]  _shortwd.sh                               -- gives a short directory name for prompt.
|   |-- [-]  _stopwatch.sh                             -- a stopwatch (deprecated)
|   |-- [-]  dmrun.sh                                  -- a wrapper around dmenu.
|   |-- [-]  prompt.sh                                 -- a binary prompt that executes commands.
|   |-- [-]  screenshot.sh                             -- takes screeshots with scrot.
|   |-- [-]  slock-cst.sh                              -- a wrapper around slock.
|   |-- [-]  spectrWM-baraction.sh                     -- controls the spectrWM bar.
|   |-- [-]  togkb.sh                                  -- toggles the keyboard layout.
|   |-- [-]  tr2md.sh                                  -- transforms a directory into a tree for .md files.
|   |-- [-]  upl.sh                                    -- updates the list of installed packages.
|   |-- [-]  wvenv.sh                                  -- shows current python environment.
|   |-- [-]  xtcl.sh                                   -- disables my broken caps lock key.
|   `-- [-]  ytdl.sh
|-- [-]  .bash_logout                                -- what bash should do on logout.
|-- [-]  .bash_profile                               -- runs bash and starts the WM on startup.
|-- [-]  .bashrc                                     -- runs config stuff to make the experience what it is.
|-- [-]  .gitconfig                                  -- all my git config.
|-- [-]  .profile                                    -- profile script.
|-- [-]  .tmux.conf                                  -- my tmux config file.
|-- [-]  .vimrc                                      -- all needed configuration for a pretty vim.
|-- [-]  .xinitrc                                    -- what to do when x starts.
|-- [-]  .xscreensaver                               -- my config when the machine is idle or manually locked.
|-- [-]  .zshrc
|-- [-]  LICENSE
`-- [-]  README.md
```


<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 2. Documentation. [[toc](#table-of-content)]
The doc of my dotfiles can be found on my [personal website][mysite] under the [`config/doc/`][mydoc] domain.  
In this section, some general ideas are given and the lists of the programs, scripts and other stuff I use are put forward.

#### Manual Installation **DEPRECATED**.
The idea is to manually:
- backup your config files.
- copy mine in replacement.

For instance, let us say that you want to replace your `vim` config with mine, you can either go to the section below
or directly:
- clone the repo with `git clone https://github.com/a2n-s/dotfiles.git` or `git clone git@github.com:a2n-s/dotfiles.git`.
- place your version of the `.vimrc` file inside a backup directory or archive.
- copy my `.vimrc` file in replacement of yours.
- follow additional instructions in the dedicated section ([here][mydoc-vim]).
- enjoy your new `vim` experience!

#### Dependencies.
In this config, some part, i.e. commands and programs like window managers or text editors, requires some dependencies.  
To install dependencies, one has two options:
- install them by hand, individually -> use `pacman -F <command>` or `yay -F <command>` to find the name of the package
containing the command. Then issue `pacman -S <package>` or `yay -S <package>` to install them.
- install all the packages I have on my system by using the lists in [`pkgslists`] and `pacman` or `yay` to install them.

(\*) comes from another repo.  
(\*\*) the associated documentation page.

#### List of programs:
- [ ] [`alacritty`]         ([\*\*][mydoc-alacritty])
- [x] [`bspwm`]             ([\*\*][mydoc-bspwm])
- [x] [`bash`]              ([\*\*][mydoc-bash])
- [x] [`dmscripts`]
- [ ] [`fish`]              ([\*\*][mydoc-fish])
- [x] [`git`]               ([\*\*][mydoc-git])
- [x] [`htop`]              ([\*\*][mydoc-htop])
- [x] [`kitty`]        (\*) ([\*\*][mydoc-kitty])
- [x] [`lf`]                ([\*\*][mydoc-lf])
- [x] [`lazygit`]           ([\*\*][mydoc-lazygit])
- [ ] [`mpd`]               ([\*\*][mydoc-mpd])
- [x] [`mpv`]               ([\*\*][mydoc-mpv])
- [ ] [`ncmcpp`]            ([\*\*][mydoc-ncmcpp])
- [ ] [`neofetch`]          ([\*\*][mydoc-neofetch])
- [ ] [`nitrogen`]          ([\*\*][mydoc-nitrogen])
- [ ] [`spectrWM`]          ([\*\*][mydoc-spectrWM])
- [x] [`starship`]          ([\*\*][mydoc-starship])
- [x] [`sxhkd`]             ([\*\*][mydoc-sxhkd])
- [x] [`surf`]         (\*) ([\*\*][mydoc-surf])
- [x] [`tig`]               ([\*\*][mydoc-tig])
- [ ] [`tmux`]              ([\*\*][mydoc-tmux])
- [ ] [`vifm`]              ([\*\*][mydoc-vifm])
- [ ] [`vim`]               ([\*\*][mydoc-vim])
- [x] [`x`]                 ([\*\*][mydoc-x])
- [ ] [`xscreensaver`]      ([\*\*][mydoc-xscreensaver])
- [ ] [`zsh`]               ([\*\*][mydoc-zsh])

#### Other programs and stuff I use:
- [x] all my [`scripts`].
- [x] virtualenvwrapper: tutorials [in english][virtualenvs-en] and [in french][virtualenvs-fr].
- [x] some [wallpapers][my-wallpapers]                          (\*) ([\*\*][mydoc-wallpapers])
- [x] [my fork][my-dmenu] of [suckless dmenu][dmenu]            (\*) ([\*\*][mydoc-dmenu])
- [x] [my fork][my-dmscripts] of [dt's dmscripts][dmscripts-dt] (\*) ([\*\*][mydoc-dmscripts])
- [x] [my fork][my-kitty] of [kitty]                            (\*) ([\*\*][mydoc-kitty])
- [x] [my fork][my-oh-my-bash] of [oh-my-bash]                  (\*) ([\*\*][mydoc-oh-my-bash])
- [ ] [my fork][my-oh-my-fish] of [oh-my-fish]                  (\*) ([\*\*][mydoc-oh-my-fish])
- [ ] [my fork][my-oh-my-zsh] of [oh-my-zsh]                    (\*) ([\*\*][mydoc-oh-my-zsh])
- [x] [my fork][my-polybar-themes] of [polybar-themes]          (\*) ([\*\*][mydoc-polybar-themes])
- [x] [my fork][my-surf] of [suckless surf][surf]               (\*) ([\*\*][mydoc-surf])
- [x] [my fork][my-tabbed] of [suckless tabbed][tabbed]         (\*) ([\*\*][mydoc-tabbed])
- [x] [my fork][my-slock] of [suckless slock][slock]            (\*) ([\*\*][mydoc-slock])
- [x] [my fork][my-neovim] of [LunarVim's neovim config][nvim]  (\*) ([\*\*][mydoc-neovim])

(\*) comes from another repo.  
(\*\*) the associated documentation page.

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 3. Automatic install and uninstall. [[toc](#table-of-content)]
#### DISCLAIMERS.
This is the first time I develop such a complicated and sometimes critical, e.g. when editing `x` or `bspwm` config files, file-modifying-and-removing-and-moving script.  
It has only been tested a very few times on a fake home directory on my arch linux machine and on a raspberry pi running the `raspberry` distro (previously `raspbian`).
It looks pretty good to me as a first draft, however:
  - (1) I plan on testing this a lot more, with testers from relatives of mine (**if YOU want to contribute, see the [contribute section](#4-contribute-toc)).
  - (2) this first draft is far from perfect and might not be super user-friendly nor understandable, though I tried to make it so. If you have any idea, feel free to [contact me](https://a2n-s.github.io/public/contact)!
  - (3) there might be, I hope not too many, bugs in the script. As it can be pretty critical depending on the part of the installation where the bug happens (if any ;)), I warn you: **RUNNING THIS SCRIPT ON YOUR PERSONAL MACHINE IS NOT MY RESPONSIBILITY** by any means. If **ANYTHING BAD HAPPENS**, I would **NOT BE TAKEN AS RESPONSIBLE**. However, I would be very pleased to help you if anything unexpected happens, it almost goes without saying ;).

Oh my, I might look a bit dramatical on this ^^  
But as it is the first time, as I said, that I do such a thing in public, I do not want to broadcast mistakes nor be taken responsible for not warning potential users.

#### Install the config.
**THE INSTALLATION SCRIPT IS FINALLY THERE!!**  
Simply run:
```bash
git clone git@github.com:a2n-s/dotfiles.git ~/a2n-s.dotfiles
cd ~/a2n-s.dotfiles
./install.sh
```
and then follow the installation process.  
The idea of the script is to (*not in chronological order*):
   - (1) select what part of the config to install,
   - (2) backup the chosen files of the user inside a safe place and
   - (3) install my config files in replacement.  
   - (4) install the needed package at each step.  
   - (5) install my scripts.  
   - (6) clone my repos and recreate the same upstream links.
   - (7) install the fonts I use (**NOT AVAILABLE NOW**)

#### Uninstall the config.
**NOT AVAILABLE NOW** but should simply be the mirror of the previous.

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 4. Contribute. [[toc](#table-of-content)]
YOU can contribute to this project in the wonderfull world of linux, arch and configuration!
- if you like the overview, try to install the config and see what it looks like!
- if you like the config, please share it to whoever could be interested.
- if you stumble upon bugs, ideas, new amazing color palettes or alternatives,
- if you want to be part of the testers for my install script.
do not hesitate to [contact me](https://a2n-s.github.io/public/contact), either via email, github issues or pull requests!

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
## 5. Gallery. [[toc](#table-of-content)]
| ![My wallpaper.][mygallery-nitrogen] |
|:--:|
| *My wallpaper.* |

| ![My bar.][mygallery-bar] |
|:--:|
| *My bar.* |

| ![SpectrWM in a dual monitor setup: left monitor selected.][mygallery-spectrwm1] |
|:--:|
| *SpectrWM in a dual monitor setup: left monitor selected.* |

| ![SpectrWM in a dual monitor setup: right monitor selected.][mygallery-spectrwm2] |
|:--:|
| *SpectrWM in a dual monitor setup: right monitor selected.* |

| ![A screenshot of seing all processes.][mygallery-htop] |
|:--:|
| *A screenshot of seing all processes.* |

| ![A screenshot of being in a git repository.][mygallery-git] |
|:--:|
| *A screenshot of being in a git repository.* |

| ![A screenshot of being in vim.][mygallery-vim] |
|:--:|
| *A screenshot of being in vim.* |


<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
<!-- my files -->
[`pkgslists`]:             .pkgslists
[`alacritty`]:             .config/alacritty/alacritty.yml
[`bspwm`]:                 .config/bspwm/bspwmrc
[`bash`]:                  .bashrc
[`dmscripts`]:             .config/dmscripts/config
[`fish`]:                  .config/fish
[`git`]:                   .gitconfig
[`htop`]:                  .config/htop/htoprc
[`kitty`]:                 .config/kitty/kitty.conf
[`lf`]:                    .config/lf/lfrc
[`lazygit`]:               .config/lazygit
[`mpd`]:                   .config/mpd/mpd.conf
[`mpv`]:                   .config/mpv
[`ncmcpp`]:                .config/ncmcpp/config
[`neofetch`]:              .config/neofetch
[`nitrogen`]:              .config/nitrogen/nitrogen.cfg
[`spectrWM`]:              .config/spectrwm
[`sxhkd`]:                 .config/sxhkd/sxhkdrc
[`starship`]:              .config/starship.toml
[`surf`]:                  .config/surf
[`tig`]:                   .config/tigrc
[`tmux`]:                  .tmux.conf
[`vifm`]:                  .config/vifm
[`vim`]:                   .vimrc
[`x`]:                     .xinitrc
[`xscreensaver`]:          .xscreensaver
[`zsh`]:                   .zshrc

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
<!-- my links -->
[archlinux]:                   https://archlinux.org/
[fireship-dotfiles]:           https://www.youtube.com/watch?v=r_MpUP6aKiQ
[bare-repo-blog]:              https://www.atlassian.com/git/tutorials/dotfiles
[bare-repo-dt]:                https://www.youtube.com/watch?v=tBoLDpTWVOM&t=879s
[mysite]:                      https://a2n-s.github.io/public
[mydoc]:                       https://a2n-s.github.io/public/doc/config

<!-- programs -->
[mydoc-alacritty]:             https://a2n-s.github.io/public/doc/config/dotfiles/alacritty
[mydoc-bspwm]:                 https://a2n-s.github.io/public/doc/config/dotfiles/bspwm
[mydoc-bash]:                  https://a2n-s.github.io/public/doc/config/dotfiles/bash
[mydoc-fish]:                  https://a2n-s.github.io/public/doc/config/dotfiles/fish
[mydoc-git]:                   https://a2n-s.github.io/public/doc/config/dotfiles/git
[mydoc-htop]:                  https://a2n-s.github.io/public/doc/config/dotfiles/htop
[mydoc-lf]:                    https://a2n-s.github.io/public/doc/config/dotfiles/lf
[mydoc-lazygit]:               https://a2n-s.github.io/public/doc/config/dotfiles/lazygit
[mydoc-mpd]:                   https://a2n-s.github.io/public/doc/config/dotfiles/mpd
[mydoc-mpv]:                   https://a2n-s.github.io/public/doc/config/dotfiles/mpv
[mydoc-ncmcpp]:                https://a2n-s.github.io/public/doc/config/dotfiles/ncmcpp
[mydoc-neofetch]:              https://a2n-s.github.io/public/doc/config/dotfiles/neofetch
[mydoc-nitrogen]:              https://a2n-s.github.io/public/doc/config/dotfiles/nitrogen
[mydoc-spectrwm]:              https://a2n-s.github.io/public/doc/config/dotfiles/spectrwm
[mydoc-sxhkd]:                 https://a2n-s.github.io/public/doc/config/dotfiles/sxhkd
[mydoc-starship]:              https://a2n-s.github.io/public/doc/config/dotfiles/starship
[mydoc-tig]:                   https://a2n-s.github.io/public/doc/config/dotfiles/tig
[mydoc-tmux]:                  https://a2n-s.github.io/public/doc/config/dotfiles/tmux
[mydoc-vifm]:                  https://a2n-s.github.io/public/doc/config/dotfiles/vifm
[mydoc-vim]:                   https://a2n-s.github.io/public/doc/config/dotfiles/vim
[mydoc-x]:                     https://a2n-s.github.io/public/doc/config/dotfiles/x
[mydoc-xscreensaver]:          https://a2n-s.github.io/public/doc/config/dotfiles/xscreensaver
[mydoc-zsh]:                   https://a2n-s.github.io/public/doc/config/dotfiles/zsh

<!-- other stuff -->
[`scripts`]:                   scripts
[virtualenvs-en]:              https://virtualenvwrapper.readthedocs.io/en/latest/
[virtualenvs-fr]:              https://python-guide-pt-br.readthedocs.io/fr/latest/dev/virtualenvs.html
[dmenu]:                       https://git.suckless.org/dmenu/
[dmscripts-dt]:                https://gitlab.com/dwt1/dmscripts.git
[kitty]:                       https://github.com/kovidgoyal/kitty
[oh-my-bash]:                  https://github.com/ohmybash/oh-my-bash
[oh-my-fish]:                  https://github.com/oh-my-fish/oh-my-fish
[oh-my-zsh]:                   https://github.com/ohmyzsh/ohmyzsh
[nvim]:                        https://github.com/LunarVim/Neovim-from-scratch
[polybar-themes]:              https://github.com/adi1090x/polybar-themes
[surf]:                        https://git.suckless.org/surf/
[tabbed]:                      https://git.suckless.org/tabbed/
[slock]:                       https://git.suckless.org/slock/
[my-wallpapers]:               https://github.com/a2n-s/wallpapers
[my-dmenu]:                    https://github.com/a2n-s/dmenu
[my-dmscripts]:                https://github.com/a2n-s/dmscripts
[my-kitty]:                    https://github.com/a2n-s/kitty
[my-oh-my-bash]:               https://github.com/a2n-s/oh-my-bash
[my-oh-my-fish]:               https://github.com/a2n-s/oh-my-fish
[my-oh-my-zsh]:                https://github.com/a2n-s/ohmyzsh
[my-neovim]:                   https://github.com/a2n-s/neovim
[my-polybar-themes]:           https://github.com/a2n-s/polybar-themes
[my-surf]:                     https://github.com/a2n-s/surf
[my-tabbed]:                   https://github.com/a2n-s/tabbed
[my-slock]:                    https://github.com/a2n-s/slock
[mydoc-wallpapers]:            https://a2n-s.github.io/public/doc/config/wallpapers
[mydoc-dmenu]:                 https://a2n-s.github.io/public/doc/config/dmenu
[mydoc-dmscripts]:             https://a2n-s.github.io/public/doc/config/dmscripts
[mydoc-kitty]:                 https://a2n-s.github.io/public/doc/config/kitty
[mydoc-oh-my-bash]:            https://a2n-s.github.io/public/doc/config/bash
[mydoc-oh-my-fish]:            https://a2n-s.github.io/public/doc/config/fish
[mydoc-oh-my-zsh]:             https://a2n-s.github.io/public/doc/config/zsh
[mydoc-neovim]:                https://a2n-s.github.io/public/doc/config/neovim
[mydoc-polybar-themes]:        https://a2n-s.github.io/public/doc/config/polybar
[mydoc-surf]:                  https://a2n-s.github.io/public/doc/config/surf
[mydoc-tabbed]:                https://a2n-s.github.io/public/doc/config/tabbed
[mydoc-slock]:                 https://a2n-s.github.io/public/doc/config/slock

<!-- ------------------------------------------------------------------------------------------------------------------------------- -->
<!-- gallery -->
[mygallery-nitrogen]:          https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-nitrogen.png
[mygallery-bar]:               https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-bar.png
[mygallery-spectrwm1]:         https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-spectrwm1.png
[mygallery-spectrwm2]:         https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-spectrwm2.png
[mygallery-htop]:              https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-htop.png
[mygallery-git]:               https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-git.png
[mygallery-vim]:               https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-vim.png
