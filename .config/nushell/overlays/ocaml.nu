export def --env "opam switch-activate" []: nothing -> nothing {
    ^opam env
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
