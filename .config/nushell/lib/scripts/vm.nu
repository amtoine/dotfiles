def user_choose_to_exit_context [] {
    {msg: "User choose to exit...", label: {text: "User choose to exit..."}}
}


# TODO
export def pull [] {
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


# TODO
export def list [] {
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


# TODO
export def remove [] {
    let choice = (
        list |
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


# TODO
export def run [] {
    let choice = (
        list |
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
