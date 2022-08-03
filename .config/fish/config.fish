if status is-interactive
  fish_add_path -mP $HOME/.cargo/bin
  fish_add_path -mP $HOME/.emacs.d/bin
  fish_add_path -mP $HOME/.local/bin
  set -Ux LD_LIBRARY_PATH /home/ants/.mujoco/mujoco210/bin

  # define XDG environment variables.
  set -Ux XDG_DATA_HOME "$HOME/.local/share"
  set -Ux XDG_CONFIG_HOME "$HOME/.config"
  set -Ux XDG_STATE_HOME "$HOME/.local/state"
  set -Ux XDG_CACHE_HOME "$HOME/.cache"

  # move all moveable config to the right location, outside $HOME.
  set -Ux HISTFILE "$XDG_STATE_HOME"/bash/history
  set -Ux CARGO_HOME "$XDG_DATA_HOME"/cargo
  set -Ux DOOMDIR "$XDG_CONFIG_HOME/doom"
  set -Ux GNUPGHOME "$XDG_DATA_HOME"/gnupg
  set -Ux PASSWORD_STORE_DIR "$XDG_DATA_HOME"/pass
  set -Ux GOPATH "$XDG_DATA_HOME"/go
  set -Ux GRIPHOME "$XDG_CONFIG_HOME/grip"
  set -Ux GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
  set -Ux JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
  set -Ux LESSHISTFILE "$XDG_CACHE_HOME"/less/history
  set -Ux TERMINFO "$XDG_DATA_HOME"/terminfo
  set -Ux TERMINFO_DIRS "$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
  set -Ux NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history
  set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
  set -Ux _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
  set -Ux PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"
  set -Ux SQLITE_HISTORY "$XDG_CACHE_HOME"/sqlite_history
  set -Ux XINITRC "$XDG_CONFIG_HOME"/X11/xinitrc
  set -Ux ZDOTDIR "$XDG_CONFIG_HOME"/zsh
  set -Ux _Z_DATA "$XDG_DATA_HOME/z"
  set -Ux CABAL_CONFIG "$XDG_CONFIG_HOME"/cabal/config
  set -Ux CABAL_DIR "$XDG_DATA_HOME"/cabal
  set -Ux KERAS_HOME "$XDG_STATE_HOME/keras"

  # tool function definitions.
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
  alias repo='cd (ghq root)/(ghq list | fzf)'

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
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  if type -q devour
    alias feh='devour feh'
    alias mpv='devour mpv'
    alias okular='devour okular'
    alias kolourpaint='devour kolourpaint'
  end
  alias pdf='okular (find "\.pdf\$" . | fzf)'

  if [ "$TERM" = "xterm-kitty" ]
    alias kicat="kitty +kitten icat"
  end

  if pgrep "qtile" > /dev/null
    alias qtheme="amtoine-themes -C=qtile"
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

  alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"
  alias xdg-ninja="$HOME/ghq/github.com/amtoine/xdg-ninja/xdg-ninja.sh"

  alias xonsh="xonsh --rc $XDG_CONFIG_HOME/xonsh/xonshrc"

  alias screencast="screencast --output-dir=$HOME/videos/screencast"
  alias mcli="mcli --config-dir $HOME/.config/mcli"

  #        _
  #  _ __ (_)___ __
  # | '  \| (_-</ _|
  # |_|_|_|_/__/\__|
  # disables the caps lock key.
  amtoine-xtcl -d -q

  # starship init fish | source
  source ~/.local/share/omf/pkg/colorman/init.fish

  set VIRTUAL_FISH_HOME "$XDG_DATA_HOME/virtualenvs"

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
