if status is-interactive
  fish_add_path -mP $HOME/.cargo/bin
  fish_add_path -mP $HOME/.emacs.d/bin
  fish_add_path -mP $HOME/.local/bin
  fish_add_path -mP $HOME/scripts

  #       _ _
  #  __ _| (_)__ _ ___ ___ ___
  # / _` | | / _` (_-</ -_|_-<
  # \__,_|_|_\__,_/__/\___/__/
  set ALIASES $HOME/.aliases
  [ -f $ALIASES ] && source $ALIASES

  # shows all the media devices connected.
  alias dfm='df -h | grep media | sed "s/\s\+/ /g" | cut -d" " -f6,1'
  # automatically connects to an HDMI-2 monitor on the right of the main laptop screen.
  set MAIN_DISPLAY "eDP-1"
  set SECOND_MONITOR "HDMI-2"
  alias hdmic='xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --right-of $MAIN_DISPLAY'
  alias hdmim='xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --same-as  $MAIN_DISPLAY'
  alias hdmib='xrandr --output $SECOND_MONITOR --brightness'
  alias hdmid='xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --off'
  # automatic copy from terminal output with xclip.
  alias xcc='xclip -selection c'
  # list the packages that match the pattern given after the alias.
  alias pkgl='tail -n +1 .pkgslists/* | grep -e "==>.*<==" -e'
  # a way to manage bluetooth devices.
  alias bmm='blueman-manager'
  # allows to see any csv file directly in the terminal.
  alias seecsv='perl -pe "s/((?<=,)|(?<=^)),/ ,/g;" "$argv" | column -t -s, | less  -F -S -X -K ;'
  # wrapper around lf to support file preview.
  alias lf='~/scripts/lfrun.sh'
  # a complete diagnostic of the current directory.
  alias diag='du -hs (ls (pwd) -A) | sort -h'
  # replacement of vim by nvim.
  alias nv='/usr/bin/nvim'
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

  # to list all the git repositiories inside the home directory or gives a full diagnostic with the extra d.
  alias lgr='find $pwd -type d | grep "\.git\$" | sed "s/\/\.git//"'
  alias lgrd='~/scripts/list.git-repos.diagnostic.sh'
  alias lgrs='lgrd | grep "^./" | sort --field-separator="|" -nrk'
  # launches lazygit.
  alias lg='/usr/bin/lazygit'
  # interacts with my config's git bare repository.
  alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
  alias lcfg='/usr/bin/lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'
  alias tcfg="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME tig --all"
  alias tiga='/usr/bin/tig --all'

  alias tls='tmux ls'               # list the sessions.
  alias tns='tmux new -s'           # creates a new session with name given after the alias.
  alias tat='tmux attach -t'        # attaches to the session given after the alias.
  alias tkt='tmux kill-session -t'  # kills the session with name given after the alias.

  alias ncua='nmcli c up "a2n-s"'    # connects to my 4g, change to what you want.
  alias ncue='nmcli c up "eduroam"'  # connects to the network of my school.

  alias jpy='jupyter'
  alias jnb='jupyter-notebook'

  alias sdn='shutdown now -h'
  alias sdnr='shutdown now -h -r'

  alias cp='cp -i'
  alias ln='ln -i'
  alias rm='rm -i'
  alias rmv='rm -v'
  alias rmr='rm -r'
  alias rmrf='rm -rf'


  # alias reboot='sudo reboot'
  # alias sctl='sudo systemctl'

  # enable color support of ls and also add handy aliases
  if type -q exa
    alias ls 'exa -g --icons'
    alias ll "exa -l -g --icons"
    alias lla "exa -l -g -a --icons"
    alias tr "exa -g --icons --tree"
  else
    alias ls 'ls --color=auto'
    alias ll 'ls -l --color=auto'
    alias lla 'ls -la --color=auto'
    alias tr 'tree'
  end
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  alias kicat="kitty +kitten icat"
  alias kthemes="kitty +kitten themes"

  alias qtheme="$HOME/.config/qtile/scripts/qtile-change-theme.sh"
  alias qbar="$HOME/.config/qtile/scripts/qtile-bar.sh"
  alias qrestart="qtile cmd-obj -o cmd -f restart"
  alias qcmd="qtile cmd-obj -o cmd -f"
  alias qprompt="qtile cmd-obj -o cmd -f spawncmd"
  # alias qlog="cat $HOME/.local/share/qtile/qtile.log | less"
  alias qlog="bat $HOME/.local/share/qtile/qtile.log"
  alias qstop="qtile cmd-obj -o cmd -f shutdown"

  #        _
  #  _ __ (_)___ __
  # | '  \| (_-</ _|
  # |_|_|_|_/__/\__|
  # disables the caps lock key.
  xtcl.sh -d -q

  # starship init fish | source
  source ~/.local/share/omf/pkg/colorman/init.fish

  set CLOUDSDK_PYTHON "/usr/bin/python3"
  if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    . "$HOME/google-cloud-sdk/path.fish.inc"
  end

  fish_vi_key_bindings

  if set -q KITTY_INSTALLATION_DIR
      set --global KITTY_SHELL_INTEGRATION enabled
      source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
      set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
  end
end
