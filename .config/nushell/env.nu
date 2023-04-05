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

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins' 'bin')
]

# the XDG environment on which all the others are based
let-env XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
let-env XDG_CONFIG_HOME = ($env.HOME | path join ".config")
let-env XDG_STATE_HOME = ($env.HOME | path join ".local" "state")
let-env XDG_CACHE_HOME = ($env.HOME | path join ".cache")

# git-related variables
let-env GHQ_ROOT = ($env.XDG_DATA_HOME | path join "git" "store")
let-env GIT_REPOS_HOME = $env.GHQ_ROOT

let-env DOTFILES_GIT_DIR = ($env.GIT_REPOS_HOME| path join "github.com" "goatfiles" "dotfiles")
let-env DOTFILES_WORKTREE = $env.HOME

let-env GIST_HOME = ($env.XDG_DATA_HOME | path join "gists")

let-env GIT_PROTOCOLS = {
    ssh: {name: "secure shell" protocol: "ssh://git@"}
    https: {name: "HTTP" protocol: "https://"}
}

let-env GIT_PROTOCOL = $env.GIT_PROTOCOLS.ssh

# move all moveable config to the right location, outside $HOME.
let-env TERMINFO_DIRS = (
  [
      ($env.XDG_DATA_HOME | path join "terminfo")
      "/usr/share/terminfo"
  ]
  | str join ":"
)
let-env _JAVA_OPTIONS = $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME | path join java)"

let-env CABAL_CONFIG = ($env.XDG_CONFIG_HOME | path join "cabal" "config")
let-env CABAL_DIR = ($env.XDG_DATA_HOME | path join "cabal")
let-env CARGO_HOME = ($env.XDG_DATA_HOME | path join "cargo")
let-env DOOMDIR = ($env.XDG_CONFIG_HOME | path join "doom")
let-env DOWNLOADS_DIR = ($env.HOME | path join "downloads")
let-env EMACS_HOME = ($env.HOME | path join ".emacs.d")
let-env GNUPGHOME = ($env.XDG_DATA_HOME | path join "gnupg")
let-env GOPATH = ($env.XDG_DATA_HOME | path join "go")
let-env GRIPHOME = ($env.XDG_CONFIG_HOME | path join "grip")
let-env GTK2_RC_FILES = ($env.XDG_CONFIG_HOME | path join "gtk-2.0" "gtkrc")
let-env HISTFILE = ($env.XDG_STATE_HOME | path join "bash" "history")
let-env IPFS_PATH = ($env.HOME | path join ".ipfs")
let-env JUPYTER_CONFIG_DIR = ($env.XDG_CONFIG_HOME | path join "jupyter")
let-env KERAS_HOME = ($env.XDG_STATE_HOME | path join "keras")
let-env LESSHISTFILE = ($env.XDG_CACHE_HOME | path join "less" "history")
let-env MUJOCO_BIN = ($env.HOME | path join ".mujoco" "mujoco210" "bin")
let-env NODE_REPL_HISTORY = ($env.XDG_DATA_HOME | path join "node_repl_history")
let-env NPM_CONFIG_USERCONFIG = ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")
let-env PASSWORD_STORE_DIR = ($env.XDG_DATA_HOME | path join "pass")
let-env PYTHONSTARTUP = ($env.XDG_CONFIG_HOME | path join "python" "pythonrc")
let-env QT_QPA_PLATFORMTHEME = "qt5ct"
let-env QUICKEMU_HOME = ($env.XDG_DATA_HOME | path join "quickemu")
let-env SQLITE_HISTORY = ($env.XDG_CACHE_HOME | path join "sqlite_history")
let-env TERMINFO = ($env.XDG_DATA_HOME | path join "terminfo")
let-env TOMB_HOME = ($env.XDG_DATA_HOME | path join "tombs")
let-env WORKON_HOME = ($env.XDG_DATA_HOME | path join "virtualenvs")
let-env XINITRC = ($env.XDG_CONFIG_HOME | path join "X11" "xinitrc")
let-env ZDOTDIR = ($env.XDG_CONFIG_HOME | path join "zsh")
let-env ZK_NOTEBOOK_DIR = ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "notes")
let-env _Z_DATA = ($env.XDG_DATA_HOME | path join "z")

let-env BROWSER = "qutebrowser"
let-env TERMINAL = "alacritty -e"
# changes the editor in the terminal, to edit long commands.
let-env EDITOR = 'nvim'
let-env VISUAL = $env.EDITOR

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

let-env GEM_VERSION = "3.0.0"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

let-env PATH = (
    $env.PATH | split row (char esep)
    | prepend ($env.HOME | path join ".local" "bin")
    | prepend ($env.EMACS_HOME | path join "bin")
    | prepend ($env.CARGO_HOME | path join "bin")
    | prepend ($env.XDG_DATA_HOME | path join "clang-15" "bin")
    | prepend ($env.XDG_DATA_HOME | path join "gem" "ruby" $env.GEM_VERSION "bin")
    | prepend ($env.GOPATH | path join "bin")
    | uniq
)
let-env LD_LIBRARY_PATH = (
    $env | get -i LD_LIBRARY_PATH | default "" | split row (char esep)
    | prepend $env.MUJOCO_BIN
    | uniq
)

let-env LS_THEME = "one-dark"
let-env LS_COLORS = (vivid generate $env.LS_THEME)

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_GIT_LIB_DIR = ($env.XDG_DATA_HOME | path join "nushell" "lib")

