const SHARE = "~/.local/share/apps/" | path expand
const BIN = "~/.local/bin/" | path expand

def __log [color: string, label: string, msg: string] {
    print $"[(ansi $color)($label)(ansi reset)] ($msg)"
}

def "log debug" [msg: string] { __log default_dimmed DBG $msg }
def "log info" [msg: string] { __log green_bold INF $msg }
def "log warning" [msg: string] { __log yellow_bold WRN $msg }
def "log error" [msg: string] { __log red_bold ERR $msg }

# build and install applications locally
#
# # Examples
# ```nushell
# # install [Typst](https://github.com/typst/typst)
# install "typst" --commands { |dest: path|
#     cargo build --release
#     cp target/release/typst $dest
# }
# ```
# ```nushell
# # install [Neovim](https://github.com/neovim/neovim)
# install "nvim" --extra-sub-dirs [ "bin", "nvim" ] --commands { |dest: path|
#     make CMAKE_BUILD_TYPE=Release
#     make $"CMAKE_INSTALL_PREFIX=($dest)" install
# }
# ```
export def install [
    name: string,
    --commands (-c): closure, # commands to build and copy the result to the destination, a closure with a single positional argument `dest: path`
    --extra-sub-dirs (-e): list<string> = [],
] {
    if not ($SHARE | path exists) {
        log debug $"creating (ansi purple)($SHARE)(ansi reset)"
        mkdir $SHARE
    }

    let dest = $SHARE | path join $"($name)-(git rev-parse HEAD)"
    log info $"building to (ansi purple)($dest)(ansi reset)"
    do $commands $dest

    let ln_src = $dest | path join ...$extra_sub_dirs
    let ln_dest = $BIN | path join $name
    log info $"linking (ansi purple)($ln_src)(ansi reset) to (ansi purple)($ln_dest)(ansi reset)"
    ln --force -s $ln_src $ln_dest
}
