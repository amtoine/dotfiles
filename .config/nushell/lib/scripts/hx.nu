export def "get info" [] {
  hx --health |
  lines |
  take 6 |
  split column ": " |
  transpose -ird
}


export def "get languages" [] {
  hx --health languages |
  lines |
  skip 1 |
  split column " " |
  get column1
}


export def "get lsp progress" [] {
  let languages = (get languages)

  let lsp = (
    for language -n in $languages {
      print -n $"(ansi erase_line)"
      print -n $"loading language support [($language.index + 1) / ($languages | length)]: ($language.item)\r"

      {language: $language.item} |
      merge {
        hx --health $language.item | lines | split column ": " | transpose -ird
      }
    }
  )
  print -n $"(ansi erase_line)"
  print "loading language support [done]"

  $lsp
}


export def "get lsp" [] {
  for language in (get languages) {
    {language: $language} |
    merge {
      hx --health $language | lines | split column ": " | transpose -ird
    }
  }
}


export def "get health" [] {
  {
    info: (get info)
    languages: (get languages)
    lsp: (get lsp progress)
  }
}