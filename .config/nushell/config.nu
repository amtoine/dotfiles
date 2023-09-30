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
    }
    bracketed_paste: true
    filesize: {
        metric: true
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
                code: "overlay use --prefix toolkit.nu as tk"
            }
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
    shell_prompt setup --pwd-mode "git" --indicators {vi: {
        insert: "> "
        normal: "> "
    }} --duration-threshold 10sec
}

export-env {
    use nu-scripts/themes/themes/nushell-dark.nu
    $env.config.color_config = (nushell-dark)
    $env.config.color_config.string = {||
        if $in =~ '^#[a-fA-F\d]+' { $in } else { 'white' }
    }
    $env.config.color_config.shape_garbage = { fg: $env.config.color_config.shape_garbage.bg, attr: u }
    $env.config.color_config.shape_external = { fg: $env.config.color_config.shape_external, attr: u }
    $env.config.color_config.shape_externalarg = { fg: $env.config.color_config.shape_externalarg, attr: u }
    $env.config.color_config.leading_trailing_space_bg = {bg: red}
}

use nu-git-manager gm
use nu-git-manager sugar completions git *
use nu-git-manager sugar dotfiles
use nu-git-manager sugar gh
use nu-git-manager sugar gist
use nu-git-manager sugar git
use nu-goat-scripts misc back
use nu-goat-scripts misc edit

use std clip
use std formats "from ndjson"

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
alias ex = nu_plugin_explore ($env.explore_config? | default {})

alias news = ^nushell-news.nu --force
alias passmenu = ^passme.nu -l 10 -bw 5 -fn "mononoki Nerd Font-20" --notify
alias bye = ^logout.nu --lock "slock"
alias gghn = do { ^gh-notifications.nu --notify --max-notifications 5 | ignore }

# related to https://github.com/nushell/nushell/pull/10097
alias "core cp" = cp
alias cp = ucp

alias sl = ^sl -aw -20

alias try-nu = cargo run -- -e "$env.PROMPT_COMMAND_RIGHT = 'CARGO RUN'"

happy-day.nu

source ($nu.default-config-dir | path join "completion.nu")
