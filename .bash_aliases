#          _               _                      _ _
#         | |             | |                    | (_)
#         | |__   __ _ ___| |__              __ _| |_  __ _ ___  ___  ___
#         | '_ \ / _` / __| '_ \            / _` | | |/ _` / __|/ _ \/ __|
#      _  | |_) | (_| \__ \ | | |          | (_| | | | (_| \__ \  __/\__ \
#     (_) |_.__/ \__,_|___/_| |_|           \__,_|_|_|\__,_|___/\___||___/
#                                  ______
#                                 |______|
# full config can be found at: https://github.com/a2n-s/dotfiles

# >>> head of .bash_aliases.
# uncomment to see the execution order of bash files at startup.
#echo ".bash_aliases"
# <<<

# >>> misc.
# a simple chronometer.
alias chrono='date1=`date +%s`; while true; do echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; done'

# shows all the media devices connected.
alias dfm='df -h | grep media | sed "s/\s\+/ /g" | cut -d" " -f6,1'

# automatically connects to an HDMI-2 monitor on the right of the main laptop screen.
alias xrandr-run='xrandr --output eDP-1 --auto --output HDMI-2 --mode 1920x1080 --rate 60 --right-of eDP-1'

# uncomment to assemble some assembly using vasm.
#alias vasm6502_oldstyle='~/Documents/softwares/vasm/vasm/vasm6502_oldstyle'

# uncomment to enable custom audio management for bluetooth devices.
#alias audio-laptop='pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo'
#alias audio-hdmi='pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo'

# automatic copy from terminal output with xclip.
alias xcc='xclip -selection c'

# list the packages that match the pattern given after the alias.
alias pkgl='tail -n +1 .pkgslists/* | grep -e "==>.*<==" -e'
# interacts with my config's git bare repository.
alias cfg='/usr/bin/git --git-dir=/home/ants/.dotfiles --work-tree=/home/ants'

# uncomment to use colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# a way to manage bluetooth devices.
alias bmm='blueman-manager'

# to list all the git repositiories inside the home directory.
alias lgr='find $HOME -type d | grep "\.git$" | sed "s/\/\.git//"'

# allows to see any csv file directly in the terminal.
alias seecsv='perl -pe "s/((?<=,)|(?<=^)),/ ,/g;" "$@" | column -t -s, | less  -F -S -X -K ;'
# <<<

# >>> tmux shortcuts.
alias tls='tmux ls'               # list the sessions.
alias tns='tmux new -s'           # creates a new session with name given after the alias.
alias tat='tmux attach -t'        # attaches to the session given after the alias.
alias tkt='tmux kill-session -t'  # kills the session with name given after the alias.
# <<<

# >>> network shortcuts.
alias ncua='nmcli c up "a2n-s"'    # connects to my 4g, change to what you want.
alias ncue='nmcli c up "eduroam"'  # connects to the network of my school.
# <<<

# >>> jupyter shortcuts.
alias jpy='jupyter'
alias jnb='jupyter-notebook'
# <<<

# >>> shutdown shortcuts.
alias sdn='shutdown now -h'
alias sdnr='shutdown now -h -r'
# <<<

# >>> color commands.
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias lalf='ls -alF'
alias la='ls -A'
alias lcf='ls -CF'
alias ll='ls -l'
alias llha='ls -lha'
# <<<


# >>> applications.
alias discord="$HOME/Discord/Discord > /dev/null 2> /dev/null &"
# <<<
