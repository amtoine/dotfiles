if status is-interactive
  fish_add_path -mP $HOME/.cargo/bin
  fish_add_path -mP $HOME/.emacs.d/bin
  fish_add_path -mP $HOME/.local/bin

  function spark -d "sparkline generator"
    if isatty
      switch "$argv"
        case {,-}-v{ersion,}
          echo "spark version $spark_version"
        case {,-}-h{elp,}
          echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
          echo "examples:"
          echo "       spark 1 2 3 4"
          echo "       seq 100 | sort -R | spark"
          echo "       awk \\\$0=length spark.fish | spark"
        case \*
          echo $argv | spark $argv
      end
      return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
      BEGIN {
        min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
      }
      {
        for (i = j = 1; i <= NF; i++) {
          if ($i ~ /^--/) continue
          if ($i !~ /^-?[0-9]/) data[count + j++] = ""
          else {
            v = data[count + j++] = int($i)
            if (max == "" && min == "") max = min = v
            if (max < v) max = v
            if (min > v ) min = v
          }
        }
        count += j - 1
      }
      END {
        n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
        scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
        for (i = 1; i <= count; i++)
          out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
        print out
      }
    '
  end
  #       _ _
  #  __ _| (_)__ _ ___ ___ ___
  # / _` | | / _` (_-</ -_|_-<
  # \__,_|_|_\__,_/__/\___/__/
  set ALIASES $HOME/.aliases
  [ -f $ALIASES ] && source $ALIASES

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
  # wrapper around lf to support file preview.
  alias lf='~/.local/bin/lfrun.sh'
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
  alias clear='echo -en "\x1b[2J\x1b[1;1H" ; echo; seq 1 (tput cols) | sort -R | spark | lolcat -t; echo'
  alias repo='cd ~/ghq/(ghq list | fzf)'

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

  alias ncua='nmcli c up "a2n-s"'    # connects to my 4g, change to what you want.
  alias ncue='nmcli c up "eduroam"'  # connects to the network of my school.
  alias blcon='bluetoothctl connect B8:D5:0B:DD:9A:A7'
  alias bldis='bluetoothctl disconnect B8:D5:0B:DD:9A:A7'

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
  if type -q exa
    alias ls='exa -g --icons --group-directories-first'
    alias ll="exa -l -g --icons --group-directories-first"
    alias lla="exa -l -g -a --icons --group-directories-first"
    alias tree="exa -g --icons --tree --group-directories-first"
  else
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls -l --color=auto --group-directories-first'
    alias lla='ls -la --color=auto --group-directories-first'
  end
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  if type -q rg
    alias grep='rg'
  else
    alias grep='grep --color=auto'
  end
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  if type -q devour
    alias feh='devour feh'
    alias mpv='devour mpv'
    alias okular='devour okular'
    alias kolourpaint='devour kolourpaint'
    alias emacs='devour emacsclient -c -a "emacs"'
    if type -q alacritty
      alias ssh="devour alacritty -e ssh $1 > /dev/null"
    end
  else
    alias emacs='emacsclient -c -a "emacs"'
  end

  if [ "$TERM" = "xterm-kitty" ]
    alias kicat="kitty +kitten icat"
  end

  if pgrep "qtile" > /dev/null
    alias qtheme="themes.sh -C=qtile"
    alias qbar="$HOME/.config/qtile/scripts/bar.sh"
    alias qrestart="qtile cmd-obj -o cmd -f restart"
    alias qcmd="qtile cmd-obj -o cmd -f"
    alias qprompt="qtile cmd-obj -o cmd -f spawncmd"
    alias qstop="qtile cmd-obj -o cmd -f shutdown"
  end

  if type -q bat
    alias qlog="bat $HOME/.local/share/qtile/qtile.log"
    alias cat="bat"
  else
    alias qlog="cat $HOME/.local/share/qtile/qtile.log | less"
  end

  if type -q fd
    alias find="fd"
  end

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
