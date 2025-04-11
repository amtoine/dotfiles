const TRASH = "~/.local/share/Trash" | path expand
const INFO = $TRASH | path join "info" | path expand
const FILES = $TRASH | path join "files" | path expand

def ls-trashed-files [] {
    ls $INFO --short-names | get name | path parse | get stem
}

export def "trash restore" [file: string@ls-trashed-files, --dry-run] {
    let info = $INFO | path join $"($file).trashinfo"

    let old = open $info | parse "Path={path}" | into record | get path
    let trashed = ($FILES | path join $file)

    if $dry_run {
        print $"info:    ($info)"
        print $"trashed: ($trashed)"
        print $"old:     ($old)"
    } else {
        mkdir -v ($old | path dirname)
        cp -rv $trashed $old
        rm --permanent -v $info
        rm --permanent -rfv $trashed
    }
}

export def "trash empty" [] {
    rm -rfv --permanent $TRASH
}

export def "trash size" []: [ nothing -> filesize ] {
    if not ($TRASH | path exists) {
        0B
    } else {
        du $TRASH | into record | get physical
    }
}

export def "trash check" []: [ nothing -> bool ] {
    let info = if ($INFO | path exists) {
        ls $INFO --short-names | get name | path parse | get stem
    } else {
        []
    }
    let trashed = if ($FILES | path exists) {
        ls $FILES --short-names  | get name
    } else {
        []
    }

    ($info | sort) == ($trashed | sort)
}

export def "trash ls" []: [
    nothing -> table<name: string, date: datetime, original: path, trashed: path>
] {
    ls $INFO
        | get name
        | wrap path
        | insert name { $in.path | path parse | get stem }
        | insert info {
            let info = open $in.path | lines
            {
                path: ($info | parse "Path={path}" | into record | get path),
                date: ($info | parse "DeletionDate={date}" | into record | get date | into datetime),
            }
        }
        | flatten info
        | rename --column { info_path: original, path: trashed }
        | select name date original trashed
}
