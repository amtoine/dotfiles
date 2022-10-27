use scripts/context.nu


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
        ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE lf --full-name ~ |
        fzf |
        str trim
    )

    if ($choice | empty?) {
        error make (context user_choose_to_exit)
    }

    let path = ($env.HOME | path join $choice)
    let directory = (dirname $path | str trim)
    let filename = (basename $path | str trim)

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
        ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE lf --full-name ~ |
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
export def-env worktree [
    --bare (-b): string = $"($env.DOTFILES_GIT_DIR)"  # the path to the *bare* repository (defaults to $env.DOTFILES_GIT_DIR)
    --debug (-d)
] {
    let choice = (
        git --git-dir $bare --work-tree $env.DOTFILES_WORKTREE worktree list |
        str replace --all $"($env.DOTFILES_WORKTREE)" "~~" |
        fzf --prompt "Please choose a worktree to jump to: " |
        str trim
    )

    if ($choice | empty?) {
        error make (context user_choose_to_exit)
    }

    # compute the directory to jump to.
    let path = (
        $choice |
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
