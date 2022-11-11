# TODO: documentation
export def "get info" [] {
  hx --health |
  lines |
  take 6 |
  split column ": " |
  transpose -ird
}


# TODO: documentation
export def "get languages" [] {
  hx --health languages |
  lines |
  skip 1 |
  split column " " |
  get column1
}


# TODO: documentation
export def "get lsp" [
  --progress (-p): bool
] {
  let languages = (get languages)

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
  {
    info: (get info)
    languages: (get languages)
    lsp: (get lsp --progress)
  }
}