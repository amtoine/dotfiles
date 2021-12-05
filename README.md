# This is my personal config repository for archlinux.
The following document gives a high level overview of my linux config.  
This particular config has been tested on ArchLinux only (last update on 11/14/21).  
Thus, only `pacman` and `yay` have been used and tested as arch and AUR packages managers respectively.  
The reader is highly adviced to search the internet and in particular the [ArchWiki](https://archlinux.org/), **EVEN in NON arch-based systems!!**

First, an overview of the repo is given with the project architecture and a brief explaination of all the files involved in [section 1](https://github.com/a2n-s/dotfiles/tree/main/#1-overview-and-architecture-toc).  
The documentation is presented and linked in [sections 2](https://github.com/a2n-s/dotfiles/tree/main/#2-documentation-toc).  
Finally, ways to contribute to this project are put forward in [section 3](https://github.com/a2n-s/dotfiles/tree/main/#3-contribute-toc) for who is interested and a gallery of photos is presented in [section 4](https://github.com/a2n-s/dotfiles/tree/main/#4-gallery-toc), 
to give an idea of the final rendering of the config.  

If you want a quick brief of what dotfiles really are, I recommend the following video of *FireShip*: https://www.youtube.com/watch?v=r_MpUP6aKiQ.

## Table Of Content.
- **1** [**Overview and architecture.**](https://github.com/a2n-s/dotfiles/tree/main/#1-overview-and-architecture-toc)
- **2** [**Documentation.**](https://github.com/a2n-s/dotfiles/tree/main/#2-documentation-toc)
- **3** [**Contribute.**](https://github.com/a2n-s/dotfiles/tree/main/#3-contribute-toc)
- **4** [**Gallery.**](https://github.com/a2n-s/dotfiles/tree/main/#4-gallery-toc)

## 1. Overview and architecture. [[toc](https://github.com/a2n-s/dotfiles/tree/main/#table-of-content)]
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
- https://www.atlassian.com/git/tutorials/dotfiles: a blog post about *bare* repositories.
- https://www.youtube.com/watch?v=tBoLDpTWVOM&t=879s: if you want to see the creation of such a repository step by step.
```
$HOME
|-- [d]  .config                                 -- main config directory
|   |-- [d]  alacritty                             --  the alacritty terminal emulator.
|   |   `-- [-]  alacritty.yml
|   |-- [d]  cmus                                  --  my favorite music player based on ncurses.
|   |   |-- [-]  autosave
|   |   `-- [-]  lib.pl
|   |-- [d]  htop                                  -- my process monitor.
|   |   `-- [-]  htoprc
|   |-- [d]  neofetch                              -- my logo printer.
|   |   |-- [d]  ascii                               -- all used arts.
|   |   |   |-- [-]  christmas.art
|   |   |   |-- [-]  fall-leaf.art
|   |   |   |-- [-]  halloween.art
|   |   |   |-- [-]  lolo.art
|   |   |   |-- [-]  spring-flower.art
|   |   |   |-- [-]  summer-sun.art
|   |   |   `-- [-]  winter-snow.art
|   |   |-- [-]  .neofetchrc                         -- lauches the right art based on date.
|   |   `-- [-]  config.conf                         -- the actual config for basic use.
|   |-- [d]  nitrogen                              -- my wallpaper manager.
|   |   `-- [-]  nitrogen.cfg
|   |-- [d]  spectrwm                              -- the spectrWM tilling window manager.
|   |   |-- [-]  spectrwm.conf 
|   |   |-- [-]  spectrwm_fr.conf
|   |   `-- [-]  spectrwm_us.conf
|   `-- [d]  vifm                                  -- the file manager.
|       |-- [d]  colors
|       |   `-- [-]  molokai.vifm
|       `-- [-]  vifmrc
|-- [d]  .pkgslists                              -- packages.
|   |-- [-]  allpkglist.txt                        -- the list of all installed packages.
|   |-- [-]  foreignpkglist.txt                    -- the list of AUR packages.
|   |-- [-]  optdeplist.txt                        -- the list of optional packages.
|   `-- [-]  pkglist.txt                           -- the list of arch packages.
|-- [d]  scripts                                 -- my scripts.
|   |-- [-]  _countdown.sh                         -- a countdown with alarm (deprecated).
|   |-- [-]  _parse_git_info.sh                    -- parses the repo information if available.
|   |-- [-]  _shortwd.sh                           -- gives a short directory name for prompt.
|   |-- [-]  _stopwatch.sh                         -- a stopwatch (deprecated)
|   |-- [-]  prompt.sh                             -- a binary prompt that executes commands.
|   |-- [-]  screenshot.sh                         -- takes screeshots with scrot.
|   |-- [-]  spectrWM-baraction.sh                 -- controls the spectrWM bar.
|   |-- [-]  togkb.sh                              -- toggles the keyboard layout.
|   |-- [-]  tree2md.sh                            -- transforms a directory into a tree for .md files.
|   |-- [l]  upl.sh -> /etc/pacman.d/hooks.bin/upl -- updates the list of installed packages.
|   |-- [-]  wvenv.sh                              -- shows current python environment.
|   `-- [-]  xtcl.sh                               -- disables my broken caps lock key.
|-- [-]  .bash_aliases                           -- all my command aliases.
|-- [-]  .bash_logout                            -- what bash should do on logout.
|-- [-]  .bash_profile                           -- runs bash and starts the WM on startup.
|-- [-]  .bashrc                                 -- runs config stuff to make the experience what it is.
|-- [-]  .gitconfig                              -- all my git config.
|-- [-]  .profile                                -- profile script.
|-- [-]  .tmux.conf                              -- my tmux config file.
|-- [-]  .vimrc                                  -- all needed configuration for a pretty vim.
|-- [-]  .xinitrc                                -- what to do when x starts.
|-- [-]  .xscreensaver                           -- my config when the machine is idle or manually locked.
`-- [-]  README.md
```


## 2. Documentation. [[toc](https://github.com/a2n-s/dotfiles/tree/main/#table-of-content)]
The doc of my dotfiles can be found on my personal website [here](https://a2n-s.github.io/graphic.github.io/) under the `config/doc/` domain.  
In this section, some general ideas are given and the lists of the programs, scripts and other stuff I use are put forward.

#### Installation.
For now, the only way to install my config is to manually:
- backup your config files.
- copy mine in replacement.

For instance, let us say that you want to replace your `vim` config with mine, you can either go to the section below
or directly:
- clone the repo with `git clone https://github.com/a2n-s/dotfiles.git` or `git clone git@github.com:a2n-s/dotfiles.git`.
- place your version of the `.vimrc` file inside a backup directory or archive.
- copy my `.vimrc` file in replacement of yours.
- follow additional instructions in the dedicated section ([here](.doc/programs/vim/) for `vim`).
- enjoy your new `vim` experience!

I will try, in the future, to provide an `install.sh` script to (1) select what part of the config to install,
(2) backup the choosen files of the user inside a safe place and (3) install my config files in replacement.  
I also plan to develop an `uninstall.sh` script that does the exact inverse to restore the config of the user
just as it was before the installation.

#### Dependencies.
In this config, some part, i.e. commands and programs like window managers or text editors, requires some dependencies.  
To install dependencies, one has two options:
- install them by hand, individually -> use `pacman -F <command>` or `yay -F <command>` to find the name of the package
containing the command. Then issue `pacman -S <package>` or `yay -S <package>` to install them.
- install all the packages I have on my system by using the lists in [`pkgslists`] and `pacman` or `yay` to install them.

#### List of programs:
- [x] `alacritty`
- [x] `bash`
- [x] `dmenu` ([\*](https://github.com/a2n-s/dmenu))
- [x] `git`
- [x] `htop`
- [x] `neofetch`
- [x] `nitrogen`
- [x] `spectrWM`
- [ ] `tmux`
- [x] `vifm`
- [x] `vim`
- [x] `x`
- [x] `xscreensaver`

#### List of scripts:
- [ ] `_countdown`
- [x] `_parse_git_info`
- [x] `_shortwd`
- [ ] `_stopwatch`
- [x] `prompt`
- [x] `screenshot.sh`
- [x] `spectrWM-baraction.sh`
- [x] `togkb.sh`
- [x] `tree2md`
- [x] `upl`
- [x] `wvenv`
- [x] `xtcl`

#### Other programs and stuff I use:
- [x] virtualenvwrapper: tutorials [in english](https://virtualenvwrapper.readthedocs.io/en/latest/) or [in french](https://python-guide-pt-br.readthedocs.io/fr/latest/dev/virtualenvs.html).
- [x] some wallpapers ([\*](https://github.com/a2n-s/wallpapers))
- [x] my fork of [dt's dmscripts](https://gitlab.com/dwt1/dmscripts) ([\*](https://github.com/a2n-s/dmscripts))

(\*) comes from another repo.


## 3. Contribute. [[toc](https://github.com/a2n-s/dotfiles/tree/main/#table-of-content)]
YOU can contribute to this project in the wonderfull world of linux, arch and configuration!
- if you like the overview, try to install the config and see what it looks like!
- if you like the config, please share it to whoever could be interested.
- if you stumble upon bugs, ideas, new amazing color palettes or alternatives,
do not hesitate to contact me, either via email, github issues or pull requests!

## 4. Gallery. [[toc](https://github.com/a2n-s/dotfiles/tree/main/#table-of-content)]
| ![My wallpaper.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-nitrogen.png) |
|:--:|
| *My wallpaper.* |

| ![My bar.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-bar.png) |
|:--:|
| *My bar.* |

| ![SpectrWM in a dual monitor setup: left monitor selected.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-spectrwm1.png) |
|:--:|
| *SpectrWM in a dual monitor setup: left monitor selected.* |

| ![SpectrWM in a dual monitor setup: right monitor selected.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-spectrwm2.png) |
|:--:|
| *SpectrWM in a dual monitor setup: right monitor selected.* |

| ![A screenshot of seing all processes.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-htop.png) |
|:--:|
| *A screenshot of seing all processes.* |

| ![A screenshot of being in a git repository.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-git.png) |
|:--:|
| *A screenshot of being in a git repository.* |

| ![A screenshot of being in vim.](https://a2n-s.github.io/public/res/doc/config/dotfiles/gallery-vim.png) |
|:--:|
| *A screenshot of being in vim.* |

[`pkgslists`]: .pkgslists
