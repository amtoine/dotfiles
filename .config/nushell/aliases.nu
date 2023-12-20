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
alias passmenu = do {
    let res = glob ($env.PASSWORD_STORE_DIR | path join "**/*.gpg")
        | parse --regex $'^($env.PASSWORD_STORE_DIR)(char path_sep)(char lparen)?<entry>.*(char rparen)\.gpg'
        | get entry
        | input list --fuzzy
    if $res == null {
        return
    }

    nix run nixpkgs#pass -- show -c $res
}
alias bye = ^nu-logout.nu --lock "slock"
alias gghn = do { ^gh-notifications.nu --notify --max-notifications 5 | ignore }

alias sl = ^sl -aw -20

# show the disk usage
alias "sys disk" = do { use nu-scripts sys; sys disk }
# open PDF documents in Okular
alias "pdf" = do { use nu-scripts misc "open pdf"; open pdf --no-swallow true }

alias tree = nix run nixpkgs#tree --
alias firefox = nix run nixpkgs#firefox --
alias acpi = nix run nixpkgs#acpi --
alias tldr = nix run nixpkgs#tldr --
alias gh = nix run nixpkgs#gh --
alias grip = nix run nixpkgs#python310Packages.grip --
alias pass = nix run nixpkgs#pass --
alias feh = nix run nixpkgs#feh --
alias kolourpaint = nix run nixpkgs#kolourpaint --
alias glow = nix run nixpkgs#glow --
alias ncdu = nix run nixpkgs#ncdu --
alias flameshot = nix run nixpkgs#flameshot --
alias vim = nix run nixpkgs#vim -- -u NONE
alias npm = nix shell nixpkgs#nodejs --command npm
alias okular = nix run nixpkgs#okular --

# jump to any repository managed by `nu-git-manager`
alias "gm jump" = do --env {
    let res = gm list | input list --fuzzy "Please chose a directory to jump to"
    if $res == null {
        return
    }

    cd (gm status | get root.path | path join $res)
}

# download the latest nightly build of Nushell
alias "nightly update" = do {
    const MODULE = ($nu.temp-path | path join "nightly.nu")

    http get https://raw.githubusercontent.com/nushell/nightly/nightly/toolkit.nu
        | save --force --progress $MODULE

    ^$nu.current-exe --commands $"
        use ($MODULE) *
        get-latest-nightly-build
    "
}

# copy the input to the system's clipboard
alias clip = clipboard copy --daemon
# paste from the system's clipboard to the output
alias paste = clipboard paste
