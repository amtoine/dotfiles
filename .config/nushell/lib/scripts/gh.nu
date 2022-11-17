alias GH_API = gh api --paginate


# TODO: documentation
def unpack-pages [] {
    sd -s "}][{" "},{"
}


# TODO: documentation
def pull [
  endpoint: string
] {
    GH_API $endpoint    # get all the raw data
        | unpack-pages  # split the pages into a single one
        | from json     # convert to JSON internally
}


# TODO: documentation
export def "me notifications" [] {
  pull notifications
}


# TODO: documentation
export def "me issues" [] {
    pull issues
}


# TODO: documentation
export def "me starred" [] {
    pull user/starred
}


# TODO: documentation
export def "me repos" [
  org: string
] {
    pull $"/orgs/($org)/repos"
}
