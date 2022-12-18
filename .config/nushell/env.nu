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

# Nushell Environment Config File


# credit to @Eldyj
# https://discord.com/channels/601130461678272522/615253963645911060/1036225475288252446
# revised by @eldyj in
# https://discord.com/channels/601130461678272522/615253963645911060/1037327061481701468
# revised by @fdncred in
# https://discord.com/channels/601130461678272522/615253963645911060/1037354164147200050
def spwd [] {
  let home = (if ($nu.os-info.name == windows) { $env.USERPROFILE } else { $env.HOME })
  let sep = (if ($nu.os-info.name == windows) { "\\" } else { "/" })

  let spwd_paths = (
    $"!/($env.PWD)" |
      str replace $"!/($home)" ~ -s |
      split row $sep
  )

  let spwd_len = (($spwd_paths | length) - 1)

  $spwd_paths
  | each {|el id|
    let spwd_src = ($el | split chars)

    if ($id == $spwd_len) {
      $el
    } else if ($spwd_src.0 == ".") {
      $".($spwd_src.1)"
    } else {
      $"($spwd_src.0)"
    }
  }
  | str collect $sep
}


# credit to @Eldyj
# https://discord.com/channels/601130461678272522/615253963645911060/1036274988950487060
def build-prompt [
    separator: string
    segments: table
] {
    let len = ($segments | length)

    let first = {
      fg: ($segments.0.fg),
      bg: ($segments.0.bg),
      text: $" ($segments.0.text) "
    }

    let tokens = (
        seq 1 ($len - 1)
        | each {|i|
          let sep = {
            fg: ($segments | get ($i - 1) | get bg),
            bg: ($segments | get $i | get bg),
            text: $separator
          }
          let text = {
            fg: ($segments | get $i | get fg),
            bg: ($segments | get $i | get bg),
            text: $" ($segments | get $i | get text) "
          }
          $sep | append $text
        }
        | flatten
    )

    let last = {
        fg: ($segments | get ($len - 1) | get bg),
        bg: '',
        text: $separator
    }

    let prompt = (
        $first |
        append $tokens |
        append $last |
        each {
            |it|
            $"(ansi reset)(ansi -e {fg: $it.fg, bg: $it.bg})($it.text)"
        } |
        str collect
    )
    $"($prompt)(ansi reset) "
}


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


# credit to @Eldyj
# https://discord.com/channels/601130461678272522/615253963645911060/1036274988950487060
def create_left_prompt_eldyj [] {
    let user_bg = "#2e3440"
    let user_fg = "#88c0d0"
    let pwd_bg = "#3b4252"
    let pwd_fg = "#81a1c1"
    let git_bg = "#434C5E"
    let git_fg = "#A3BE8C"

    let common = [
        [bg fg text];
        [$user_bg $user_fg $env.USER]
        [$pwd_bg $pwd_fg $"(spwd)"]
    ]

    let segments = if ((do -i { git branch --show-current } | complete | get stderr) == "") {
        let git_branch = {
            bg: $git_bg,
            fg: $git_fg,
            text: (git branch --show-current | str replace --all "\n" "")
        }
        $common | append $git_branch
    } else {
        $common
    }

    build-prompt (char nf_left_segment) $segments
}


def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str collect)

    $time_segment
}


# Use nushell functions to define your right and left prompt
let eldyj = true
let right = false
let-env PROMPT_COMMAND = if ($eldyj) { {create_left_prompt_eldyj} } else { {create_left_prompt} }
let-env PROMPT_COMMAND_RIGHT = if ($right) { {create_right_prompt} } else { "" }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let show_prompt_indicator = not $eldyj
let-env PROMPT_INDICATOR = if ($show_prompt_indicator) { "〉" } else { "" }
let-env PROMPT_INDICATOR_VI_INSERT = if ($show_prompt_indicator) { ": " } else { "" }
let-env PROMPT_INDICATOR_VI_NORMAL = if ($show_prompt_indicator) { "〉" } else { "" }

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

