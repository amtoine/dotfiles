export def "nix hm generations" []: [ nothing -> table<date: datetime, gen: int, path: string> ] {
    home-manager generations
        | parse "{date} : id {gen} -> {path}"
        | into datetime date
        | into int gen
}

export def "nix generations" []: [
    nothing -> table<
        date: datetime,
        previous: int,
        version: int,
        changes: table<package: string, before: string, after: string>,
    >
] {
    nix profile history
        | lines
        | ansi strip
        | split list ''
        | each {
            let gen = $in.0
                | parse "Version {g} ({d}){p}:"
                | into record
                | update p {
                    let res = $in | parse " <- {p}" | into record
                    if not ($res | is-empty) { $res.p | into int }
                }
                | into datetime d
                | into int g
            let changes = $in | skip 1 | parse "  {package}: {before} -> {after}"

            $gen | insert changes $changes
        }
        | move d --before g
        | move p --before g
        | rename --column { g: "generation", d: "date", p: "previous" }
}
