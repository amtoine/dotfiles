const QUICKMARKS = "~/.config/qutebrowser/quickmarks" | path expand
const BOOKMARKS = "~/.config/qutebrowser/bookmarks/urls" | path expand

const TEMPLATE = "
<DL>
    <DT><H3>{{FOLDER_NAME}}</H3></DT>
    <DL>
{{MARKS}}
    </DL>
</DL>
"

def read-marks [--reversed]: [ path -> string ] {
    open $in | lines | if $reversed { parse "{url} {name}" } else { parse "{name} {url}" } | each {
        $"        <DT><A HREF=\"($in.url)\">($in.name)</A></DT>"
    } | str join "\n"
}

export def "convert qutebrowser-to-firefox" [--dest: path = $nu.temp-path] {
    $TEMPLATE
        | str replace "{{FOLDER_NAME}}" "Quickmarks"
        | str replace "{{MARKS}}" ($QUICKMARKS | read-marks)
        | save --force ($dest | path join qutebrowser-to-firefox-quickmarks.html)

    $TEMPLATE
        | str replace "{{FOLDER_NAME}}" "Bookmarks"
        | str replace "{{MARKS}}" ($BOOKMARKS | read-marks --reversed)
        | save --force ($dest | path join qutebrowser-to-firefox-bookmarks.html)
}
