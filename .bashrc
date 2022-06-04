#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#          _               _
#         | |             | |
#         | |__   __ _ ___| |__  _ __ ___
#         | '_ \ / _` / __| '_ \| '__/ __|
#      _  | |_) | (_| \__ \ | | | | | (__
#     (_) |_.__/ \__,_|___/_| |_|_|  \___|
#
# Description:  ~/.bashrc: executed by bash(1) for non-login shells.
#               see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
#               for examples
# Dependencies: cal, xtcl.sh, _shortwd.sh & _parse_git_info.sh at https://github.com/a2n-s/dotfiles/tree/main/scripts
#               colorscript at https://gitlab.com/dwt1/shell-color-scripts, starship
#               fortune, ponysay, virtualenvwrapper, nvim, bash-insulter
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

#        ___                                       __         __                                __               __                 __  __  _
#       <  /     ____ ____  ____  ___  _________ _/ /  ____  / /_        ____ ___  __  __      / /_  ____ ______/ /_     ________  / /_/ /_(_)___  ____ ______
#       / /     / __ `/ _ \/ __ \/ _ \/ ___/ __ `/ /  / __ \/ __ \______/ __ `__ \/ / / /_____/ __ \/ __ `/ ___/ __ \   / ___/ _ \/ __/ __/ / __ \/ __ `/ ___/
#      / /_    / /_/ /  __/ / / /  __/ /  / /_/ / /  / /_/ / / / /_____/ / / / / / /_/ /_____/ /_/ / /_/ (__  ) / / /  (__  )  __/ /_/ /_/ / / / / /_/ (__  )
#     /_/(_)   \__, /\___/_/ /_/\___/_/   \__,_/_/   \____/_/ /_/     /_/ /_/ /_/\__, /     /_.___/\__,_/____/_/ /_/  /____/\___/\__/\__/_/_/ /_/\__, /____/
#             /____/                                                            /____/                                                          /____/

# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

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

export PATH="$HOME/.local/bin:$HOME/.emacs.d/bin:$HOME/.cargo/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/ants/.mujoco/mujoco210/bin"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export HISTFILE="${XDG_STATE_HOME}"/bash/history
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
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

# changes the editor in the terminal, to edit long commands.
export EDITOR='emacsclient -nw -c -a "emacs"'
export VISAL='emacsclient -nw -c -a "emacs"'
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
export WORKON_HOME=$HOME/.virtualenvs
if [[ ! -d $WORKON_HOME ]]; then mkdir -p $WORKON_HOME; fi
source $HOME/.local/bin/virtualenvwrapper.sh

xtcl.sh -d -q

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
