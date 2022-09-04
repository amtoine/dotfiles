def clip [] {
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


def-env repo [] {
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
    let choice = (ghq list | fzf | str trim)

    # compute the directory to jump to.
    let path = if ($choice | empty?) {
        $env.PWD
    } else {
        (
            ghq root
               | str trim
               | path join $choice
        )
    }
    cd $path

    # print a little message.
    if ($choice | empty?) {
        print "User choose to exit..."
    } else {
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
        ^git --no-pager log --graph --all --oneline --decorate --simplify-by-decoration -n 10
    }
}


def-env vcfg [] {
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
        cfg lf ~ |
        fzf |
        str trim
    )

    if ($choice | empty?) {
        print "User choose to exit..."
    } else {
        vim $choice
    }
}


def yt-dl-names [
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

    let file = ($path | path join $"($id).csv")

    print $"Downloading from '($url)' to ($file)..."

    (youtube-dl
        -o $format
        $url
        --get-filename
        --skip-download
    ) |
    from csv --noheaders |
    rename playlist "playlist id" "playlist index" uploader title id |
    insert url {
        |it|
        $'https://www.youtube.com/watch?v=($it.id)&list=($it."playlist id")'
    } |
    save $file
}


def "nu-complete help categories" [] {
    help commands | get category | uniq
}


# credit to @maximum
# https://discord.com/channels/601130461678272522/615253963645911060/1015477201359093851
def hc [category?: string@"nu-complete help categories"] {
    help commands |
        select name category usage |
        move usage --after name |
        where category =~ $category
}
