# TODO: documentation
export def "get info" [] {
  hx --health |
  lines |
  take 6 |
  split column ": " |
  transpose -ird
}


# TODO: documentation
export def "get languages" [
  --quiet (-q): bool
] {
  let languages = (
    hx --health languages |
    lines |
    skip 1 |
    split column " " |
    get column1
  )
  if (not $quiet) and (($languages | find "…" | length) != 0) {
    error make {msg: "hx --health languages", label: {text: "terminal too narrow"}}
  }
  $languages
}


# TODO: documentation
export def "get lsp" [
  --progress (-p): bool
] {
  let languages = (get languages --quiet)

  let lsp = (
    for language -n in $languages {
      if ($progress) {
        print -n $"(ansi erase_line)"
        print -n $"loading language support [($language.index + 1) / ($languages | length)]: ($language.item)\r"
      }

      {language: $language.item} |
      merge {
        hx --health $language.item | lines | split column ": " | transpose -ird
      }
    }
  )
  if ($progress) {
    print -n $"(ansi erase_line)"
    print "loading language support [done]"
  }

  $lsp
}


# TODO: documentation
export def "get health" [] {
  let health = {
    info: (get info)
    languages: (get languages --quiet)
    lsp: (get lsp --progress)
  }
  if (($health.languages | find "…" | length) != 0) {
    print $"hx get health: (ansi yellow_bold)warning(ansi reset): terminal too narrow"
    print "health record might not be well formatted because of '…'"
  }
  $health
}