# TODO: documentation
def unpack-pages [] {
    sd -s "}][{" "},{"
}


# TODO: documentation
def pull [
  endpoint: string
] {
    gh api --paginate $endpoint  # get all the raw data
        | unpack-pages           # split the pages into a single one
        | from json              # convert to JSON internally
}


# TODO: documentation
export def "me notifications" [] {
    pull /notifications
}


# TODO: documentation
export def "me issues" [] {
    pull /issues
}


# TODO: documentation
export def "me starred" [
    --reduce (-r): bool
] {
    if ($reduce) {
        pull /user/starred
        | select -i id name description owner.login clone_url fork license.name created_at pushed_at homepage archived topics size stargazers_count language
    } else {
        pull /user/starred
    }
}


# TODO: documentation
export def "me repos" [
  owner: string
  --user (-u): bool
] {
    let root = if ($user) { "users" } else { "orgs" }
    pull $"/($root)/($owner)/repos"
}


# TODO: documentation
export def "me protection" [
  owner: string
  repo: string
  branch: string
] {
    pull (["" "repos" $owner $repo "branches" $branch "protection"] | str collect "/")
}
