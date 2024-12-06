const CONFIG = $nu.home-path | path join ".config" "alacritty"
const SHARE = $nu.home-path | path join ".local" "share" "alacritty"

const REMOTE = "https://github.com/alacritty/alacritty-theme"
const LOCAL = $SHARE | path join "themes"
const THEMES = $LOCAL | path join "themes"

const THEME = $SHARE | path join "theme.toml"
const THEME_NAME = $CONFIG | path join "theme.txt"

def is_downloaded []: nothing -> bool {
    $THEMES | path exists
}

def is_theme_set []: nothing -> bool {
    $THEME | path exists
}

def is_theme_name_set []: nothing -> bool {
    $THEME_NAME | path exists
}

export def "alacritty theme install" [--verbose] {
    if (is_downloaded) {
        error make --unspanned { msg: "themes are already installed" }
    }

    print --no-newline "installing themes... "
    let options = [ --depth 1 $REMOTE ($THEMES | path dirname) ]
    if $verbose {
        print ""
        git clone ...$options
    } else {
        git clone ...$options out+err> /dev/null
    }
    print "done"
}

export def "alacritty theme update" [--verbose] {
    if not (is_downloaded) {
        error make --unspanned { msg: "themes are not installed" }
    }

    print --no-newline "updating themes... "
    if $verbose {
        print ""
        git -C $LOCAL fetch origin master
        git -C $LOCAL rebase origin/master
    } else {
        git -C $LOCAL fetch origin master out+err> /dev/null
        git -C $LOCAL rebase origin/master out+err> /dev/null
    }
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
    $res | save -f $THEME_NAME
    print "done"

    print "[!] don't forget to restart Alacritty"
}

export def "alacritty theme current" []: [
    nothing -> record<
        name: string,
        colors: record<
            bright: record<
                black: string,
                blue: string,
                cyan: string,
                green: string,
                magenta: string,
                red: string,
                white: string,
                yellow: string,
            >,
            normal: record<
                black: string,
                blue: string,
                cyan: string,
                green: string,
                magenta: string,
                red: string,
                white: string,
                yellow: string,
            >,
            primary: record<
                background: string,
               foreground: string,
            >
        >
    >
] {
    if not (is_downloaded) {
        error make --unspanned { msg: "themes are not installed" }
    }
    if not (is_theme_set) {
        error make --unspanned { msg: "theme is not set" }
    }
    if not (is_theme_name_set) {
        error make --unspanned { msg: "unexpected: theme name could not be found" }
    }

    {
        name: (open $THEME_NAME),
        colors: (open $THEME).colors,
    }
}

export def "alacritty theme sync" []: {
    if not (is_downloaded) {
        error make --unspanned { msg: "themes are not installed" }
    }
    if not (is_theme_set) {
        error make --unspanned { msg: "theme is not set" }
    }
    if not (is_theme_name_set) {
        error make --unspanned { msg: "unexpected: theme name could not be found" }
    }

    let theme_name = open $THEME_NAME | lines | first | str trim
    let theme = $THEMES
        | path join $theme_name
        | path parse
        | update extension toml
        | path join

    if not ($theme | path exists) {
        let themes_list = mktemp --tmpdir XXXXXXX.txt
        ls $THEMES | get name | path parse | get stem | sort | to text | save --force $themes_list

        error make --unspanned {
            msg: $"unknown theme ($theme_name)",
            help: $"see the complete list of available themes in (ansi purple)($themes_list)(ansi reset)",
        }
    }

    print --no-newline $"switching theme to '($theme_name)'... "
    cp $theme $THEME
    print "done"
}
