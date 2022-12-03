use scripts/prompt.nu


# TODO
def list_remote_os [] {
    quickget list |
    from csv |
    get OS |
    sort |
    uniq |
    sort --ignore-case
}


# TODO
def list_release_for_os [os: string] {
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
    sort --ignore-case |
    uniq
}


# TODO
export def pull [] {
    print "Pulling the list of available images..."
    let choice = (
        list_remote_os |
        prompt fzf_ask "Please choose an OS: "
    )

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
        list_release_for_os $os |
        prompt fzf_ask $"Please choose a release for ($os):"
    )

    let release = $choice

    print $"Pulling ($os)-($release) to ($vm_directory)..."
    cd $vm_directory
    quickget $os $release
    cd -
}


# TODO
def base_list [] {
    ls $"($env.QUICKEMU_HOME)/*/*" |
    where type == dir |
    get name |
    each {
        |it|
        $it | path basename
    } |
    sort --ignore-case |
    uniq
}


# TODO
export def list [] {
    base_list | parse "{os}-{release}"
}


# TODO
export def remove [] {
    let choice = (
        base_list |
        prompt fzf_ask "Please choose a vm to remove: "
    )

    let vm = $choice
    let os = ($vm | split column "-" | get column1 | to text)
    let path = ($env.QUICKEMU_HOME | path join $os $vm)

    rm -rvfi $path
    rm -rvfi $"($path).conf"
}


# TODO
export def run [] {
    let choice = (
        base_list |
            prompt fzf_ask "Please choose a vm to run: "
    )

    let vm = $choice
    let os = ($vm | split column "-" | get column1 | to text)
    let path = ($env.QUICKEMU_HOME | path join $os)

    print $"Running ($vm)..."
    cd $path
    quickemu --vm $"($vm).conf"
    cd -
}
