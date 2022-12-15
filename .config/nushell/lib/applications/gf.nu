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

use applications/context.nu


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

alias FZF_CHECKOUT_PREVIEW = "
branch=$(echo {} | \\
  sd -s '*' '' | \\
  sd '^\\s*' '' | \\
  sd ' .*' '' \\
)
git log --graph --decorate --oneline --color=always $branch
"

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
export def checkout [
  --debug (-d): bool
] {
  let choice = (
    git branch --list --color=always | lines |
    append (
      git branch --remote --color=always | lines
    ) |
    sort -r |
    to text |
    FZF --preview (FZF_CHECKOUT_PREVIEW) |
    str trim
  )

  # do not try to show the checkout to a branch if none has been selected!
  if ($choice | is-empty) {
    error make (context user_choose_to_exit)
  }

  let branch = (
    $choice |
    str replace -as "*" "" |
    str replace "^\\s*" "" |
    str replace " .*" ""
  )

  if ($debug) {
    log_debug $"git checkout ($branch)"
  } else {
    git checkout $branch
  }
}


# TODO
export def branch [] {
  log_error "branch unsupported"
}


# TODO
def "git branch wipe" [
  branch: string
  --remote (-r): string = "origin"
] {
  let res = (do -i {
    git rev-parse --verify $branch
  } | complete)

  if ($res.exit_code != 0) {
    print $"wip: (ansi red_bold)error(ansi reset): '($branch)' does not exist..."
  } else {
    git branch --delete --force $branch
    git push $remote $":($branch)"
  }
}