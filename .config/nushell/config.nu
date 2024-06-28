$env.config = ($env.config? | default {} | merge {
    ls: {
        use_ls_colors: true
        clickable_links: false
    }
    rm: {
        always_trash: true
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
        mode: compact
        index_mode: always
        show_empty: true
        padding: { left: 0, right: 0 }
        header_on_separator: true
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
        use_ls_colors: true
    }
    bracketed_paste: true
    filesize: {
        metric: true
    }
    plugins: {
        explore: {
            margin: 3,
            relativenumber: true,
            colors: {
                line_numbers: {
                    normal: { foreground: [100, 100, 100] },
                    selected: { background: [100, 100, 100] }
                }
            }
        }
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

                    # NOTE: this binding is required as per
                    # https://github.com/nushell/nushell/pull/12601#issuecomment-2069167555
                    let startup_times = open $file | append {
                        date: (date now)
                        time: $nu.startup-time
                        build: $version.build_rust_channel
                        allocator: $version.allocator
                        version: $version.version
                        commit: $version.commit_hash
                        build_time: $version.build_time
                    }
                    $startup_times | save --force $file
                }
            },
            {
                condition: {|_, after| $after | path join 'toolkit.nu' | path exists }
                code: "
                    print $'[(ansi yellow_bold)hook(ansi reset)] loading toolkit'
                    overlay use --prefix toolkit.nu as tk
                    overlay list | str join ', ' | print $'[(ansi yellow_bold)hook(ansi reset)] overlays: ($in)'
                "
            },
            {
                condition: {|_, after| $after | path join '.env.nu' | path exists }
                code: "
                    print $'[(ansi yellow_bold)hook(ansi reset)] loading env file'
                    source .env.nu
                "
            },
            (source nu-hooks/direnv/config.nu)
            {
                condition: {|_, after| $after | path join 'dune-project' | path exists }
                code: "
                    print 'loading OCaml'
                    overlay use ocaml.nu
                    print --no-newline (overlay list)
                "
            },
        ]
    }
    display_output: {|| table }
    command_not_found: { |cmd_name|
        if (which pkgfile | is-empty) {
            return null
        }

        print $"looking for Arch packages that might ship '($cmd_name)'..."
        let pkgs = pkgfile --binaries --verbose $cmd_name
        if ($pkgs | is-empty) {
            return null
        }

        (
            $"(ansi $env.config.color_config.shape_external)($cmd_name)(ansi reset) " +
            $"may be found in the following packages:\n($pkgs)"
        )
    }
}

$env.config.keybindings = [
    {
        name: history_menu
        modifier: alt
        keycode: char_h
        mode: [emacs, vi_insert, vi_normal]
        event: { send: menu name: history_menu }
    }
    # basic shell features
    {
        name: reload
        modifier: alt
        keycode: char_r
        mode: [emacs, vi_insert, vi_normal]
        event: {
            send: executehostcommand,
            cmd: "exec nu"
        }
    }
    {
        name: clear
        modifier: alt
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
    # more
    {
        name: insert_newline
        modifier: alt
        keycode: enter
        mode: [emacs vi_normal vi_insert]
        event: { edit: insertnewline }
    }
]

$env.PROMPT_INDICATOR = ' '
$env.PROMPT_INDICATOR_VI_INSERT = ' '
$env.PROMPT_INDICATOR_VI_NORMAL = ' '

export-env {
    use nu-git-manager-sugar git prompt setup
    setup --duration-threshold 10sec --indicators {
        vi: {
            insert: "> "
            normal: "> "
        }
    }
}

export-env {
    use nu-themes/nushell-dark.nu
    $env.config.color_config = (nushell-dark)
    $env.config.color_config.string = {||
        if $in =~ '^#[a-fA-F\d]+' { $in } else { 'white' }
    }
    $env.config.color_config.shape_garbage = { fg: $env.config.color_config.shape_garbage.bg, attr: u }
    $env.config.color_config.shape_external = { fg: $env.config.color_config.shape_external, attr: u }
    $env.config.color_config.shape_externalarg = { fg: $env.config.color_config.shape_externalarg, attr: u }
    $env.config.color_config.leading_trailing_space_bg = {bg: red}
}

use nu-git-manager *
use nu-git-manager-sugar git *
use nu-git-manager-sugar github *
use nu-git-manager-sugar extra *
use nu-git-manager-sugar dotfiles *
use nu-scripts misc back

use std formats ["from ndjson" "to ndjson"]

source ($nu.default-config-dir | path join "aliases.nu")
source ($nu.default-config-dir | path join "completion.nu")

do {
    let happy_day = "happy-day.nu"
    if not (which $happy_day | is-empty) {
        ^$happy_day
    } else {
        error make --unspanned {
            msg: (
                $"(ansi red_bold)config_script_not_found(ansi reset):\n"
              + $"could not find `($happy_day)` in `$env.PATH`"
            )
        }
    }
}
