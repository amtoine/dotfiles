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

export-env { load-env {
    XDG_DATA_HOME: ($env.HOME | path join ".local" "share")
    XDG_CONFIG_HOME: ($env.HOME | path join ".config")
    XDG_STATE_HOME: ($env.HOME | path join ".local" "state")
    XDG_CACHE_HOME: ($env.HOME | path join ".cache")
}}

export-env {
    let-env GIT_REPOS_HOME = ($env.XDG_DATA_HOME | path join "git" "store")

    load-env {
        GHQ_ROOT: $env.GIT_REPOS_HOME

        DOTFILES_GIT_DIR: ($env.GIT_REPOS_HOME | path join "github.com" "goatfiles" "dotfiles")
        DOTFILES_WORKTREE: $env.HOME

        GIST_HOME: ($env.XDG_DATA_HOME | path join "gists")
    }
}

let-env TERMINFO_DIRS = (
  [
      ($env.XDG_DATA_HOME | path join "terminfo")
      "/usr/share/terminfo"
  ]
  | str join ":"
)

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
    NUPM_HOME: ($env.XDG_DATA_HOME | path join "nupm")
    NU_PLUGIN_DIR: ($env.XDG_DATA_HOME | path join "nushell" "plugins")
    PASSWORD_STORE_DIR: ($env.XDG_DATA_HOME | path join "pass")
    PYTHONSTARTUP: ($env.XDG_CONFIG_HOME | path join "python" "pythonrc")
    QT_QPA_PLATFORMTHEME: "qt5ct"
    QUICKEMU_HOME: ($env.XDG_DATA_HOME | path join "quickemu")
    RUBY_HOME: ($env.XDG_DATA_HOME | path join "gem" "ruby" $env.GEM_VERSION)
    SQLITE_HISTORY: ($env.XDG_CACHE_HOME | path join "sqlite_history")
    SSH_AGENT_TIMEOUT: 300
    SSH_KEYS_HOME: ($env.HOME | path join ".ssh" "keys")
    STARSHIP_CACHE: ($env.XDG_CACHE_HOME | path join "starship")
    TERMINFO: ($env.XDG_DATA_HOME | path join "terminfo")
    TOMB_HOME: ($env.XDG_DATA_HOME | path join "tombs")
    WORKON_HOME: ($env.XDG_DATA_HOME | path join "virtualenvs")
    XINITRC: ($env.XDG_CONFIG_HOME | path join "X11" "xinitrc")
    ZDOTDIR: ($env.XDG_CONFIG_HOME | path join "zsh")
    ZELLIJ_LAYOUTS_HOME: ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "zellij-layouts" "layouts")
    ZK_NOTEBOOK_DIR: ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "notes")
    _JAVA_OPTIONS: $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME | path join java)"
    _Z_DATA: ($env.XDG_DATA_HOME | path join "z")
}}

let-env BROWSER = "qutebrowser"
let-env TERMINAL = "alacritty -e"
let-env EDITOR = 'nvim'
let-env VISUAL = $env.EDITOR

let-env LS_THEME = "dracula"
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

# load secret environment variables
try {
    $nu.home-path | path join ".env" | open | from nuon
} catch {{}} | load-env

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

let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'lib')
    $env.NUPM_HOME
    $env.STARSHIP_CACHE
]

let-env NU_PLUGIN_DIRS = [
    ($env.NU_PLUGIN_DIR | path join "bin")
]

mkdir $env.STARSHIP_CACHE
starship init nu | save --force ($env.STARSHIP_CACHE | path join "starship.nu")

# start the ssh agent to allow SSO with ssh authentication
# very usefull with `github` over the ssh protocol
#
# see https://www.nushell.sh/cookbook/misc.html#manage-ssh-passphrases
ssh-agent -c -t $env.SSH_AGENT_TIMEOUT
| lines
| first 2
| parse "setenv {name} {value};"
| transpose -i -r -d
| load-env
