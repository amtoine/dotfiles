export-env {
    load-env {
        PROMPT_MULTILINE_INDICATOR_COLORS: [
            "red_dimmed"
            "yellow_dimmed"
            "green_dimmed"
        ]
        PROMPT_MULTILINE_INDICATOR_CHARACTER: ':'
    }
    let-env PROMPT_MULTILINE_INDICATOR = ((
        $env.PROMPT_MULTILINE_INDICATOR_COLORS
        | each {|color| ansi $color }
        | append (ansi reset)
        | str join $env.PROMPT_MULTILINE_INDICATOR_CHARACTER
    ) + " ")
}
