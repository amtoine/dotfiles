use applications/prompt.nu

alias FZF_PICK_PREVIEW = "
path=$(ghq root)/$(echo {} | sed 's/: /.com\\//')
echo "TREE:"
git -C $path --no-pager log --graph --branches --remotes --tags --oneline --decorate --simplify-by-decoration -n 10 --color=always
echo ""
echo "STATUS:"
git -C $path --no-pager status --short
echo ""
echo "STASHES:"
git -C $path --no-pager stash list
echo ""
echo "FILES:"
ls -la --color=always $path | awk '{print $1,$9}'
"


# TODO
def pick_repo [
    prompt: string
] {
    let choice = (
        ghq list |
        lines |
        str replace ".com/" ": " |
        sort --ignore-case |
        prompt fzf_ask $prompt (FZF_PICK_PREVIEW) |
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
}


# TODO
export def pull [
    owner: string = $"(git config --get user.name | str trim)"
] {
    let choice = (
        gh repo list $owner --json name |
        from json |
        get name |
        sort --ignore-case |
        uniq |
        prompt fzf_ask $"Please choose a repo to pull from https://github.com/($owner): "
    )

    let repository = ([$owner $choice] | str collect "/")

    ghq get -p $repository
}


# TODO
export def remove [] {
    let repo = (pick_repo "Please choose a repo to remove: ")

    let path = ($env.GHQ_ROOT | path join $repo)

    rm --trash --interactive --recursive $path
}
