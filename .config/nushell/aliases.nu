alias ll = ls --all --long

alias te = table --expand
alias ex = nu_plugin_explore

alias passmenu = do {
    let res = glob ($env.PASSWORD_STORE_DIR | path join "**/*.gpg")
        | parse --regex $'^($env.PASSWORD_STORE_DIR)(char path_sep)(char lparen)?<entry>.*(char rparen)\.gpg'
        | get entry
        | input list --fuzzy
    if $res == null {
        return
    }

    ^pass show -c $res
}

# show the disk usage
alias "sys disk" = do { use nu-scripts sys; sys disk }
# open PDF documents in Okular
alias "pdf" = do { use nu-scripts misc "open pdf"; open pdf --no-swallow }

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
alias clip = clipboard copy
# copy the input to the system's clipboard without showing the content, "safely"
alias sclip = do { clipboard copy | ignore }
# paste from the system's clipboard to the output
alias paste = clipboard paste

alias lg = lazygit
