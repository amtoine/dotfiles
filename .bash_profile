echo "$HOME/.bash_profile"
[ ! -s ~/.config/mpd/pid ] && mpd
if [[ $(fgconsole 2> /dev/null) == 1 ]]; then
    echo "Starting x..."
    exec startx -- vt1;
else
  [[ -f ~/.bashrc ]] && . ~/.bashrc
fi

source /home/amtoine/.config/broot/launcher/bash/br
