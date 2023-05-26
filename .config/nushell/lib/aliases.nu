#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

# git
export alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
export alias lg = ^lazygit

export alias git-ipfs = git -C $env.IPFS_PATH

# exit the shell
export alias :q = exit
export alias q = exit

# misc
export alias cb = ^cbonsai --infinite --live --base=1 --wait=2 --time=10

export alias sl = sl -aw -20
export def lsg [] { ls | sort-by type name -i | grid -c | str trim }

export alias "zk git" = git -C $env.ZK_NOTEBOOK_DIR

export alias v = edit
