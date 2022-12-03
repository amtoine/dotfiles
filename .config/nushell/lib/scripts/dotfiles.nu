use scripts/prompt.nu

alias GIT = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE


# TODO
export def-env edit [] {
    # jump to any config file with $env.EDITOR
    #
    # the function will:
    #   - (1) do nothing and abort when selecting no config file.
    #   - (2) jump to the selected file and start it in a buffer
    #
    # dependencies:
    #   - $env.EDITOR
    #   - fzf
    #
    let choice = (
        GIT lf --full-name ~ |
        prompt fzf_ask "Please choose a config file to edit: "
    )

    let path = ($env.HOME | path join $choice)
    let directory = ($path | path dirname)
    let filename = ($path | path basename)

    cd $directory
    ^$env.EDITOR $filename
    cd -
}


# TODO
export def find [
    regex: string
    --files-only (-f): bool
    --edit (-e): bool
] {
    print $"Looking for config files matching '($regex)'..."
    let matches = (
        GIT lf --full-name ~
            | lines 
            | each {
                |it|
                grep -w $regex -H $it
              }
            | lines
            | str replace ":" ":GOATFILES-CFGF:"
            | split column ":GOATFILES-CFGF:"
            | rename file match
    )

    if ($edit) {
        ^$env.EDITOR ($matches | get file | sort | uniq)
    } else if ($files_only) {
        $matches | get file | sort | uniq
    } else {
        $matches
    }
}


# TODO
def pick_worktree [
    bare: string
    prompt: string
] {
    git --git-dir $bare --work-tree $env.DOTFILES_WORKTREE worktree list |
    str replace --all $"($env.DOTFILES_WORKTREE)" "~~" |
    prompt fzf_ask $prompt
}


# jump to any worktree of your dotfiles with fzf
#
#  . for an introduction to what `git` *worktrees* are:
#        https://youtu.be/2uEqYw-N8uE
#
#  . this will only work for dotfiles managed with a *bare*
#    `git` repository, e.g. with `git` directory at `~/.dotfiles`
#    and a working directory at `~`, i.e. my current setup.
#
#  . in the following, `cfg` is an alias for:
#        git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
#
#  . worktrees can be added with, for instance:
#        cfg worktree add some/path/to/worktree my_branch
#
#  . and then `dotfiles worktree` will let you pick one of the worktrees
export def-env "worktree goto" [
    --bare (-b): string = $"($env.DOTFILES_GIT_DIR)"  # the path to the *bare* repository (defaults to $env.DOTFILES_GIT_DIR)
    --debug (-d)
] {
    let worktree = (pick_worktree $bare "Please choose a worktree to jump to: ")

    # compute the directory to jump to.
    let path = (
        $worktree |
        lines |
        split column "  " |
        get column1 |
        str replace --all "~~" $"($env.DOTFILES_WORKTREE)" |
        to text
    )
    cd $path

    if ($debug) {
        $"path: '($path)'"
    }

}


# TODO
export def "worktree add" [
    --all (-a)
] {
    let branches = if ($all) {
        GIT branch --all | lines
    } else {
        GIT branch | lines
    }

    let branch = (
        $branches |
        str replace "  " "" |
        sort --ignore-case |
        to text |
        str replace --all "\\* (.*)" $"(ansi red)\$1(ansi reset)" |
        str replace --all "\\+ (.*)" $"(ansi yellow)\$1(ansi reset)" |
        prompt fzf_ask "Please choose a branch to create a worktree from: "
    )

    let path = ($env.DOTFILES_GIT_DIR | path join "worktrees" $branch)

    GIT worktree add $path $branch
}


# TODO
export def "worktree remove" [
    --bare (-b): string = $"($env.DOTFILES_GIT_DIR)"  # the path to the *bare* repository (defaults to $env.DOTFILES_GIT_DIR)
] {
    let worktree = (pick_worktree $bare "Please choose a worktree to remove: ")

    let path = (
        $worktree |
        parse "{path} {rest}" |
        get path |
        str replace "~~" $"($env.DOTFILES_WORKTREE)" |
        to text
    )
    GIT worktree remove $path
}
