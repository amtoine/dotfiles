alias "core from nuon" = from nuon

def "from nuon" []: string -> any {
    let content = $in
        | str replace --regex '^\s*{' ''
        | str replace --regex '}\s*$' ''
        | lines --skip-empty
        | str trim
        | str join ', '

    if ($content | str starts-with "[") {
        $content | core from nuon
    } else {
        try {
            $"{($content)}" | core from nuon
        } catch {
            $content | core from nuon
        }
    }
}

def "from ndjson" []: string -> any {
    from json --objects
}
