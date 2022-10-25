def user_choose_to_exit_context [] {
    {msg: "User choose to exit...", label: {text: "User choose to exit..."}}
}


export def clip [] {
    # put the end of a pipe into the clipboard.
    #
    # the function is cross-platform and will work on windows.
    #
    # dependencies:
    #   - xclip on linux
    #   - clip.exe on windows
    #
    # author: Reilly on
    #   https://discord.com/channels/601130461678272522/615253963645911060/1000921565686415410
    #
    let input = $in;

    if not (which clip.exe | empty?) {
        $input | clip.exe
    } else {
        $input | xclip -sel clip
    }
}


export def-env repo [] {
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
        error make (user_choose_to_exit_context)
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


export def-env vcfg [] {
    # jump to any config file with vim
    #
    # the function will:
    #   - (1) do nothing and abort when selecting no config file.
    #   - (2) jump to the selected file and start it in a vim buffer
    #
    # dependencies:
    #   - vim
    #   - fzf
    #
    let choice = (
        ^git --git-dir ($env.HOME | path join ".dotfiles") --work-tree $env.HOME lf --full-name ~ |
        fzf |
        str trim
    )

    if ($choice | empty?) {
        error make (user_choose_to_exit_context)
    }

    let path = ($env.HOME | path join $choice)
    let directory = (dirname $path | str trim)
    let filename = (basename $path | str trim)

    cd $directory
    ^$env.EDITOR $filename
    cd -
}


export def yt-dl-names [
    --id (-i): string  # the id of the playlist
    --channel (-c): string  # the id of the channel
    --path (-p): string = .  # the path where to store to final `.csv` file
    --all (-a)  # download all the playlists from the channel when raised
] {
    let format = '"%(playlist)s",%(playlist_id)s,%(playlist_index)s,"%(uploader)s","%(title)s",%(id)s'

    let url = if $all {
        $"https://www.youtube.com/channel/($channel)/playlists"
      } else {
        $"https://www.youtube.com/playlist?list=($id)"
    }

    if (ls | find $path | empty?) {
        mkdir $path
    }
    let file = ($path | path join $"($id).csv")

    print $"Downloading from '($url)' to ($file)..."

    (youtube-dl
        -o $format
        $url
        --get-filename
        --skip-download
        --verbose
    ) |
    from csv --noheaders |
    rename playlist "playlist id" "playlist index" uploader title id |
    insert url {
        |it|
        $'https://www.youtube.com/watch?v=($it.id)&list=($it."playlist id")'
    } |
    save $file
}


export def "nu-complete help categories" [] {
    help commands | get category | uniq
}


# credit to @maximum
# https://discord.com/channels/601130461678272522/615253963645911060/1015477201359093851
export def hc [category?: string@"nu-complete help categories"] {
    help commands |
        select name category usage |
        move usage --after name |
        where category =~ $category
}


# credit to @/dev/adrien#4649
# https://discord.com/channels/601130461678272522/615253963645911060/1019056732841967647
export def-env up [nb: int = 1] {
    let path = (1..$nb | each {|_| ".."} | reduce {|it, acc| $acc + "/" + $it})
    cd $path
}


# credit to @/dev/adrien#4649
# https://discord.com/channels/601130461678272522/615253963645911060/1019056732841967647
export def-env mkcd [name: path] {
    cd (mkdir $name -s | first)
}


# credit to @/dev/adrien#4649
# https://discord.com/channels/601130461678272522/615253963645911060/1020549933792768060
export def set-screen [side: string = "right"] {
    if $side == "right" {
        xrandr --output HDMI-2 --auto --right-of eDP-1
    } else if $side == "left" {
        xrandr --output HDMI-2 --auto --left-of eDP-1
    } else {
        print "Side argument should be either \"right\" or \"left\"."
    }
}


# Asks for an entry name in a password store and opens the store.
#
# Uses $env.PASSWORD_STORE_DIR as the store location, asks for
# a passphrase with pinentry-gtk and copies the credentials to
# the system clipboard..
export def pass-menu [
    --path (-p): string = "/usr/share/rofi/themes/"  # the path to the themes (default to '/usr/share/rofi/themes/')
    --theme (-t): string = "sidebar"  # the theme to apply (defaults to 'sidebar')
    --list-themes (-l)  # list all available themes in --path
] {
    if ($list_themes) {
        ls $path |
            select name |
            rename theme |
            str replace $"^($path)" "" theme |
            str replace ".rasi$" "" theme
    } else {
        let entry = (
            ls $"($env.PASSWORD_STORE_DIR)/**/*" |
            where type == file |
            select name |
            str replace $"^($env.PASSWORD_STORE_DIR)/" "" name |
            str replace ".gpg$" "" name |
            to csv |
            rofi -config $"($path)($theme).rasi" -show -dmenu |
            str trim
        )

        if not ($entry | empty?) {
            pass show $entry -c
            dunstify $entry "Copied to clipboard for 45 seconds."
        } else {
            print "User choose to exit..."
        }
    }
}


# credit to @jon
# https://discord.com/channels/601130461678272522/615253963645911060/1022699054452461568
export def show_banner [] {
    let ellie = [
        "     __  ,"
        " .--()°'.'"
        "'|, . ,'  "
        ' !_-(_\   '
    ]
    let s = (sys)
    print $"(ansi reset)(ansi green)($ellie.0)"
    print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
    print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)($s.mem.used) / ($s.mem.total)(ansi reset)"
    print $"(ansi green)($ellie.3)  (ansi light_purple)ﮫ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)($s.host.uptime)(ansi reset)"
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
#        git --git-dir ($env.HOME | path join ".dotfiles") --work-tree $env.HOME
#
#  . worktrees can be added with, for instance:
#        cfg worktree add some/path/to/worktree my_branch
#
#  . and then `cfgw` will let you pick one of the worktrees
export def-env cfgw [
    --bare (-b): string = ".dotfiles"  # the path to the *bare* repository (defaults to ".dotfiles")
    --debug (-d)
] {
    let choice = (
        git --git-dir ($env.HOME | path join $bare) --work-tree $env.HOME worktree list |
        str replace --all $"($env.HOME)" "~" |
        fzf --prompt "Please choose a worktree to jump to: " |
        str trim
    )

    if ($choice | empty?) {
        error make (user_choose_to_exit_context)
    }

    # compute the directory to jump to.
    let path = (
        $choice |
        lines |
        split column "  " |
        get column1 |
        str replace --all "~" $"($env.HOME)" |
        to text
    )
    cd $path

    if ($debug) {
        $"path: '($path)'"
    }

}


# credit to @azzamsa
# https://discord.com/channels/601130461678272522/988303282931912704/1026019048254873651
#
# slightly improved:
#   - does not use an extra br_cmd and alias
#   - allows the use of extra arguments, e.g. `br "-s"`
export def-env br [args = "."] {
    let cmd_file = (^mktemp | str trim);
    ^broot --outcmd $cmd_file $args;
    let cmd = ((open $cmd_file) | str trim);
    ^rm $cmd_file;
    cd ($cmd | str replace "cd" "" | str trim)
}


export def alarm [
    time: string
    message: string
] {
    termdown -e $time --title $message
    dunstify "termdown" $message --urgency critical --timeout 0
    print $message
}


export def cfgf [
    regex: string
    --files-only (-f): bool
    --edit (-e): bool
] {
    print $"Looking for config files matching '($regex)'..."
    let matches = (
        ^git --git-dir ($env.HOME | path join ".dotfiles") --work-tree $env.HOME lf --full-name ~ |
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


export def "vm get" [] {
    print "Pulling the list of available images..."
    let choice = (
        quickget list |
        from csv |
        get OS |
        sort |
        uniq |
        sort --insensitive |
        to text |
        fzf --prompt "Please choose an OS: "|
        str trim
    )

    if ($choice | empty?) {
        error make (user_choose_to_exit_context)
    }

    let os = $choice
    let vm_directory = ($env.QUICKEMU_HOME | path join $os)

    if (
        (do -i {^ls $vm_directory} |
        complete |
        get exit_code) != 0
    ) {
        mkdir $vm_directory
    }

    let choice = (
        do -i {
            quickget $os
        } |
        complete |
        get stdout |
        lines |
        find "- Releases" |
        str trim |
        str replace " *- Releases: " "" |
        split column " " |
        transpose |
        get column1 |
        sort --insensitive |
        uniq |
        to text |
        fzf --prompt $"Please choose a release for ($os):" |
        str trim
    )

    if ($choice | empty?) {
        error make (user_choose_to_exit_context)
    }

    let release = $choice

    print $"Pulling ($os)-($release) to ($vm_directory)..."
    cd $vm_directory
    quickget $os $release
    cd -
}


export def "vm list" [] {
    ls $"($env.QUICKEMU_HOME)/*/*" |
        where type == dir |
        get name |
        each {
            |it|
            basename $it | str trim
        } |
        str replace "-" "%%%" |
        split column "%%%" |
        rename "os" "release"
}


export def "vm remove" [] {
    let choice = (
        vm list |
        each {
            |it|
            $"($it.os)-($it.release)"
        } |
        sort --insensitive |
        uniq |
        to text |
        fzf --prompt "Please choose a vm to remove: " |
        str trim
    )

    if ($choice | empty?) {
        error make (user_choose_to_exit_context)
    }

    let vm = $choice
    let os = ($vm | split column "-" | get column1 | to text)
    let path = ($env.QUICKEMU_HOME | path join $os $vm)

    rm -rvfi $path
    rm -rvfi $"($path).conf"
}


export def "vm run" [] {
    let choice = (
        vm list |
        each {
            |it|
            $"($it.os)-($it.release)"
        } |
        sort --insensitive |
        uniq |
        to text |
        fzf --prompt "Please choose a vm to run: " |
        str trim
    )

    if ($choice | empty?) {
        error make (user_choose_to_exit_context)
    }

    let vm = $choice
    let os = ($vm | split column "-" | get column1 | to text)
    let path = ($env.QUICKEMU_HOME | path join $os)

    print $"Running ($vm)..."
    cd $path
    quickemu --vm $"($vm).conf"
    cd -
}


export def match [input:string matchers:record default?: block] {
    if (($matchers | get -i $input) != null) {
         $matchers | get $input | do $in
    } else if ($default != null) {
        do $default
    }
}
