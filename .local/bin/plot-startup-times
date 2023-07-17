#!/usr/bin/env nu

def main [file?: path = "~/.local/share/nushell/startup-times.nuon"] {
    if not ($file | path exists) {
        let span = (metadata $file | get span)
        error make {
            msg: $"(ansi red_bold)file_not_found(ansi reset)"
            label: {
                text: "No such file"
                start: $span.start
                end: $span.end
            }
        }
    }

    open $file
        | where time < 1sec
        | update date { date format "%Y-%m-%d-%H" }
        | group-by date
        | transpose date data
        | update data { get time | math avg }
        | get data
        | into int
        | each { $in / 1_000_000 }
        | plot
}
