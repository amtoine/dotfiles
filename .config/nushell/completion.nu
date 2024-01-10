$env.config.completions.external = {
    enable: true
    max_results: 100
}

$env.config.completions.external.completer = {|tokens: list<string>|
    if (which carapace | is-empty) {
        return
    }

    let expanded_alias = scope aliases | where name == $tokens.0 | get --ignore-errors expansion.0

    let tokens = if $expanded_alias != null  {
        $expanded_alias | split row " " | append ($tokens | skip 1)
    } else {
        $tokens
    }

    let cmd = $tokens.0 | str trim --left --char '^'

    let completions = ^carapace $cmd nushell ...$tokens | from json | default []

    if ($completions | is-empty) {
        let path = $tokens | last

        ls $"($path)*" | each {|it|
            let choice = if ($path | str ends-with "/") {
                $path | path join ($it.name | path basename)
            } else {
                $path | path dirname | path join ($it.name | path basename)
            }

            let choice = if ($it.type == "dir") and (not ($choice | str ends-with "/")) {
                $"($choice)/"
            } else {
                $choice
            }

            if ($choice | str contains " ") {
                $"`($choice)`"
            } else {
                $choice
            }
        }
    } else if ($completions | where value =~ '^.*ERR$' | is-empty) {
        $completions
    } else {
        null
    }
}
