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
    }
    cursor_shape: {
        vi_insert: line
        vi_normal: underscore
    }
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
    }
    edit_mode: vi
    show_banner: false
    datetime_format: {
        normal: "%a, %d %b %Y %H:%M:%S %z"
        table: "%Y/%m/%d %H:%M:%S"
    }
})

$env.config.hooks = {
    env_change: {
        PWD: [
            {|before, _|
                if $before == null {
                    let file = ($nu.home-path | path join ".local" "share" "nushell" "startup-times.nuon")
                    if not ($file | path exists) {
                        mkdir ($file | path dirname)
                        touch $file
                    }

                    open $file | append {
                        date: (date now)
                        time: $nu.startup-time
                        version: (version | get version)
                        commit: (version | get commit_hash)
                        build: (version | get build_time)
                    } | save --force $file
                }
            }
            {
                condition: {|_, after| $after | path join 'toolkit.nu' | path exists }
                code: "overlay use --prefix toolkit.nu"
            }
        ]
    }
    display_output: {||
        if (term size).columns >= 100 { table -e } else { table }
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

    # misc
    {
        name: run_zellij
        modifier: control
        keycode: char_z
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "nu-zellij layout open --default-shell nu"
        }
    }
    {
        name: zellij_sessionizer
        modifier: control
        keycode: char_f
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "zellij-sessionizer.nu (gm list --full-path)"
        }
    }
    {
        name: goto_repo
        modifier: control
        keycode: char_g
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "gm goto"
        }
    }
    {
        name: edit_config
        modifier: control
        keycode: char_v
        mode: [emacs, vi_insert, vi_normal]
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

export-env {
    $env.NU_RIGHT_PROMPT_CONFIG = {
        compact: false
        section_separator: " | "
        overlay_separator: '<'
        sections: ["overlays"]
    }
    load-env {
        PROMPT_INDICATOR: ''
        PROMPT_INDICATOR_VI_INSERT: ''
        PROMPT_INDICATOR_VI_NORMAL: ''
    }
}

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
use starship.nu

alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
alias :q = exit
alias sl = sl -aw -20
alias vim = edit

match (date now | date format "%m.%d") {
    "03.14" => { print $'Happy (char -i 0x03c0) Day! (char -i 0x1f973)' }
    "06.28" => { print $'Happy (char -i 0x1d70f) Day! (char -i 0x1f973)' }
}
