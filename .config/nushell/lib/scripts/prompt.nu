use scripts/context.nu


# TODO
export def fzf_ask [
    prompt: string
] {
    let choice = (
        $in |
        to text |
        fzf --prompt $prompt --ansi |
        str trim
    )

    if ($choice | is-empty) {
        error make (context user_choose_to_exit)
    }

    $choice
}
