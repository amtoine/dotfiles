$env.config.completions.external = {
    enable: true
    max_results: 100
}

$env.config.completions.external.completer = {|tokens: list<string>|
    let expanded_alias = scope aliases | where name == $tokens.0 | get --ignore-errors expansion.0

    let tokens = if $expanded_alias != null  {
        $expanded_alias | split row "" | append ($tokens | skip 1)
    } else {
        $tokens
    }

    let completions = carapace $tokens.0 nushell $tokens | from json | default []

    if ($completions | where value =~ '^-.*ERR$' | is-empty) {
        $completions
    } else {
        null
    }
}
