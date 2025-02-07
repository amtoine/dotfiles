const SHARE = "~/.local/share/apps/" | path expand
const BIN = "~/.local/bin/" | path expand

def __log [color: string, label: string, msg: string] {
    print $"[(ansi $color)($label)(ansi reset)] ($msg)"
}

def "log debug" [msg: string] { __log default_dimmed DBG $msg }
def "log info" [msg: string] { __log green_bold INF $msg }
def "log warning" [msg: string] { __log yellow_bold WRN $msg }
def "log error" [msg: string] { __log red_bold ERR $msg }

def pkg-rm [...pkgs: path] {
    if ($pkgs | is-empty) { return }
    $pkgs | each { |pkg| $SHARE | path join $pkg } | rm --verbose --force --recursive ...$in
}

def app-rm [...apps: path] {
    if ($apps | is-empty) { return }
    $apps | each { |app| $BIN | path join $app } | rm --verbose --force --recursive ...$in
}

export def RUST-INSTALLER [name: string] {
    { |dest: path|
        cargo build --release
        cp ("target/release" | path join $name) $dest
    }
}

export def INSTALLERS [] { {
    typst: {
        installer: (RUST-INSTALLER "typst"),
        extra_sub_dirs: [],
    }
    nvim: {
        installer: { |dest: path|
            make CMAKE_BUILD_TYPE=Release
            make $"CMAKE_INSTALL_PREFIX=($dest)" install
        },
        extra_sub_dirs: [ "bin", "nvim" ],
    },
} }

# build and install applications locally
#
# # Examples
# ```nushell
# # install [Typst](https://github.com/typst/typst)
# install --app typst
# ```
# ```nushell
# # install [Neovim](https://github.com/neovim/neovim)
# install --app nvim
# ```
# ```nushell
# # install some C program with a custom installer
# install "my-c-program" --commands { |dest: path|
#     gcc -std=c99 -Wall -Werror -o a.out main.c
#     cp a.out $dest
# }
# ```
export def install [
    name: string,
    --app: string,
    --commands (-c): closure, # commands to build and copy the result to the destination, a closure with a single positional argument `dest: path`
    --extra-sub-dirs (-e): list<string> = [],
] {
    if not ($SHARE | path exists) {
        log debug $"creating (ansi purple)($SHARE)(ansi reset)"
        mkdir $SHARE
    }

    let installers = INSTALLERS

    if $app != null and $app not-in $installers {
        let builtin_apps = $installers | columns | str join ', '
        error make {
            msg: $"(ansi red_bold)pkg::invalid_builtin_application(ansi reset)",
            label: {
                text: $"(ansi yellow)($app)(ansi reset) is not a builtin application",
                span: (metadata $app).span,
            },
            help: $"list of builtin applications: (ansi purple)($builtin_apps)(ansi reset)"
        }
    }

    let commands = if $app != null { $installers | get $app | get installer } else { $commands }
    let extra_sub_dirs = if $app != null { $installers | get $app | get extra_sub_dirs } else { $extra_sub_dirs }

    if $commands == null {
        error make --unspanned {
            msg: $"(ansi red_bold)pkg::missing_argument(ansi reset): (ansi cyan)--commands(ansi reset) is required"
        }
    }

    let is_git_repo = not (git rev-parse --is-inside-work-tree err> /dev/null | is-empty)
    let dest = if $is_git_repo {
        $SHARE | path join $"($name)-(git rev-parse HEAD)"
    } else {
        log warning "not inside a Git repo, defaulting to random hash"
        let hash = random dice --dice 32 --sides 16
            | each { $in - 1}
            | each { if $in >= 10 { 97 - $in + 15 | char -i $in } else { $in } }
            | str join
        $SHARE | path join $"($name)-($hash)"
    }
    log info $"building to (ansi purple)($dest)(ansi reset)"
    do $commands $dest

    let ln_src = $dest | path join ...$extra_sub_dirs
    let ln_dest = $BIN | path join $name
    log info $"linking (ansi purple)($ln_src)(ansi reset) to (ansi purple)($ln_dest)(ansi reset)"
    ln --force -s $ln_src $ln_dest

    if not ($extra_sub_dirs | is-empty) {
        $extra_sub_dirs | to nuon | save --force ($dest | path join .pkg.extra)
    }
}

