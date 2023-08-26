$env.config = ($env.config? | default {} | merge {
    ls: {
        use_ls_colors: true
        clickable_links: false
    }
    rm: {
        always_trash: true
    }
    cd: {
        abbreviations: true
    }
    history: {
        file_format: "sqlite"
        isolation: false
    }
    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        header_on_separator: false
    }
    footer_mode: 25
    edit_mode: vi
    show_banner: false
    datetime_format: {
        normal: "%a, %d %b %Y %T %z"
        table: "%F %T"
    }
    completions: {
        algorithm: "prefix"
        case_sensitive: true
    }
    bracketed_paste: true
})

$env.config.hooks = {
    env_change: {
        PWD: [
            {|before, _|
                if $before == null {
                    let file = $nu.home-path | path join ".local" "share" "nushell" "startup-times.nuon"
                    if not ($file | path exists) {
                        mkdir ($file | path dirname)
                        touch $file
                    }

                    let version = (version)

                    open $file | append {
                        date: (date now)
                        time: $nu.startup-time
                        build: $version.build_rust_channel
                        allocator: $version.allocator
                        version: $version.version
                        commit: $version.commit_hash
                        build_time: $version.build_time
                    } | save --force $file
                }
            }
            {
                condition: {|_, after| $after | path join 'toolkit.nu' | path exists }
                code: "overlay use --prefix toolkit.nu"
            }
        ]
    }
}

$env.config.keybindings = [
    # basic shell features
    {
        name: reload
        modifier: control
        keycode: char_r
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand,
            cmd: "exec nu"
        }
    }
    {
        name: clear
        modifier: control
        keycode: char_l
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "clear"
        }
    }
    {
        name: exit
        modifier: none
        keycode: char_q
        mode: [vi_normal]
        event: {
            send: executehostcommand
            cmd: "exit"
        }
    }
]

$env.NUPM_CONFIG = {
    activations: ($nu.default-config-dir | path join "nupm" "activations.nuon")
    packages: ($nu.default-config-dir | path join "nupm" "packages.nuon")
    set_prompt: true
}

$env.NU_RIGHT_PROMPT_CONFIG = {
    compact: false
    section_separator: " | "
    overlay_separator: '<'
    sections: ["overlays"]
}

$env.PROMPT_INDICATOR = ' '
$env.PROMPT_INDICATOR_VI_INSERT = ' '
$env.PROMPT_INDICATOR_VI_NORMAL = ' '
# use starship.nu

export-env {
    use nu-goat-scripts shell_prompt
    shell_prompt setup --pwd-mode "basename" --indicators {vi: {
        insert: " > "
        normal: " > "
    }}
}

use nu-git-manager gm
use nu-git-manager sugar completions git *
use nu-git-manager sugar dotfiles
use nu-git-manager sugar gh
use nu-git-manager sugar gist
use nu-git-manager sugar git
use nu-goat-scripts misc back
use nu-goat-scripts misc edit
use nu-scripts/themes/themes/nushell-dark.nu
$env.config.color_config = (nushell-dark)
$env.config.color_config.string = {||
    if $in =~ '^#[a-fA-F\d]+' { $in } else { 'white' }
}

use std clip

alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
alias de = dotfiles edit

alias vim = ^nvim
alias vi = ^nvim -u NONE
alias :G = ^git
alias :q = exit

alias ll = ls --all --long
def lsg [] {
    ls --all | each {|it|
        $it.name | if $it.type == dir { append "/" } else {} | str join
    }
    | grid --color --separator " | "
}

alias te = table --expand
alias ex = explore

alias news = ^nushell-news.nu --force
alias passmenu = ^passme.nu -l 10 -bw 5 -fn "mononoki Nerd Font-20" --notify

alias bye = ^sudo shutdown now
alias later = ^slock

alias sl = ^sl -aw -20

happy-day.nu