let-env NU_LIB_DIR = ($nu.config-path | path dirname | path join 'lib')
let-env NU_SCRIPTS = {
  nushell: {
     upstream: "github.com/nushell/nu_scripts.git"
     directory: ($env.NU_GIT_LIB_DIR | path join "nushell" "nu_scripts")
     revision: "main"
  }
  goatfiles: {
     upstream: "github.com/goatfiles/nu_scripts.git"
     directory: ($env.NU_GIT_LIB_DIR | path join "goatfiles" "nu_scripts")
     revision: "bleeding"
  }
}

let-env NU_LIB_DIRS = [
    $env.NU_LIB_DIR
    $env.NU_GIT_LIB_DIR
    $env.NU_SCRIPTS.goatfiles.directory
    $env.NU_SCRIPTS.nushell.directory
]

let-env DEFAULT_CONFIG_FILE = (
  $env.NU_GIT_LIB_DIR | path join "default_config.nu"
)
let-env DEFAULT_CONFIG_REMOTE = ({
    scheme: https,
    host: raw.githubusercontent.com,
    path: /nushell/nushell/main/crates/nu-utils/src/sample_config,
} | url join)

export def "config update default" [
    --init: bool
] {
    let name = ($env.DEFAULT_CONFIG_FILE | path basename)
    let default_url = ($env.DEFAULT_CONFIG_REMOTE | path join $name)

    if ($env.DEFAULT_CONFIG_FILE | path expand | path exists) {
        if not $init {
            print $"(ansi cyan)info(ansi reset): updating default config..."
            http get $default_url | save --force --raw .default_config.nu

            let diff = (diff -u --color=always $env.DEFAULT_CONFIG_FILE .default_config.nu)

            if not ($diff | is-empty) {
                print $diff
            }

            mv --force .default_config.nu $env.DEFAULT_CONFIG_FILE
        }
    } else {
        print $"(ansi red_bold)error(ansi reset): ($env.DEFAULT_CONFIG_FILE) does not exist..."
        print $"(ansi cyan)info(ansi reset): pulling default config file..."
        http get $default_url | save --force --raw $env.DEFAULT_CONFIG_FILE
        print $'Downloaded new ($name)'
    }
}

export def "config update lib" [
    --init: bool
] {
    for profile in ($env.NU_SCRIPTS | transpose name profile | get profile) {
        if not ($profile.directory | path exists) {
            print $"(ansi red_bold)error(ansi reset): ($profile.directory) does not exist..."
            print $"(ansi cyan)info(ansi reset): pulling the scripts from ($profile.upstream)..."
            git clone ([$env.GIT_PROTOCOLS.https.protocol $profile.upstream] | str join) $profile.directory
        } else {
            if not $init {
                print $"(ansi cyan)info(ansi reset): updating ($profile.directory)..."
                git -C $profile.directory fetch origin --prune
            }
        }

        git -C $profile.directory checkout (["origin" $profile.revision] | path join) out+err> /dev/null
    }
}

mkdir $env.NU_GIT_LIB_DIR
config update default --init
config update lib --init

export def "config edit default" [] {
    ^$env.EDITOR $env.DEFAULT_CONFIG_FILE
}

def "nu-complete list-nu-libs" [] {
    ls ($env.NU_GIT_LIB_DIR | path join "**" "*" ".git")
    | get name
    | path parse
    | get parent
    | str replace $env.NU_GIT_LIB_DIR ""
    | str trim -c (char path_sep)
}

export def "config edit lib" [lib: string@"nu-complete list-nu-libs"] {
    cd ($env.NU_GIT_LIB_DIR | path join $lib)
    ^$env.EDITOR .
}

export def "config status" [] {
    nu-complete list-nu-libs | each {|lib|
        {
            name: $lib
            describe: (try {
                let tag = (git -C ($env.NU_GIT_LIB_DIR | path join $lib) describe HEAD)
                $tag
            } catch { "" })
            rev: (git -C ($env.NU_GIT_LIB_DIR | path join $lib) rev-parse HEAD)
        }
    }
}

let-env PROMPT_MULTILINE_INDICATOR_COLORS = [
    "red_dimmed"
    "yellow_dimmed"
    "green_dimmed"
]
let-env PROMPT_MULTILINE_INDICATOR_CHARACTER = ":"

let-env PROMPT_MULTILINE_INDICATOR = ((
    $env.PROMPT_MULTILINE_INDICATOR_COLORS
    | each {|color| ansi $color }
    | append (ansi reset)
    | str join $env.PROMPT_MULTILINE_INDICATOR_CHARACTER
) + " ")

let-env PROMPT_INDICATORS = {
  plain: "> ",
  vi: { insert: ">_ ", normal: ">- " }
}


# start the ssh agent to allow SSO with ssh authentication
# very usefull with `github` over the ssh protocol
#
# see https://www.nushell.sh/cookbook/misc.html#manage-ssh-passphrases
#
let-env SSH_AGENT_TIMEOUT = 300
ssh-agent -c -t $env.SSH_AGENT_TIMEOUT
| lines
| first 2
| parse "setenv {name} {value};"
| transpose -i -r -d
| load-env

let-env SSH_KEYS_HOME = ($env.HOME | path join ".ssh" "keys")

# disable or enable final configuration commands in ./scripts/final.nu
#
let-env USE_FINAL_CONFIG_HOOK = false
