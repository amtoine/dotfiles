def get_info [] {
  hx --health |
  lines |
  take 6 |
  split column ": " |
  transpose -ird
}


def get_languages [] {
  hx --health languages |
  lines |
  skip 1 |
  split column " " |
  get column1
}


def get_lsp_progress [] {
  let languages = (get_languages)

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


def get_lsp [] {
  for language in (get_languages) {
    {language: $language} |
    merge {
      hx --health $language | lines | split column ": " | transpose -ird
    }
  }
}


export def get_health [] {
  {
    info: (get_info)
    languages: (get_languages)
    lsp: (get_lsp_progress)
  }
}