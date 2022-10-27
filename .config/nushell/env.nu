# Nushell Environment Config File

def create_left_prompt [] {
    let simplified_pwd = ($env.PWD | str replace $nu.home-path '~' -s)

    let path_segment = if (is-admin) {
        $"(ansi red_bold)($simplified_pwd)"
    } else {
        $"(ansi green_bold)($simplified_pwd)"
    }

    let branch = (do -i { git branch --show-current } | str trim)

    if ($branch == '') {
        $path_segment
    } else {
        $path_segment + $" (ansi reset)\((ansi yellow_bold)($branch)(ansi reset)\)"
    }
}


def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str collect)

    #$time_segment
}


# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'lib')
    ($nu.config-path | path dirname | path join 'lib' "core")
    ($nu.config-path | path dirname | path join 'lib' "scripts")
    ($nu.config-path | path dirname | path join 'lib' "personal")
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

let-env XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
let-env XDG_CONFIG_HOME = ($env.HOME | path join ".config")
let-env XDG_STATE_HOME = ($env.HOME | path join ".local" "state")
let-env XDG_CACHE_HOME = ($env.HOME | path join ".cache")

# move all moveable config to the right location, outside $HOME.
let-env TERMINFO_DIRS = $"($env.XDG_DATA_HOME | path join terminfo):/usr/share/terminfo"
let-env _JAVA_OPTIONS = $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME | path join java)"
let-env HISTFILE = ($env.XDG_STATE_HOME | path join "bash" "history")
let-env CARGO_HOME = ($env.XDG_DATA_HOME | path join "cargo")
let-env DOOMDIR = ($env.XDG_CONFIG_HOME | path join "doom")
let-env GNUPGHOME = ($env.XDG_DATA_HOME | path join "gnupg")
let-env PASSWORD_STORE_DIR = ($env.XDG_DATA_HOME | path join "pass")
let-env GOPATH = ($env.XDG_DATA_HOME | path join "go")
let-env GRIPHOME = ($env.XDG_CONFIG_HOME | path join "grip")
let-env GTK2_RC_FILES = ($env.XDG_CONFIG_HOME | path join "gtk-2.0" "gtkrc")
let-env JUPYTER_CONFIG_DIR = ($env.XDG_CONFIG_HOME | path join "jupyter")
let-env LESSHISTFILE = ($env.XDG_CACHE_HOME | path join "less" "history")
let-env TERMINFO = ($env.XDG_DATA_HOME | path join "terminfo")
let-env NODE_REPL_HISTORY = ($env.XDG_DATA_HOME | path join "node_repl_history")
let-env NPM_CONFIG_USERCONFIG = ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")
let-env PYTHONSTARTUP = ($env.XDG_CONFIG_HOME | path join "python" "pythonrc")
let-env SQLITE_HISTORY = ($env.XDG_CACHE_HOME | path join "sqlite_history")
let-env XINITRC = ($env.XDG_CONFIG_HOME | path join "X11" "xinitrc")
let-env ZDOTDIR = ($env.XDG_CONFIG_HOME | path join "zsh")
let-env _Z_DATA = ($env.XDG_DATA_HOME | path join "z")
let-env CABAL_CONFIG = ($env.XDG_CONFIG_HOME | path join "cabal" "config")
let-env CABAL_DIR = ($env.XDG_DATA_HOME | path join "cabal")
let-env KERAS_HOME = ($env.XDG_STATE_HOME | path join "keras")
let-env EMACS_HOME = ($env.HOME | path join ".emacs.d")
let-env MUJOCO_BIN = ($env.HOME | path join ".mujoco" "mujoco210" "bin")
let-env VIMINIT = 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# changes the editor in the terminal, to edit long commands.
let-env EDITOR = 'vim'
let-env VISAL = 'vim'

### SET MANPAGER
### Uncomment only one of these!
# make "less" man pages prettier
#let-env LESS_TERMCAP_mb = $(tput bold; tput setaf 2)  # green
#let-env LESS_TERMCAP_md = $(tput bold; tput setaf 2)  # green
#let-env LESS_TERMCAP_so = $(tput bold; tput rev; tput setaf 3)  # yellow
#let-env LESS_TERMCAP_se = $(tput smul; tput sgr0)
#let-env LESS_TERMCAP_us = $(tput bold; tput bold; tput setaf 1)  # red
#let-env LESS_TERMCAP_me = $(tput sgr0)
### "bat" as manpager
let-env MANPAGER = "sh -c 'col -bx | bat -l man -p'"
### "vim" as manpager
# export MANPAGER = '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
### "nvim" as manpager
# export MANPAGER = "nvim -c 'set ft=man' -"

# activates virtualenvwrapper to manage python virtual environments.
let-env WORKON_HOME = ($env.XDG_DATA_HOME | path join "virtualenvs")

let-env GHQ_ROOT = ($env.XDG_DATA_HOME | path join "ghq")

let-env QUICKEMU_HOME = ($env.XDG_DATA_HOME | path join "quickemu")

let-env DOTFILES_GIT_DIR = ($env.GHQ_ROOT| path join "github.com" "goatfiles" "dotfiles")
let-env DOTFILES_WORKTREE = $env.HOME

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env PATH = ($env.PATH | split row (char esep) |
    prepend ($env.HOME | path join ".local" "bin") |
    prepend ($env.EMACS_HOME | path join "bin") |
    prepend ($env.CARGO_HOME | path join "bin")
)
let-env LD_LIBRARY_PATH = ($env.LD_LIBRARY_PATH | split row (char esep) |
    prepend $env.MUJOCO_BIN
)


# disable or enable final configuration commands in ./scripts/final.nu
#
let-env USE_FINAL_CONFIG_HOOK = false
let-env QT_QPA_PLATFORMTHEME = "qt5ct"
