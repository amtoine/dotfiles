use scripts/context.nu


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


# TODO
export def alarm [
    time: string
    message: string
] {
    termdown -e $time --title $message
    dunstify "termdown" $message --urgency critical --timeout 0
    print $message
}


# TODO
export def match [
    input:string
    matchers:record
    default?: block
] {
    if (($matchers | get -i $input) != null) {
         $matchers | get $input | do $in
    } else if ($default != null) {
        do $default
    }
}
