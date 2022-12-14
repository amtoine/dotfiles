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

# shows all the media devices connected.
alias dfm='df -h | grep media | sed "s/\s\+/ /g" | cut -d" " -f6,1'
# automatic copy from terminal output with xclip.
alias xcc='xclip -selection c'
# list the packages that match the pattern given after the alias.
alias pkgl='tail -n +1 .pkgslists/* | grep -e "==>.*<==" -e'
# a way to manage bluetooth devices.
alias bmm='blueman-manager'
# allows to see any csv file directly in the terminal.
alias seecsv='perl -pe "s/((?<=,)|(?<=^)),/ ,/g;" "$argv" | column -t -s, | less  -F -S -X -K ;'
# a complete diagnostic of the current directory.
alias diag='du -hs (ls (pwd) -A) | sort -h'
# the lazycli tool.
alias lac="$HOME/.local/bin/lazycli"
# to source this quicker.
alias sbrc="source $HOME/.bashrc"
# prettier ncdu.
alias ncdu="ncdu --color dark"
# generate a random sequence of characters.
alias rand="tr -dc 'A-Za-z0-9!@#\$%^&*()' < /dev/urandom  | head -c"
# wrapper of docker with rights.
# alias docker="sudo docker"
# wrapper around btop to bypass lack of locale.
alias btop="btop --utf-force"
alias clear="clear; echo; seq 1 $(tput cols) | sort -R | gspark | lolcat -t; echo"
alias repo='cd $(ghq root)/$(ghq list | fzf)'

# to list all the git repositiories inside the home directory or gives a full diagnostic with the extra d.
alias lgr='find $pwd -type d | grep "\.git\$" | sed "s/\/\.git//"'
# launches lazygit.
alias lg='/usr/bin/lazygit'
# interacts with my config's git bare repository.
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias tiga='/usr/bin/tig --all'

alias tls='tmux ls'               # list the sessions.
alias tns='tmux new -s'           # creates a new session with name given after the alias.
alias tat='tmux attach -t'        # attaches to the session given after the alias.
alias tkt='tmux kill-session -t'  # kills the session with name given after the alias.

alias jpy='jupyter'
alias jnb='jupyter-notebook'

alias lout='arcolinux-logout'

alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -i'
alias rmv='rm -v'
alias rmr='rm -r'
alias rmrf='rm -rf'

# enable color support of ls and also add handy aliases
if command -v exa &> /dev/null; then
  alias ls='exa -g --icons --group-directories-first'
  alias ll="exa -l -g --icons --group-directories-first"
  alias lla="exa -l -g -a --icons --group-directories-first"
  alias tree="exa -g --icons --tree --group-directories-first"
else
  alias ls='ls --color=auto --group-directories-first'
  alias ll='ls -l --color=auto --group-directories-first'
  alias lla='ls -la --color=auto --group-directories-first'
fi
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if command -v devour &> /dev/null; then
  alias feh='devour feh'
  alias mpv='devour mpv'
  alias okular='devour okular'
  alias kolourpaint='devour kolourpaint'
fi
alias pdf='okular $(find "\.pdf$" . | fzf)'


if [ "$TERM" = "xterm-kitty" ]; then
  alias kicat="kitty +kitten icat"
fi

if pgrep "qtile" > /dev/null
then
  alias qtheme="amtoine-themes -C=qtile"
  alias qbar="$HOME/.config/qtile/scripts/bar.sh"
  alias qrestart="qtile cmd-obj -o cmd -f restart"
  alias qcmd="qtile cmd-obj -o cmd -f"
  alias qprompt="qtile cmd-obj -o cmd -f spawncmd"
  alias qstop="qtile cmd-obj -o cmd -f shutdown"
fi

if command -v bat &> /dev/null; then
  alias qlog="bat $HOME/.local/share/qtile/qtile.log"
  alias cat="bat"
else
  alias qlog="cat $HOME/.local/share/qtile/qtile.log | less"
fi

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias xdg-ninja=$HOME/ghq/github.com/amtoine/xdg-ninja/xdg-ninja.sh

alias xonsh="xonsh --rc $XDG_CONFIG_HOME/xonsh/xonshrc"

alias screencast="screencast --output-dir=$HOME/videos/screencast"
alias mcli="mcli --config-dir $HOME/.config/mcli"
