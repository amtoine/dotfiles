export-env {
    let esep_list_converter = {
        from_string: { |s| $s | split row (char esep) }
        to_string: { |v| $v | str join (char esep) }
    }

    $env.ENV_CONVERSIONS = {
        XDG_DATA_DIRS: $esep_list_converter
        TERMINFO_DIRS: $esep_list_converter
    }
}

export-env { load-env {
    XDG_DATA_HOME: ($env.HOME | path join ".local" "share")
    XDG_CONFIG_HOME: ($env.HOME | path join ".config")
    XDG_STATE_HOME: ($env.HOME | path join ".local" "state")
    XDG_CACHE_HOME: ($env.HOME | path join ".cache")
    XDG_DOCUMENTS_DIR: ($env.HOME | path join "documents")
    XDG_DOWNLOAD_DIR: ($env.HOME | path join "downloads")
    XDG_MUSIC_DIR: ($env.HOME | path join "media" "music")
    XDG_PICTURES_DIR: ($env.HOME | path join "media" "images")
    XDG_VIDEOS_DIR: ($env.HOME | path join "media" "videos")
}}

export-env {
    $env.GIT_REPOS_HOME = ($env.XDG_DOCUMENTS_DIR | path join "repos")
    $env.GIST_HOME = ($env.XDG_DOCUMENTS_DIR | path join "gists")

    load-env {
        DOTFILES_GIT_DIR: ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "dotfiles")
        DOTFILES_WORKTREE: $env.HOME
    }
}

$env.TERMINFO_DIRS = (
    [
        ($env.XDG_DATA_HOME | path join "terminfo")
        "/usr/share/terminfo"
    ]
    | str join ":"
)

$env.GEM_VERSION = "3.0.0"

export-env { load-env {
    CABAL_CONFIG: ($env.XDG_CONFIG_HOME | path join "cabal" "config")
    CABAL_DIR: ($env.XDG_DATA_HOME | path join "cabal")
    CARGO_HOME: ($env.XDG_DATA_HOME | path join "cargo")
    CLANG_HOME: ($env.XDG_DATA_HOME | path join "clang-15")
    DOOMDIR: ($env.XDG_CONFIG_HOME | path join "doom")
    EMACS_HOME: ($env.HOME | path join ".emacs.d")
    GNUPGHOME: ($env.XDG_DATA_HOME | path join "gnupg")
    GOPATH: ($env.XDG_DATA_HOME | path join "go")
    GRIPHOME: ($env.XDG_CONFIG_HOME | path join "grip")
    GTK2_RC_FILES: ($env.XDG_CONFIG_HOME | path join "gtk-2.0" "gtkrc")
    HISTFILE: ($env.XDG_STATE_HOME | path join "bash" "history")
    IPFS_PATH: ($env.HOME | path join ".ipfs")
    JUPYTER_CONFIG_DIR: ($env.XDG_CONFIG_HOME | path join "jupyter")
    KERAS_HOME: ($env.XDG_STATE_HOME | path join "keras")
    LESSHISTFILE: ($env.XDG_CACHE_HOME | path join "less" "history")
    MUJOCO_BIN: ($env.HOME | path join ".mujoco" "mujoco210" "bin")
    NODE_REPL_HISTORY: ($env.XDG_DATA_HOME | path join "node_repl_history")
    NPM_CONFIG_USERCONFIG: ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")
    NUPM_CACHE: ($env.XDG_CACHE_HOME | path join "nupm")
    NUPM_HOME: ($env.XDG_DATA_HOME | path join "nupm")
    PASSWORD_STORE_DIR: ($env.XDG_DATA_HOME | path join "pass")
    PYTHONSTARTUP: ($env.XDG_CONFIG_HOME | path join "python" "pythonrc")
    QT_QPA_PLATFORMTHEME: "qt5ct"
    QUICKEMU_HOME: ($env.XDG_DATA_HOME | path join "quickemu")
    RUBY_HOME: ($env.XDG_DATA_HOME | path join "gem" "ruby" $env.GEM_VERSION)
    RUSTUP_HOME: ($env.XDG_CONFIG_HOME | path join "rustup")
    SQLITE_HISTORY: ($env.XDG_CACHE_HOME | path join "sqlite_history")
    SSH_AGENT_TIMEOUT: 300
    SSH_KEYS_HOME: ($env.HOME | path join ".ssh" "keys")
    TERMINFO: ($env.XDG_DATA_HOME | path join "terminfo")
    TOMB_HOME: ($env.XDG_DATA_HOME | path join "tombs")
    VIMRUNTIME: ($env.XDG_DATA_HOME | path join "nvim" "runtime")
    WORKON_HOME: ($env.XDG_DATA_HOME | path join "virtualenvs")
    XINITRC: ($env.XDG_CONFIG_HOME | path join "X11" "xinitrc")
    ZDOTDIR: ($env.XDG_CONFIG_HOME | path join "zsh")
    ZELLIJ_LAYOUTS_HOME: ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "zellij-layouts" "layouts")
    ZK_NOTEBOOK_DIR: ($env.GIT_REPOS_HOME | path join "github.com" "amtoine" "notes")
    _JAVA_OPTIONS: $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME | path join java)"
    _Z_DATA: ($env.XDG_DATA_HOME | path join "z")
}}

