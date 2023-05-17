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

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
}

export-env { load-env {  # the XDG environment on which all the others are based
    XDG_DATA_HOME: ($env.HOME | path join ".local" "share")
    XDG_CONFIG_HOME: ($env.HOME | path join ".config")
    XDG_STATE_HOME: ($env.HOME | path join ".local" "state")
    XDG_CACHE_HOME: ($env.HOME | path join ".cache")
}}

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($env.XDG_DATA_HOME | path join "nushell" 'plugins' 'bin')
]

export-env {  # git-related variables
    let-env GIT_REPOS_HOME = ($env.XDG_DATA_HOME | path join "git" "store")

    load-env {
        GHQ_ROOT: $env.GIT_REPOS_HOME

        DOTFILES_GIT_DIR: ($env.GIT_REPOS_HOME | path join "github.com" "goatfiles" "dotfiles")
        DOTFILES_WORKTREE: $env.HOME

        GIST_HOME: ($env.XDG_DATA_HOME | path join "gists")
    }
}

# move all moveable config to the right location, outside $HOME.
let-env TERMINFO_DIRS = (
  [
      ($env.XDG_DATA_HOME | path join "terminfo")
      "/usr/share/terminfo"
  ]
  | str join ":"
)
let-env _JAVA_OPTIONS = $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME | path join java)"

let-env GEM_VERSION = "3.0.0"

export-env { load-env {
    CABAL_CONFIG: ($env.XDG_CONFIG_HOME | path join "cabal" "config")
    CABAL_DIR: ($env.XDG_DATA_HOME | path join "cabal")
    CARGO_HOME: ($env.XDG_DATA_HOME | path join "cargo")
    CLANG_HOME: ($env.XDG_DATA_HOME | path join "clang-15")
    DOOMDIR: ($env.XDG_CONFIG_HOME | path join "doom")
    DOWNLOADS_DIR: ($env.HOME | path join "downloads")
    EMACS_HOME: ($env.HOME | path join ".emacs.d")
    GNUPGHOME: ($env.XDG_DATA_HOME | path join "gnupg")
    GOPATH: ($env.XDG_DATA_HOME | path join "go")
    GRIPHOME: ($env.XDG_CONFIG_HOME | path join "grip")
    GTK2_RC_FILES: ($env.XDG_CONFIG_HOME | path join "gtk-2.0" "gtkrc")
    HISTFILE: ($env.XDG_STATE_HOME | path join "bash" "history")
    IMAGES_HOME: ($env.HOME | path join "media" "images")
    IPFS_PATH: ($env.HOME | path join ".ipfs")
    JUPYTER_CONFIG_DIR: ($env.XDG_CONFIG_HOME | path join "jupyter")
    KERAS_HOME: ($env.XDG_STATE_HOME | path join "keras")
    LESSHISTFILE: ($env.XDG_CACHE_HOME | path join "less" "history")
    MUJOCO_BIN: ($env.HOME | path join ".mujoco" "mujoco210" "bin")
    NODE_REPL_HISTORY: ($env.XDG_DATA_HOME | path join "node_repl_history")
    NPM_CONFIG_USERCONFIG: ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")
    PASSWORD_STORE_DIR: ($env.XDG_DATA_HOME | path join "pass")
    PYTHONSTARTUP: ($env.XDG_CONFIG_HOME | path join "python" "pythonrc")
    QT_QPA_PLATFORMTHEME: "qt5ct"
    QUICKEMU_HOME: ($env.XDG_DATA_HOME | path join "quickemu")
    RUBY_HOME: ($env.XDG_DATA_HOME | path join "gem" "ruby" $env.GEM_VERSION)
    SQLITE_HISTORY: ($env.XDG_CACHE_HOME | path join "sqlite_history")
    TERMINFO: ($env.XDG_DATA_HOME | path join "terminfo")
    TOMB_HOME: ($env.XDG_DATA_HOME | path join "tombs")
    WORKON_HOME: ($env.XDG_DATA_HOME | path join "virtualenvs")
    XINITRC: ($env.XDG_CONFIG_HOME | path join "X11" "xinitrc")
    ZDOTDIR: ($env.XDG_CONFIG_HOME | path join "zsh")
    ZK_NOTEBOOK_DIR: ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "notes")
    _Z_DATA: ($env.XDG_DATA_HOME | path join "z")
}}

