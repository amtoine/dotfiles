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

    # misc
    {
        name: run_zellij
        modifier: control
        keycode: char_z
        mode: [vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "nu-zellij layout open --default-shell nu"
        }
    }
    {
        name: zellij_sessionizer
        modifier: control
        keycode: char_f
        mode: [vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "zellij-sessionizer.nu (gm list --full-path)"
        }
    }
    {
        name: goto_repo
        modifier: control
        keycode: char_g
        mode: [vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "gm goto"
        }
    }
    {
        name: edit_config
        modifier: control
        keycode: char_v
        mode: [vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "dotfiles edit"
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

use nu-goat-scripts shell_prompt
shell_prompt setup --indicators {vi: {
    insert: $" (ansi reset)(ansi red_dimmed)INSERT(ansi reset) > "
    normal: $" (ansi reset)(ansi blue_dimmed)NORMAL(ansi reset) > "
}}

# **Note**  
# the following modules have been installed with `nupm` from nushell/nupm#6:
# `nupm install --path /path/to/amtoine/nu-git-manager/`
use nu-git-manager gm
use nu-git-manager sugar completions git *
use nu-git-manager sugar dotfiles
use nu-git-manager sugar gh
use nu-git-manager sugar gist
use nu-git-manager sugar git
# `nupm install --path /path/to/goatfiles/scripts/nu_scripts/`
use nu-goat-scripts misc back
use nu-goat-scripts misc edit
# `nupm install --path /path/to/amtoine/zellij-layouts/nu-zellij/`
use nu-zellij
# `nupm install --path /path/to/nushell/nu_scripts/`
use nu-scripts/themes/themes/nushell-dark.nu
$env.config.color_config = (nushell-dark)
$env.config.color_config.string = {||
    if $in =~ '^#[a-fA-F\d]+' { $in } else { 'white' }
}

use std clip

alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
alias :q = exit
alias sl = sl -aw -20
alias vim = edit
alias ll = ls --all --long
def lsg [] {
    ls --all | each {|it|
        $it.name | if $it.type == dir { append "/" } else {} | str join
    } | grid --color --separator " | "
}
alias te = table --expand

match (date now | date format "%m.%d") {
    "03.14" => { print $'Happy (char -i 0x03c0) Day! (char -i 0x1f973)' }
    "06.28" => { print $'Happy (char -i 0x1d70f) Day! (char -i 0x1f973)' }
}
