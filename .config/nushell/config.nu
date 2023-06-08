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

let-env config = ($env.config? | default {} | merge {
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
        show_empty: false
    }
    edit_mode: vi
    show_banner: false
})

$env.config.hooks = {
    env_change: {
        PWD: [
            {|before, _|
                if $before == null and (not ($env.config?.show_banner? | default true)) {
                    print $"(ansi {fg: default, attr: "du"})startup time(ansi reset): (ansi {fg: default, attr: "di"})($nu.startup-time)(ansi reset)"
                }
            }
            {
                condition: {|_, after| $after | path join 'toolkit.nu' | path exists }
                code: "overlay use --prefix toolkit.nu"
            }
            {
                condition: {|_, after| $after | path join 'toolkit' 'mod.nu' | path exists }
                code: "overlay use --prefix toolkit/"
            }
        ]
    }
    display_output: {||
        if (term size).columns >= 100 { table -e } else { table }
    }
    command_not_found: {|cmd|
        let commands_in_path = (
            $env.PATH | each {|directory|
                if ($directory | path exists) {
                    ls $directory | get name | path parse | update parent "" | path join
                }
            }
            | flatten
            | wrap cmd
        )

        let closest_commands = (
            $commands_in_path
            | insert distance {|it|
                $it.cmd | str distance $cmd
            }
            | uniq
            | sort-by distance
            | get cmd
            | first 10
        )

        let pretty_commands = (
            $closest_commands | each {|cmd|
                $"    (ansi {fg: "default" attr: "di"})($cmd)(ansi reset)"
            }
        )

        $"\ndid you mean?\n($pretty_commands | str join "\n")"
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

    # nupm libraries
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

    # interact with modules and overlays
    {
        name: overlay_use_nupm
        modifier: control
        keycode: char_n
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "overlay use --prefix nupm"
        }
    }
    {
        name: overlay_hide
        modifier: control
        keycode: char_h
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "overlay hide"
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
]

use nu-scripts/themes/themes/nushell-dark.nu
$env.config.color_config = (nushell-dark)
$env.config.color_config.string = {||
    if $in =~ '^#[a-fA-F\d]+' { $in } else { 'white' }
}

let-env NUPM_CONFIG = {
    activations: ($nu.default-config-dir | path join "nupm" "activations.nuon")
    packages: ($nu.default-config-dir | path join "nupm" "packages.nuon")
    set_prompt: true
}

export-env {
    let-env NU_RIGHT_PROMPT_CONFIG = {
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

use nupm/activations *
use std clip
use aliases.nu *
use starship.nu

use ~/.local/share/git/store/github.com/amtoine/zellij-layouts/nu-zellij

match (date now | date format "%m.%d") {
    "03.14" => { print $'Happy (char -i 0x03c0) Day! (char -i 0x1f973)' }
    "06.28" => { print $'Happy (char -i 0x1d70f) Day! (char -i 0x1f973)' }
}