# user environment variables
let-env BROWSER = "qutebrowser"
let-env TERMINAL = "alacritty -e"
# changes the editor in the terminal, to edit long commands.
let-env EDITOR = 'nvim'
let-env VISUAL = $env.EDITOR

let-env LS_THEME = "one-dark"
let-env LS_COLORS = (vivid generate $env.LS_THEME)

def-env _set_manpager [pager: string] {
    let-env MANPAGER = (match $pager {
        "bat" => "sh -c 'col -bx | bat -l man -p'",
        "vim" => '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"',
        "nvim" => "nvim -c 'set ft=man' -",
        _ => {
            print $"unknown manpage '($pager)', defaulting to prettier `less`"
            let-env LESS_TERMCAP_mb = (tput bold; tput setaf 2)  # green
            let-env LESS_TERMCAP_md = (tput bold; tput setaf 2)  # green
            let-env LESS_TERMCAP_so = (tput bold; tput rev; tput setaf 3)  # yellow
            let-env LESS_TERMCAP_se = (tput smul; tput sgr0)
            let-env LESS_TERMCAP_us = (tput bold; tput bold; tput setaf 1)  # red
            let-env LESS_TERMCAP_me = (tput sgr0)
         }
    })
}

_set_manpager "bat"

let-env FZF_DEFAULT_OPTS = "
--bind ctrl-d:half-page-down
--bind ctrl-u:half-page-up
--bind shift-right:preview-half-page-down
--bind shift-left:preview-half-page-up
--bind shift-down:preview-down
--bind shift-up:preview-up
--preview-window right,80%
"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env PATH = (
    $env.PATH | split row (char esep)
    | prepend ($env.HOME | path join ".local" "bin")
    | prepend ($env.CARGO_HOME | path join "bin")
    | prepend ($env.CLANG_HOME | path join "bin")
    | prepend ($env.GOPATH | path join "bin")
    | prepend ($env.EMACS_HOME | path join "bin")
    | prepend ($env.RUBY_HOME | path join "bin")
    | uniq
)

let-env LD_LIBRARY_PATH = (
    $env.LD_LIBRARY_PATH? | default "" | split row (char esep)
    | prepend $env.MUJOCO_BIN
    | uniq
)

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'lib')
]

export-env {  # the prompt
    load-env {
        PROMPT_INDICATOR: ""
        PROMPT_INDICATOR_VI_INSERT: ""
        PROMPT_INDICATOR_VI_NORMAL: ""
        PROMPT_MULTILINE_INDICATOR_COLORS: [
            "red_dimmed"
            "yellow_dimmed"
            "green_dimmed"
        ]
        PROMPT_MULTILINE_INDICATOR_CHARACTER: ":"
    }
    let-env PROMPT_MULTILINE_INDICATOR = ((
        $env.PROMPT_MULTILINE_INDICATOR_COLORS
        | each {|color| ansi $color }
        | append (ansi reset)
        | str join $env.PROMPT_MULTILINE_INDICATOR_CHARACTER
    ) + " ")
}

export-env {
    let-env STARSHIP_CACHE = ($env.XDG_CACHE_HOME | path join "starship")
    let-env NU_LIB_DIRS = ($env.NU_LIB_DIRS? | default [] | append [
        $env.STARSHIP_CACHE
    ])

    mkdir $env.STARSHIP_CACHE
    starship init nu | save --force ($env.STARSHIP_CACHE | path join "starship.nu")
}

# start the ssh agent to allow SSO with ssh authentication
# very usefull with `github` over the ssh protocol
#
# see https://www.nushell.sh/cookbook/misc.html#manage-ssh-passphrases
export-env {
    let-env SSH_AGENT_TIMEOUT = 300
    let-env SSH_KEYS_HOME = ($env.HOME | path join ".ssh" "keys")

    ssh-agent -c -t $env.SSH_AGENT_TIMEOUT
    | lines
    | first 2
    | parse "setenv {name} {value};"
    | transpose -i -r -d
    | load-env
}

# disable or enable final configuration commands in ./scripts/final.nu
#
let-env USE_FINAL_CONFIG_HOOK = false

# load secret environment variables
try { $nu.home-path | path join ".env" | open | from nuon } catch {{}} | load-env

export-env {
    let-env NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")
    let-env NU_LIB_DIRS = ($env.NU_LIB_DIRS? | default [] | append [
        $env.NUPM_HOME
    ])
}
