use scripts/context.nu


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
    let choice = (
        ghq list |
        lines |
        str replace ".com/" ": " |
        sort --insensitive |
        to text |
        fzf |
        str trim |
        str replace ": " ".com/"
    )

    if ($choice | empty?) {
        error make (context user_choose_to_exit)
    }

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
    if not (^git status --short | empty?) {
        print "\nSTATUS:"
        ^git --no-pager status --short
    } else {
        print "\nEVERYTHING UP TO DATE!"
    }

    # the list of stashes, if any.
    if not (^git stash list | empty?) {
        print "\nSTASHES:"
        ^git --no-pager stash list
    } else {
        print "\nNO STASH..."
    }

    # the current tree in compact form.
    print "\nLOG:"
    ^git --no-pager log --graph --branches --remotes --tags --oneline --decorate --simplify-by-decoration -n 10
}
