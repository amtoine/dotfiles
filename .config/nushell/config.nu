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
        vi_insert: underscore
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

export-env {
    def "env-change pwd toolkit" [
        --directory: bool
    ] {{
        condition: (if $directory {
            {|_, after| $after | path join 'toolkit' 'mod.nu' | path exists }
        } else {
            {|_, after| $after | path join 'toolkit.nu' | path exists }
        })
        code: ([
            "print -n $'(ansi default_underline)(ansi default_bold)toolkit(ansi reset) module (ansi yellow_italic)detected(ansi reset)... '"
            $"use (if $directory { 'toolkit/' } else { 'toolkit.nu' })"
            "print $'(ansi green_bold)activated!(ansi reset)'"
        ] | str join "\n")
    }}

    $env.config.hooks = {
        pre_prompt: [{||}]
        pre_execution: [{||}]
        env_change: {
            PWD: [
                { code: "hide toolkit" }
                (env-change pwd toolkit)
                (env-change pwd toolkit --directory)
            ]
        }
        display_output: {||
            if (term size).columns >= 100 { table -e } else { table }
        }
    }
}

$env.config.keybindings = [
    {
        name: history_menu
        modifier: control
        keycode: char_x
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: menu name: history_menu }
                { send: menupagenext }
            ]
        }
    }
    {
        name: reload_config
        modifier: control
        keycode: char_r
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand,
            cmd: "exec nu"
        }
    }
    {
        name: open_repo
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
    {
        name: nupm
        modifier: control
        keycode: char_n
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "overlay use --prefix nupm"
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
    # credit to @fdncred
    # https://discord.com/channels/601130461678272522/614593951969574961/1063493778566037566
    # augmented by @vinlet
    # https://discord.com/channels/601130461678272522/614593951969574961/1063822677808250991
    {
        name: fuzzy_history
        modifier: control
        keycode: char_h
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "commandline (
                history
                | each { |it| $it.command }
                | uniq
                | reverse
                | input list --fuzzy
                    $'Please choose a (ansi magenta)command from history(ansi reset):'
            )"
        }
    }
    # credit to @fdncred
    # https://discord.com/channels/601130461678272522/614593951969574961/1063493778566037566
    {
        name: fuzzy_dir
        modifier: control
        keycode: char_s
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "commandline -a (
                ls **/*
                | where type == dir
                | get name
                | input list --fuzzy
                    $'Please choose a (ansi magenta)directory(ansi reset) to (ansi cyan_underline)insert(ansi reset):'
            )"
        }
    }
    {
        name: nu_lib_dirs
        modifier: control
        keycode: char_u
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: '
                commandline --replace "use "
                commandline --insert (
                    $env.NU_LIB_DIRS
                    | each {|dir|
                        ls ($dir | path join "**" "*.nu")
                        | get name
                        | str replace $dir ""
                        | str trim -c "/"
                    }
                    | flatten
                    | input list --fuzzy
                        $"Please choose a (ansi magenta)module(ansi reset) to (ansi cyan_underline)load(ansi reset):"
                )
            '
        }
    }
    {
        name: nupm
        modifier: control
        keycode: char_n
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand
            cmd: "overlay use --prefix nupm"
        }
    }
]

use nupm/activations *
let-env NUPM_CONFIG = {
    activations: ($nu.config-path | path dirname | path join "nupm" "activations.nuon")
    packages: ($nu.config-path | path dirname | path join "nupm" "packages.nuon")
    set_prompt: false
}

$env.config.color_config = (nushell-dark)
$env.config.color_config.string = {||
    if $in =~ '^#[a-fA-F\d]+' { $in } else { 'white' }
}

overlay use aliases.nu

overlay use starship.nu as prompt
export-env {
    use nu-right-prompt
}

use std clip

match (date now | date format "%m.%d") {
    "03.14" => { print $'Happy (char -i 0x03c0) Day! (char -i 0x1f973)' }
    "06.28" => { print $'Happy (char -i 0x1d70f) Day! (char -i 0x1f973)' }
}