let-env BROWSER = "qutebrowser"
let-env TERMINAL = "alacritty -e"
# changes the editor in the terminal, to edit long commands.
let-env EDITOR = 'lvim'
let-env VISAL = 'lvim'

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

let-env DOWNLOADS_DIR = ("~/downloads" | path expand)

let-env FZF_DEFAULT_OPTS = "
--bind ctrl-d:half-page-down
--bind ctrl-u:half-page-up
--bind shift-right:preview-half-page-down
--bind shift-left:preview-half-page-up
--bind shift-down:preview-down
--bind shift-up:preview-up
"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env PATH = ($env.PATH | split row (char esep)
    | prepend ($env.HOME | path join ".local" "bin")
    | prepend ($env.EMACS_HOME | path join "bin")
    | prepend ($env.CARGO_HOME | path join "bin")
    | prepend ($env.XDG_DATA_HOME | path join "clang-15" "bin")
)
let-env LD_LIBRARY_PATH = ($env.LD_LIBRARY_PATH | split row (char esep) |
    prepend $env.MUJOCO_BIN
)


# disable or enable final configuration commands in ./scripts/final.nu
#
let-env USE_FINAL_CONFIG_HOOK = false
let-env QT_QPA_PLATFORMTHEME = "qt5ct"

let-env TOMB_HOME = ($env.XDG_DATA_HOME | path join "tombs")

let-env LS_THEME = "dracula"
let-env LS_COLORS = (vivid generate $env.LS_THEME)


# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIR = ($nu.config-path | path dirname | path join 'lib')
let-env NU_SCRIPTS_REMOTE = "https://github.com/goatfiles/nu_scripts"
let-env NU_SCRIPTS_DIR = ($env.GHQ_ROOT | path join "github.com/goatfiles/nu_scripts")

let-env NU_LIB_DIRS = [
    $env.NU_LIB_DIR
    $env.NU_SCRIPTS_DIR
]

if not ($env.NU_SCRIPTS_DIR | path exists) {
  print $"(ansi red_bold)error(ansi reset): ($env.NU_SCRIPTS_DIR) does not exist..."
  print $"(ansi cyan)info(ansi reset): pulling the scripts from ($env.NU_SCRIPTS_REMOTE)..."
  git clone $env.NU_SCRIPTS_REMOTE $env.NU_SCRIPTS_DIR
}

let-env DEFAULT_CONFIG_FILE = (
  $env.NU_LIB_DIR
  | path join "default_config.nu"
)
let-env DEFAULT_CONFIG_REMOTE = (
  "https://raw.githubusercontent.com/nushell/nushell/main/crates/nu-utils/src/sample_config"
)

# TODO
# credit to @kubouch
# https://discord.com/channels/601130461678272522/1050117978403917834/1051457787663761518
export def "config update default" [ --help (-h) ] {
  let name = ($env.DEFAULT_CONFIG_FILE | path basename)
  let default_url = ($env.DEFAULT_CONFIG_REMOTE | path join $name)

  if ($env.DEFAULT_CONFIG_FILE| path expand | path exists) {
    let new = (fetch $default_url)
    let old = (open $env.DEFAULT_CONFIG_FILE)

    if $old != $new {
      $new | save --raw $env.DEFAULT_CONFIG_FILE
      print $'Updated ($name)'
    } else {
      print $'($name): No change'
    }
  } else {
    fetch $default_url | save --raw $env.DEFAULT_CONFIG_FILE
    print $'Downloaded new ($name)'
  }
}

if not ($env.DEFAULT_CONFIG_FILE | path exists) {
  print $"(ansi red_bold)error(ansi reset): ($env.DEFAULT_CONFIG_FILE) does not exist..."
  print $"(ansi cyan)info(ansi reset): pulling default config file..."
  config update default
}
