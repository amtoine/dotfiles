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
# License:      https://github.com/a2n-s/dotfiles/LICENSE
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
OSH_THEME="random" # (...please let it be pie... please be some pie..)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
  git
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

#         ______  ___              ___
#        / ____/ |__ \      ____ _/ (_)___ _________  _____
#       /___ \   __/ /     / __ `/ / / __ `/ ___/ _ \/ ___/
#      ____/ /_ / __/_    / /_/ / / / /_/ (__  )  __(__  )
#     /_____/(_)____(_)   \__,_/_/_/\__,_/____/\___/____/

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/repos/oh-my-bash"

#   ___   ___   _         _
#  | __| |_  ) / |  _ __ (_)___ __
#  |__ \_ / / _| | | '  \| (_-</ _|
#  |___(_)___(_)_| |_|_|_|_/__/\__|
#
# shows all the media devices connected.
alias dfm='df -h | grep media | sed "s/\s\+/ /g" | cut -d" " -f6,1'

# automatically connects to an HDMI-2 monitor on the right of the main laptop screen.
MAIN_DISPLAY="eDP-1"
SECOND_MONITOR="HDMI-2"
alias hdmic='xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --right-of $MAIN_DISPLAY'
alias hdmim='xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --same-as  $MAIN_DISPLAY'
alias hdmib='xrandr --output $SECOND_MONITOR --brightness'
alias hdmid='xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --off'

# automatic copy from terminal output with xclip.
alias xcc='xclip -selection c'

# list the packages that match the pattern given after the alias.
alias pkgl='tail -n +1 .pkgslists/* | grep -e "==>.*<==" -e'

# uncomment to use colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# a way to manage bluetooth devices.
alias bmm='blueman-manager'

# to list all the git repositiories inside the home directory.
alias lgr='find $HOME -type d | grep "\.git\$" | sed "s/\/\.git//"'

# allows to see any csv file directly in the terminal.
alias seecsv='perl -pe "s/((?<=,)|(?<=^)),/ ,/g;" "$argv" | column -t -s, | less  -F -S -X -K ;'
#
#   ___   ___   ___        _ _
#  | __| |_  ) |_  )  __ _(_) |_
#  |__ \_ / / _ / /  / _` | |  _|
#  |___(_)___(_)___| \__, |_|\__|
#                   |___/
alias g='git'
# interacts with my config's git bare repository.
alias cfg='/usr/bin/git --git-dir=/home/ants/.dotfiles --work-tree=/home/ants'

#   ___   ___   ____  _
#  | __| |_  ) |__ / | |_ _ __ _  ___ __
#  |__ \_ / / _ |_ \ |  _| '  \ || \ \ /
#  |___(_)___(_)___/  \__|_|_|_\_,_/_\_\
#
alias tls='tmux ls'               # list the sessions.
alias tns='tmux new -s'           # creates a new session with name given after the alias.
alias tat='tmux attach -t'        # attaches to the session given after the alias.
alias tkt='tmux kill-session -t'  # kills the session with name given after the alias.

#   ___   ___  _ _             _                  _
#  | __| |_  )| | |   _ _  ___| |___ __ _____ _ _| |__
#  |__ \_ / / |_  _| | ' \/ -_)  _\ V  V / _ \ '_| / /
#  |___(_)___(_)|_|  |_||_\___|\__|\_/\_/\___/_| |_\_\
#
alias ncua='nmcli c up "a2n-s"'    # connects to my 4g, change to what you want.
alias ncue='nmcli c up "eduroam"'  # connects to the network of my school.

#   ___   ___   ___     _                _
#  | __| |_  ) | __|   (_)_  _ _ __ _  _| |_ ___ _ _
#  |__ \_ / / _|__ \   | | || | '_ \ || |  _/ -_) '_|
#  |___(_)___(_)___/  _/ |\_,_| .__/\_, |\__\___|_|
#                    |__/     |_|   |__/
alias jpy='jupyter'
alias jnb='jupyter-notebook'

#   ___   ___    __      _        _      _
#  | __| |_  )  / /   __| |_ _  _| |_ __| |_____ __ ___ _
#  |__ \_ / / _/ _ \ (_-< ' \ || |  _/ _` / _ \ V  V / ' \
#  |___(_)___(_)___/ /__/_||_\_,_|\__\__,_\___/\_/\_/|_||_|
#
alias sdn='shutdown now -h'
alias sdnr='shutdown now -h -r'

#   ___   ___  ____
#  | __| |_  )|__  |  _ _ _ __
#  |__ \_ / / _ / /  | '_| '  \
#  |___(_)___(_)_/   |_| |_|_|_|
#
alias rmv='rm -v'
alias rmi='rm -i'
alias rmr='rm -r'
alias rmrf='rm -rf'
#
#   ___   ___   ___
#  | __| |_  ) ( _ )  _ __  __ _ __ _ __  __ _ _ _
#  |__ \_ / / _/ _ \ | '_ \/ _` / _| '  \/ _` | ' \
#  |___(_)___(_)___/ | .__/\__,_\__|_|_|_\__,_|_||_|
#                    |_|
alias p='sudo pacman'
alias pu='sudo pacman -Syu'

#   ___   ___  ___          _                                              _
#  | __| |_  )/ _ \  __ ___| |___ _ _ ___  __ ___ _ __  _ __  __ _ _ _  __| |___
#  |__ \_ / / \_, / / _/ _ \ / _ \ '_(_-< / _/ _ \ '  \| '  \/ _` | ' \/ _` (_-<
#  |___(_)___(_)_/  \__\___/_\___/_| /__/ \__\___/_|_|_|_|_|_\__,_|_||_\__,_/__/
#
# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias lalf='ls -alF'
alias la='ls -A'
alias lcf='ls -CF'
alias ll='ls -l'
alias llha='ls -lha'

#   ___   ___   _  __
#  | __| |_  ) / |/  \   __ _ _ __ _ __ ___
#  |__ \_ / / _| | () | / _` | '_ \ '_ (_-<
#  |___(_)___(_)_|\__/  \__,_| .__/ .__/__/
#                            |_|  |_|
alias discord="$HOME/Discord/Discord > /dev/null 2> /dev/null &"

#         ______  _____                _
#        / ____/ |__  /     ____ ___  (_)_________
#       /___ \    /_ <     / __ `__ \/ / ___/ ___/
#      ____/ /_ ___/ /    / / / / / / (__  ) /__
#     /_____/(_)____(_)  /_/ /_/ /_/_/____/\___/

export PATH=$PATH:$HOME/scripts:$HOME/.local/bin
# disables the caps lock key.
xtcl.sh -d -q

# changes the editor in the terminal, to edit long commands.
export EDITOR='vim'
export VISUAL='vim'
set -o vi

# activates virtualenvwrapper to manage python virtual environments.
export WORKON_HOME=$HOME/.venvs
if [[ ! -d $WORKON_HOME ]]; then mkdir -p $WORKON_HOME; fi
source $HOME/.local/bin/virtualenvwrapper.sh

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


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
