#!/usr/bin/env -S nu --config ~/.config/nushell/config.nu --env-config ~/.config/nushell/env.nu

overlay use ~/.local/share/venvs/gplt/bin/activate.nu

let history = history

$history
    | insert len { $in.command | str length }
    | get len
    | uniq --count
    | sort-by value
    | gplt plot ($in | rename --column { value: x, count: y } | [{points: $in}] | to json) ...[
        --x-scale log
        --x-scale-base 10
        --x-label "command length"
        --y-label "occurrence"
        --title (do {
            let start = $history | first | get start_timestamp | format date '%F'
            let end = $history | last | get start_timestamp | format date '%F'
            $"command lenghts occurences over time \(($start) -> ($end)\)"
        })
        --fullscreen
        --save history.png
    ]
