use scripts/prompt.nu


# TODO
def pick_repo [
    prompt: string
] {
    let choice = (
        ghq list |
        lines |
        str replace ".com/" ": " |
        sort --insensitive |
        prompt fzf_ask $prompt |
        str replace ": " ".com/"
    )

    $choice
}


# TODO
export def-env goto [] {
    # jump to any repo registered with ghq.
    #
    # the function will:
    #   - (1) do nothing and abort when selecting no repo.
    #   - (2) jump to the selected repo and print the content of the repo.
    #
    # dependencies:
    #   - ghq
    #   - fzf
    #
    let choice = (pick_repo "Please choose a repo to jump to: ")

    # compute the directory to jump to.
    let path = (
        ghq root
           | str trim
           | path join $choice
        )
    cd $path

    # print a little message.
    print $"Jumping to ($path)"

    # the content of the repo.
    print "\nCONTENT:"
    ls

    # the status of the repo, in short format,
    # if anything to report.
    if not (^git status --short | is-empty) {
        print "\nSTATUS:"
        ^git --no-pager status --short
    } else {
        print "\nEVERYTHING UP TO DATE!"
    }

    # the list of stashes, if any.
    if not (^git stash list | is-empty) {
        print "\nSTASHES:"
        ^git --no-pager stash list
    } else {
        print "\nNO STASH..."
    }

    # the current tree in compact form.
    print "\nLOG:"
    ^git --no-pager log --graph --branches --remotes --tags --oneline --decorate --simplify-by-decoration -n 10
}


# TODO
export def pull [
    owner: string = $"(git config --get user.name | str trim)"
] {
    let choice = (
        gh repo list $owner --json name |
        from json |
        get name |
        sort --insensitive |
        uniq |
        prompt fzf_ask $"Please choose a repo to pull from https://github.com/($owner)"
    )

    let repository = ([$owner $choice] | str collect "/")

    ghq get -p $repository
}


# TODO
export def remove [] {
    let repo = (pick_repo "Please choose a repo to remove: ")

    let path = ($env.GHQ_ROOT | path join $repo)

    rm --interactive --recursive $path
}
