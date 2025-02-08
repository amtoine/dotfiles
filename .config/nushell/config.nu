$env.config = ($env.config? | default {} | merge {
    ls: {
        use_ls_colors: true
        clickable_links: false
    }
    rm: {
        always_trash: true
    }
    history: {
        max_size: 100000,
        sync_on_enter: true,
        file_format: "sqlite"
        isolation: false
    }
    cursor_shape: {
        emacs: inherit,
        vi_insert: line
        vi_normal: block
    }
    table: {
        mode: compact
        index_mode: always
        show_empty: true
        padding: { left: 0, right: 0 }
        header_on_separator: true
        trim: {
            methodology: wrapping,
            wrapping_try_keep_words: true
        },
        abbreviated_row_count: null,
        footer_inheritance: false
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
        sort: smart,
        quick: true,
        partial: true,
        external: {
            enable: true,
            max_results: 100,
            completer: null
        },
    }
    bracketed_paste: true
    filesize: {
        metric: true
        format: auto
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
    display_errors: { exit_code: false, termination_signal: true }
})

use nu-hooks/nuenv/hook.nu [ "nuenv allow", "nuenv disallow" ]

$env.config.hooks = {
    env_change: {
        PWD: [
            (use nu-hooks/startup-times.nu; startup-times setup)
            (
                use nu-hooks/toolkit.nu;
                toolkit setup --name "tk" --color "yellow_bold"
            )
            (use nu-hooks/nuenv/hook.nu; hook setup)
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

export-env {
    def cmd [cmd: string]: [ nothing -> record<send: string, cmd: string> ] {
        {
            send: executehostcommand,
            cmd: $cmd,
        }
    }

    def vi [--insert (-i), --normal (-n)]: [ nothing -> list<string> ] {
        if $insert and $normal {
            [vi_insert, vi_normal]
        } else if $insert {
            [vi_insert]
        } else if $normal {
            [vi_normal]
        } else {
            [emacs]
        }
    }

    $env.config.keybindings = [
        [ name,           modifier, keycode,  mode,     event ];
        [ history_menu,   alt,      char_h,   (vi -in), { send: menu, name: history_menu } ],
        # basic shell features
        [ reload,         alt,      char_r,   (vi -in), (cmd "exec nu") ],
        [ clear,          alt,      char_l,   (vi -in), (cmd "clear") ]
        [ exit,           none,     char_q,   (vi -n),  (cmd "exit") ],
        # more
        [ insert_newline, alt,      enter,    (vi -in), { edit: insertnewline } ],
        [ oil,            NONE,     "char_-", (vi -n),  (cmd "nvim -c ':Oil'") ],
    ]
}

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

use nu-pager-help help

use std formats [ "from ndjson", "to ndjson", "from ndnuon", "to ndnuon" ]

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
