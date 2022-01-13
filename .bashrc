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
export OSH=$HOME/repos/oh-my-bash

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
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
  example
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

source $OSH/oh-my-bash.sh


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

export PATH=$PATH:$HOME/scripts:$HOME/.local/bin:$HOME/.cargo/bin

# changes the editor in the terminal, to edit long commands.
export EDITOR='nvim'
export VISUAL='nvim'
set -o vi

# activates virtualenvwrapper to manage python virtual environments.
export WORKON_HOME=$HOME/.venvs
if [[ ! -d $WORKON_HOME ]]; then mkdir -p $WORKON_HOME; fi
source $HOME/.local/bin/virtualenvwrapper.sh

xtcl.sh -d -q

#if [[ -f ~/.config/neofetch/.neofetchrc ]]; then
#	. ~/.config/neofetch/.neofetchrc;
#else
#	neofetch;
#fi

# figlet -tf slant "welcome in BASH"
# colorscript -e elfman
# cal -3
# fortune -c | cowthink -f $(find /usr/share/cows -type f | shuf -n 1)
fortune -c | ponysay --pony

eval "$(starship init bash)"

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

. /home/ants/torch/install/bin/torch-activate


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
