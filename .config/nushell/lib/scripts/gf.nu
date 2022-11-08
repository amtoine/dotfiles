use scripts/context.nu


# TODO
export def log [
  commitish: string = "HEAD"
  --all (-a): bool
] {
  alias GIT_LOG = git log --graph --oneline --decorate --color=always

  let commit = (
    if ($all) {
      GIT_LOG --branches --remotes=origin
    } else {
      GIT_LOG $commitish
    } |
    fzf --ansi --color --reverse --preview 'git show --color=always {2}'
  )

  # do not try to show the commit if none has been selected!
  if ($commit | is-empty) {
    error make (context user_choose_to_exit)
  }

  let hash = ($commit | parse "* {hash} {rest}" | get hash)
  git show --color=always $hash
}


# TODO
export def stash [] {
  let choice = (
    git stash list --color=always |
    fzf --ansi --color --reverse --preview "git stash show --all --color=always $(echo {1} | sd ':' '')"
  )

  # do not try to show the commit if none has been selected!
  if ($choice | is-empty) {
    error make (context user_choose_to_exit)
  }

  git stash show --all --color=always ($choice| parse "{stash}: {rest}" | get stash)
}
