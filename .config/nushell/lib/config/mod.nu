def get-lib-dir [] {
    $env.NU_LIB_DIR? | default (
        $env.XDG_DATA_HOME?
        | default ($env.HOME | path join ".local" "share")
        | path join "nushell" "lib"
    )
}

def get-config-file [] {
    get-lib-dir | path join "default_config.nu"
}

export def "update default" [
    --init: bool
    --latest: bool
    --revision: string
] {
    let revision = if $latest {
        "main"
    } else if ($revision != null) {
        $revision
    } else {
        let v = (version)
        $v.commit_hash? | default $v.branch? | default $v.version
    }

    let default_url = (
        {
            scheme: https,
            host: raw.githubusercontent.com,
            path: $"/nushell/nushell/($revision)/crates/nu-utils/src/sample_config",
        } | url join
        | path join "default_config.nu"
    )

    if (get-config-file | path expand | path exists) {
        if not $init {
            print $"(ansi cyan)info(ansi reset): updating default config from (ansi yellow)($revision)(ansi reset)..."
            http get $default_url | save --force --raw .default_config.nu

            let diff = (diff -u --color=always (get-config-file) .default_config.nu)

            if not ($diff | is-empty) {
                print $diff
            }

            mv --force .default_config.nu (get-config-file)
        }
    } else {
        print $"(ansi red_bold)error(ansi reset): (get-config-file) does not exist..."
        print $"(ansi cyan)info(ansi reset): pulling default config file..."
        http get $default_url | save --force --raw (get-config-file)
        print $'Downloaded new default config file'
    }
}

export def "update libs" [
    --init: bool
] {
    for profile in ($env.NU_SCRIPTS | transpose name profile | get profile) {
        let directory = (get-lib-dir | append $profile.directory | path join)
        if not ($directory | path exists) {
            print $"(ansi red_bold)error(ansi reset): ($directory) does not exist..."
            print $"(ansi cyan)info(ansi reset): pulling the scripts from ($profile.upstream)..."
            git clone $profile.upstream $directory
        } else {
            if not $init {
                print $"(ansi cyan)info(ansi reset): updating ($directory)..."
                git -C $directory fetch origin --prune
            }
        }

        git -C $directory checkout (["origin" $profile.revision] | path join) --quiet
    }
}

export def "update all" [
    --init: bool
] {
    mkdir (get-lib-dir)
    if $init {
        update default --init
        update libs --init
    } else {
        update default
        update libs
    }
}

export def "edit default" [] {
    ^$env.EDITOR (get-config-file)
}

def "nu-complete list-nu-libs" [] {
    ls (get-lib-dir | path join "**" "*" ".git")
    | get name
    | path parse
    | get parent
    | str replace (get-lib-dir) ""
    | str trim -c (char path_sep)
}

export def "edit lib" [lib: string@"nu-complete list-nu-libs"] {
    cd (get-lib-dir | path join $lib)
    ^$env.EDITOR .
}

export def "status" [] {
    nu-complete list-nu-libs | each {|lib|
        {
            name: $lib
            describe: (try {
                let tag = (git -C (get-lib-dir | path join $lib) describe HEAD)
                $tag
            } catch { "" })
            rev: (git -C (get-lib-dir | path join $lib) rev-parse HEAD)
        }
    }
}
