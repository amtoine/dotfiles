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

#        ___                                       __         __                                __               __                 __  __  _
#       <  /     ____ ____  ____  ___  _________ _/ /  ____  / /_        ____ ___  __  __      / /_  ____ ______/ /_     ________  / /_/ /_(_)___  ____ ______
#       / /     / __ `/ _ \/ __ \/ _ \/ ___/ __ `/ /  / __ \/ __ \______/ __ `__ \/ / / /_____/ __ \/ __ `/ ___/ __ \   / ___/ _ \/ __/ __/ / __ \/ __ `/ ___/
#      / /_    / /_/ /  __/ / / /  __/ /  / /_/ / /  / /_/ / / / /_____/ / / / / / /_/ /_____/ /_/ / /_/ (__  ) / / /  (__  )  __/ /_/ /_/ / / / / /_/ (__  )
#     /_/(_)   \__, /\___/_/ /_/\___/_/   \__,_/_/   \____/_/ /_/     /_/ /_/ /_/\__, /     /_.___/\__,_/____/_/ /_/  /____/\___/\__/\__/_/_/ /_/\__, /____/
#             /____/                                                            /____/                                                          /____/

# Path to your oh-my-bash installation.
export OSH=$XDG_DATA_HOME/oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
# OSH_THEME="random" # (...please let it be pie... please be some pie..)
# OSH_THEME="agnoster"
# OSH_THEME="powerline"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder


#        ___                                   __     __  _
#       |__ \      _________  ____ ___  ____  / /__  / /_(_)___  ____
#       __/ /     / ___/ __ \/ __ `__ \/ __ \/ / _ \/ __/ / __ \/ __ \
#      / __/_    / /__/ /_/ / / / / / / /_/ / /  __/ /_/ / /_/ / / / /
#     /____(_)   \___/\____/_/ /_/ /_/ .___/_/\___/\__/_/\____/_/ /_/
#                                   /_/

# Which completions would you like to load? (completions can be found in ~/repos/oh-my-bash/completions/*)
# Custom completions may be added to ~/repos/oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)


#        _____            __                                __               __             ___
#       |__  /     ____  / /_        ____ ___  __  __      / /_  ____ ______/ /_     ____ _/ (_)___ _________  _____
#        /_ <     / __ \/ __ \______/ __ `__ \/ / / /_____/ __ \/ __ `/ ___/ __ \   / __ `/ / / __ `/ ___/ _ \/ ___/
#      ___/ /    / /_/ / / / /_____/ / / / / / /_/ /_____/ /_/ / /_/ (__  ) / / /  / /_/ / / / /_/ (__  )  __(__  )
#     /____(_)   \____/_/ /_/     /_/ /_/ /_/\__, /     /_.___/\__,_/____/_/ /_/   \__,_/_/_/\__,_/____/\___/____/
#                                           /____/

# Which aliases would you like to load? (aliases can be found in ~/repos/oh-my-bash/aliases/*)
# Custom aliases may be added to ~/repos/oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
  chmod
  ls
)


#        __ __             __            _
#       / // /      ____  / /_  ______ _(_)___  _____
#      / // /_     / __ \/ / / / / __ `/ / __ \/ ___/
#     /__  __/    / /_/ / / /_/ / /_/ / / / / (__  )
#       /_/ (_)  / .___/_/\__,_/\__, /_/_/ /_/____/
#               /_/            /____/

# Which plugins would you like to load? (plugins can be found in ~/repos/oh-my-bash/plugins/*)
# Custom plugins may be added to ~/repos/oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # git
  bashmarks
)

source "$OSH/oh-my-bash.sh"


#         ______                                               _____                        __  _
#        / ____/     __  __________  _____   _________  ____  / __(_)___ ___  ___________ _/ /_(_)___  ____
#       /___ \      / / / / ___/ _ \/ ___/  / ___/ __ \/ __ \/ /_/ / __ `/ / / / ___/ __ `/ __/ / __ \/ __ \
#      ____/ /_    / /_/ (__  )  __/ /     / /__/ /_/ / / / / __/ / /_/ / /_/ / /  / /_/ / /_/ / /_/ / / / /
#     /_____/(_)   \__,_/____/\___/_/      \___/\____/_/ /_/_/ /_/\__, /\__,_/_/   \__,_/\__/_/\____/_/ /_/
#                                                                /____/
#         ______  ___                                       __
#        / ____/ <  /     ____ ____  ____  ___  _________ _/ /
#       /___ \   / /     / __ `/ _ \/ __ \/ _ \/ ___/ __ `/ /
#      ____/ /_ / /_    / /_/ /  __/ / / /  __/ /  / /_/ / /
#     /_____/(_)_/(_)   \__, /\___/_/ /_/\___/_/   \__,_/_/
#                      /____/

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

#         ______  ___                  _
#        / ____/ |__ \      ____ ___  (_)_________
#       /___ \   __/ /     / __ `__ \/ / ___/ ___/
#      ____/ /_ / __/_    / / / / / / (__  ) /__
#     /_____/(_)____(_)  /_/ /_/ /_/_/____/\___/

# define XDG environment variables.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# move all moveable config to the right location, outside $HOME.
export HISTFILE="$XDG_STATE_HOME"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOOMDIR="$XDG_CONFIG_HOME/doom"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GOPATH="$XDG_DATA_HOME"/go
export GRIPHOME="$XDG_CONFIG_HOME/grip"
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export _Z_DATA="$XDG_DATA_HOME/z"
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal
export KERAS_HOME="$XDG_STATE_HOME/keras"
export EMACS_HOME="$HOME/.emacs.d"
export MUJOCO_BIN="$HOME/.mujoco/mujoco210/bin"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

export PATH="$HOME/.local/bin:$EMACS_HOME/bin:$CARGO_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MUJOCO_BIN"

# changes the editor in the terminal, to edit long commands.
export EDITOR='vim'
export VISAL='vim'
set -o vi

### SET MANPAGER
### Uncomment only one of these!
# make "less" man pages prettier
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)  # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 2)  # green
export LESS_TERMCAP_so=$(tput bold; tput rev; tput setaf 3)  # yellow
export LESS_TERMCAP_se=$(tput smul; tput sgr0)
export LESS_TERMCAP_us=$(tput bold; tput bold; tput setaf 1)  # red
export LESS_TERMCAP_me=$(tput sgr0)
### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
### "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

# activates virtualenvwrapper to manage python virtual environments.
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
# where to put the binaries of virtualenvwrapper.
export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
if [[ ! -d $WORKON_HOME ]]; then mkdir -p $WORKON_HOME; fi
source $HOME/.local/bin/virtualenvwrapper.sh

# disable my broken capslock key.
amtoine-xtcl -d -q

# usage: extr <file>
extr ()
{
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"    ;;
      *.tar.gz)    tar xzf "$1"    ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xf "$1"     ;;
      *.tbz2)      tar xjf "$1"    ;;
      *.tgz)       tar xzf "$1"    ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *.deb)       ar x "$1"       ;;
      *.tar.xz)    tar xf "$1"     ;;
      *.tar.zst)   tar xf "$1"     ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

## before prompt ###
pokemon-colorscripts -r

## the prompt ###
eval "$(starship init bash)"

## after prompt ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

CLOUDSDK_PYTHON="/usr/bin/python3"
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source $HOME/.config/broot/launcher/bash/br

# Bind Ctrl L to clear screen and ls
bind -x '"\C-l": clear; ls'