$env.EDITOR = 'nvim'
$env.VISUAL = $env.EDITOR

def --env _set_manpager [pager: string] {
    $env.MANPAGER = (match $pager {
        "bat" => "sh -c 'col -bx | bat -l man -p'",
        "batcat" => "sh -c 'col -bx | batcat -l man -p'",
        "vim" => '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"',
        "nvim" => "nvim -c 'set ft=man' -",
        _ => {
            print $"unknown manpage '($pager)', defaulting to prettier `less`"
            $env.LESS_TERMCAP_mb = (tput bold; tput setaf 2)  # green
            $env.LESS_TERMCAP_md = (tput bold; tput setaf 2)  # green
            $env.LESS_TERMCAP_so = (tput bold; tput rev; tput setaf 3)  # yellow
            $env.LESS_TERMCAP_se = (tput smul; tput sgr0)
            $env.LESS_TERMCAP_us = (tput bold; tput bold; tput setaf 1)  # red
            $env.LESS_TERMCAP_me = (tput sgr0)
         }
    })
}

_set_manpager "bat"

$env.FZF_DEFAULT_OPTS = "
--bind ctrl-d:half-page-down
--bind ctrl-u:half-page-up
--bind shift-right:preview-half-page-down
--bind shift-left:preview-half-page-up
--bind shift-down:preview-down
--bind shift-up:preview-up
--preview-window right,80%
"

# load secret environment variables
export-env {
    let env_file = $nu.home-path | path join ".env"
    if ($env_file | path exists) {
        open $env_file | from nuon | load-env
    }
}

use std "path add"
# NOTE: this `split row` is here to prevent the following error
# ```
# Error: nu::shell::env_var_not_a_string
#   × 'PATH' is not representable as a string.
#      ╭─[/home/disc/a.stevan/.config/nushell/env.nu:146:1]
#  146 │ path add ($env.HOME | path join ".local" "bin")
#  147 │ $env.PATH = ($env.PATH | uniq)
#      ·             ─────────┬────────
#      ·                      ╰── value not representable as a string
#  148 │
#      ╰────
#   help: The 'PATH' environment variable must be a string or be convertible to a string. Either
#         make sure 'PATH' is a string, or add a 'to_string' entry for it in ENV_CONVERSIONS.
# ```
$env.PATH = ($env.PATH | split row ":")
path add /nix/var/nix/profiles/default/bin
path add ($env.XDG_DATA_HOME | path join "npm" "bin")
path add ($env.CARGO_HOME | path join "bin")
path add ($env.CLANG_HOME | path join "bin")
path add ($env.GOPATH | path join "bin")
path add ($env.EMACS_HOME | path join "bin")
path add ($env.RUBY_HOME | path join "bin")
path add ($env.NUPM_HOME | path join "scripts")
path add ($env.XDG_STATE_HOME | path join "nix/profile/bin")
path add ($env.HOME | path join ".local" "bin")
$env.PATH = ($env.PATH | uniq)

$env.LD_LIBRARY_PATH = (
    $env.LD_LIBRARY_PATH?
        | default ""
        | split row (char esep)
        | prepend $env.MUJOCO_BIN
        | uniq
)

$env.NU_LIB_DIRS = [
    ($env.NUPM_HOME | path join "modules"),
    ($nu.default-config-dir | path join "overlays")
]

$env.NU_PLUGIN_DIRS = [
    ($env.CARGO_HOME | path join "bin")
    ($env.NUPM_HOME | path join "plugins/bin")
]

# start the ssh agent to allow SSO with ssh authentication
# very usefull with `github` over the ssh protocol
#
# see https://www.nushell.sh/cookbook/ssh_agent.html#workarounds
do --env {
    let ssh_agent_file = $nu.temp-path | path join $"ssh-agent-($env.USER).nuon"

    if ($ssh_agent_file | path exists) {
        let ssh_agent_env = open ($ssh_agent_file)
        if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
            load-env $ssh_agent_env
            return
        } else {
            rm $ssh_agent_file
        }
    }

    let ssh_agent_env = ^ssh-agent -c -t $env.SSH_AGENT_TIMEOUT
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose -r
        | into record
    load-env $ssh_agent_env
    $ssh_agent_env | save --force $ssh_agent_file
}

$env.SHELL = $nu.current-exe

$env.GPG_TTY = (tty)
