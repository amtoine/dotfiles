use scripts/context.nu


alias FZF = fzf --ansi --color --reverse

alias FZF_LOG_PREVIEW = "
hash=$(echo {} | \\
  sd -s '|' '' | \\
  sd -s '\\' '' | \\
  sd -s '/' '' | \\
  sd '^\\s*\\*\\s*' '' | \\
  awk '{print $1}'\\
)
[ -z $hash ] || git show --color=always $hash
"
alias FZF_STASH_PREVIEW = "git stash show --all --color=always $(echo {1} | sd ':' '')"


# TODO
def log_error [message: string] {
  print $"gf: (ansi red_bold)error(ansi reset): ($message)"
}


# TODO
def log_debug [message: string] {
  print $"gf: (ansi yellow_bold)debug(ansi reset): ($message)"
}


# TODO
def ungraph [
  commitish: string = "HEAD"
] {
  str replace -as "|" "" |
  str replace -as '\' "" |
  str replace -as "/" "" |
  str replace "^\\s*\\*\\s*" "* "
}


# TODO
export def log [
  commitish: string = "HEAD"
  --all (-a): bool
  --debug (-d): bool
] {
  alias GIT_LOG = git log --graph --oneline --decorate --color=always

  let choice = (
    if ($all) {
      GIT_LOG --branches --remotes=origin
    } else {
      GIT_LOG $commitish
    } |
    FZF --preview (FZF_LOG_PREVIEW) |
    str trim
  )

  # do not try to show the commit if none has been selected!
  if ($choice | is-empty) {
    error make (context user_choose_to_exit)
  }

  let commit = ($choice | ungraph)
  if not ($commit | is-empty) {
    let hash = (
      $commit |
      parse "* {hash} {rest}" |
      get hash
    )
    if ($debug) {
      log_debug $"git show --color=always ($hash)"
    } else {
      git show --color=always $hash
    }
  } else {
    log_error "not a commit"
  }
}


# TODO
export def stash [
  --debug (-d): bool
] {
  let choice = (
    git stash list --color=always |
    FZF --preview (FZF_STASH_PREVIEW) |
    str trim
  )

  # do not try to show the stash if none has been selected!
  if ($choice | is-empty) {
    error make (context user_choose_to_exit)
  }

  let stash_id = (
    $choice |
    parse "{stash}: {rest}" |
    get stash
  )
  if ($debug) {
    log_debug $"git stash show --all --color=always ($stash_id)"
  } else {
    git stash show --all --color=always $stash_id
  }
}


# TODO
export def checkout [] {
  log_error "checkout unsupported"
}


# TODO
export def branch [] {
  log_error "branch unsupported"
}
