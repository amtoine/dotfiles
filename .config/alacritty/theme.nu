const SHARE = ($nu.home-path | path join ".local" "share" "alacritty")
const LOCAL = ($SHARE | path join "themes")
const THEMES = ($LOCAL | path join "themes")
const REMOTE = "https://github.com/alacritty/alacritty-theme"

def is_downloaded []: nothing -> bool {
    $THEMES | path exists
}

export def "alacritty theme install" [] {
    if (is_downloaded) {
        error make --unspanned { msg: "themes are already installed" }
    }

    print --no-newline "installing themes... "
    git clone --depth 1 $REMOTE ($THEMES | path dirname) out+err> /dev/null
    print "done"
}

export def "alacritty theme update" [] {
    if not (is_downloaded) {
        error make --unspanned { msg: "themes are not installed" }
    }

    print --no-newline "updating themes... "
    git -C $LOCAL fetch origin master out+err> /dev/null
    git -C $LOCAL rebase origin/master out> /dev/null
    print "done"
}

# switch to another theme for Alacritty
#
# you should add the following line to the top of your `alacritty.toml`
# ```toml
# import = ["~/.local/share/alacritty/theme.toml"]
# ```
export def "alacritty theme switch" [] {
    if not (is_downloaded) {
        error make --unspanned { msg: "themes are not installed" }
    }

    let res = ls $THEMES | get name | each { path parse } | get stem | input list --fuzzy
    if $res == null {
        print "user chose to exit"
        return
    }

    print --no-newline $"switching theme to '($res)'... "
    cp ($THEMES | path join $"($res).toml") ($SHARE | path join "theme.toml")
    print "done"

    print "[!] don't forget to restart Alacritty"
}
