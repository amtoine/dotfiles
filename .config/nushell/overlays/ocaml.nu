export def "opam switch-list" []: nothing -> table<switch: string, current: bool> {
    ^opam switch list --short
        | lines
        | wrap switch
        | insert current {|it| $it.switch == (^opam switch show)}
        | update switch { str replace (pwd) "." | str replace $nu.home-path "~" }
}

export def --env "opam switch-activate" [--switch: string = "default"]: nothing -> nothing {
    ^opam env --switch $switch --set-switch
        | lines
        | parse "{name}='{value}'; export {rest}"
        | reject rest
        | transpose --header-row
        | into record
        | update PATH { split row (char esep) }
        | load-env
}

export-env {
    let res = do { ^opam env } | complete
    if $res.exit_code != 0 {
        ^opam init
    }

    opam switch-activate
}
