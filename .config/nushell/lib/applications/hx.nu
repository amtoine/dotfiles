#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

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
  --quiet (-q): bool
] {
  let languages = if ($quiet) {
    get languages --quiet
  } else {
    get languages
  }

  let lsp = (
    $languages
    | each {|language id|
      if ($progress) {
        print -n $"(ansi erase_line)"
        print -n $"loading language support [($id + 1) / ($languages | length)]: ($language)\r"
      }

      {language: $language.item} |
      merge (
        helix --health $language.item | lines | split column ": " | transpose -ird
      )
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
    lsp: (get lsp --progress --quiet)
  }
  if (($health.languages | find "…" | length) != 0) {
    print $"hx get health: (ansi yellow_bold)warning(ansi reset): terminal too narrow"
    print "health record might not be well formatted because of '…'"
  }
  $health
}