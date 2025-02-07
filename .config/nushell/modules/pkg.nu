const SHARE = "~/.local/share/apps/" | path expand
const BIN = "~/.local/bin/" | path expand

def __log [color: string, label: string, msg: string] {
    print $"[(ansi $color)($label)(ansi reset)] ($msg)"
}

def "log debug" [msg: string] { __log default_dimmed DBG $msg }
def "log info" [msg: string] { __log green_bold INF $msg }
def "log warning" [msg: string] { __log yellow_bold WRN $msg }
def "log error" [msg: string] { __log red_bold ERR $msg }

export def INSTALLERS [] { {
    typst: {
        installer: { |dest: path|
            cargo build --release
            cp target/release/typst $dest
        },
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

    let dest = $SHARE | path join $"($name)-(git rev-parse HEAD)"
    log info $"building to (ansi purple)($dest)(ansi reset)"
    do $commands $dest

    let ln_src = $dest | path join ...$extra_sub_dirs
    let ln_dest = $BIN | path join $name
    log info $"linking (ansi purple)($ln_src)(ansi reset) to (ansi purple)($ln_dest)(ansi reset)"
    ln --force -s $ln_src $ln_dest
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