export def list []: nothing -> table<name: string, pkg: string> {
    let bins = ls $BIN
        | where type == symlink
        | select name
        | insert pkg { readlink $in.name }
        | where ($it.pkg | str starts-with $SHARE)
        | update pkg { str replace $SHARE "" | path split | get 1 }
        | update name { path basename }

    let pkgs = ls $SHARE | get name |  path basename | wrap pkg
    $bins | join $pkgs pkg --outer
}

def cmp-ls-apps []: nothing -> table<value: string, description: string> {
    list | where $it.name != null | each {{ value: $in.name, description: $in.pkg }}
}

def cmp-ls-pkgs []: nothing -> table<value: string, description: string> {
    let all = list
    $all | each { |x| {
        value: $x.pkg,
        description: ($all | where pkg == $x.pkg | get name | where $it != null | str join ", "),
    }}
}

export def activate [pkg: string@cmp-ls-pkgs, --name: string] {
    let name = $name | default ($pkg | parse "{pkg}-{rev}" | into record | get pkg)
    let ln_src = $SHARE | path join $pkg | if ($in | path type) == "dir" {
        let dir = $in
        $dir | path join ...($dir | path join ".pkg.extra" | open $in | from nuon)
    } else {
        $in
    }
    let ln_dest = $BIN | path join $name
    log info $"linking (ansi purple)($ln_src)(ansi reset) to (ansi purple)($ln_dest)(ansi reset)"
    ln --force -s $ln_src $ln_dest
}

export def deactivate [app: string@cmp-ls-apps] {
    let all = list
    if $app not-in $all.name {
        error make {
            msg: $"(ansi red_bold)pkg::application_not_found(ansi reset)",
            label: {
                text: $"(ansi yellow)($app)(ansi reset) not in (ansi purple)($BIN)(ansi reset)"
                span: (metadata $app).span,
            },
            help: $"list of active applications: (ansi purple)($all.name | where $it != null)(ansi reset)"
        }
    }
    app-rm $app
}

export def remove [pkg: string@cmp-ls-pkgs] {
    let all = list
    if $pkg not-in $all.pkg {
        error make {
            msg: $"(ansi red_bold)pkg::package_not_found(ansi reset)",
            label: {
                text: $"(ansi yellow)($pkg)(ansi reset) not in (ansi purple)($SHARE)(ansi reset)"
                span: (metadata $pkg).span,
            },
            help: $"list of installed packages: (ansi purple)($all.pkg)(ansi reset)"
        }
    }

    pkg-rm $pkg
    app-rm ...($all | where pkg == $pkg and name != null).name
}

export def purge [] {
    pkg-rm ...(list | where name == null).pkg
}

export def --wrapped run [pkg: string@cmp-ls-pkgs, ...args: string] {
    let all = list
    if $pkg not-in $all.pkg {
        error make {
            msg: $"(ansi red_bold)pkg::package_not_found(ansi reset)",
            label: {
                text: $"(ansi yellow)($pkg)(ansi reset) not in (ansi purple)($SHARE)(ansi reset)"
                span: (metadata $pkg).span,
            },
            help: $"list of installed packages: (ansi purple)($all.pkg)(ansi reset)"
        }
    }

    let exec = $SHARE | path join $pkg | if ($in | path type) == "dir" {
        let dir = $in
        $dir | path join ...($dir | path join ".pkg.extra" | open $in | from nuon)
    } else {
        $in
    }

    ^$exec ...$args
}
