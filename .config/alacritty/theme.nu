use std log

# install a TOML theme for Alacritty
#
# you should add the following line to the top of your `alacritty.toml`
# ```toml
# import = ["~/.config/alacritty/theme.toml"]
# ```
export def alacritty-theme [
    --revision: string = "808b81b2e88884e8eca5d951b89f54983fa6c237"
    --theme-file: path = "~/.config/alacritty/theme.toml"
]: nothing -> nothing {
    const REPO = "alacritty/alacritty-theme"

    log debug $"pulling down the list of themes from ($REPO)..."
    let res = http get $"https://github.com/($REPO)/tree/($revision)/themes"
        | from json
        | get payload.tree.items.name
        | path parse
        | get stem
        | input list --fuzzy "Please choose a theme to use in Alacritty"
    if $res == null {
        return
    }

    log debug $"pulling theme '($res)' from ($REPO)"
    let theme = http get $"https://raw.githubusercontent.com/($REPO)/($revision)/themes/($res).yaml"
        | to toml

    log debug $"saving '($res)' to `($theme_file)`"
    $theme | save --force $theme_file

    log info "you can now restart Alacritty and enjoy the new theme!"
}

