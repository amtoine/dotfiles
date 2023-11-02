# manage dotfiles from anywhere
alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
# edit any config file tracked as dotfiles
alias "cfg edit" = do {
    if $env.DOTFILES_GIT_DIR? == null {
        error make --unspanned {
            msg: (
                $"(ansi red_bold)environment_variable_not_found(ansi reset):\n"
              + $"`(ansi default_dimmed)cfg edit(ansi reset)` requires `(ansi default_dimmed)$env.DOTFILES_GIT_DIR(ansi reset)`"
            )
        }
    }
    if $env.DOTFILES_WORKTREE? == null {
        error make --unspanned {
            msg: (
                $"(ansi red_bold)environment_variable_not_found(ansi reset):\n"
              + $"`(ansi default_dimmed)cfg edit(ansi reset)` requires `(ansi default_dimmed)$env.DOTFILES_WORKTREE(ansi reset)`"
            )
        }
    }

    let git_options = [
        --git-dir $env.DOTFILES_GIT_DIR
        --work-tree $env.DOTFILES_WORKTREE
    ]

    let prompt = $"choose a config file to (ansi cyan_bold)edit(ansi reset):"
    let choice = ^git $git_options ls-files --full-name $env.DOTFILES_WORKTREE
        | lines
        | input list --fuzzy $prompt
    if ($choice | is-empty) {
        return
    }

    let config_file = $env.DOTFILES_WORKTREE | path join $choice

    cd ($config_file | path dirname)
    ^$env.EDITOR $config_file
}

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

alias sl = ^sl -aw -20

# show the disk usage
alias "sys disk" = do { use nu-goat-scripts sys; sys disk }

alias tree = nix run nixpkgs#tree
alias firefox = nix run nixpkgs#firefox
alias acpi = nix run nixpkgs#acpi
alias tldr = nix run nixpkgs#tldr --
alias gh = nix run nixpkgs#gh --
alias grip = nix run nixpkgs#python310Packages.grip --
