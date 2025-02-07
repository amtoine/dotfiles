# modify machine code using Neovim
#
# # Examples
# ```nushell
# # modify `a.out` which is compiled C
# chex a.out --executable --output b.out --dump-obj { |bin| objdump --disassemble=main -F $bin }
# ```
#
# ```nushell
# # modify `a.out`, which is compiled C, without overriding previous object dumps and xxd files
# chex a.out --executable --output b.out --dump-obj { |bin| objdump --disassemble=main -F $bin } --amend
# ```
export def chex [input: path, --output: path = "a.out", --executable, --amend, --dump-obj: closure] {
    let hash = open $input | hash sha256
    let objdump = { parent: $nu.temp-path, stem: $hash, extension: "objdump" } | path join
    let xxd = { parent: $nu.temp-path, stem: $hash, extension: "xxd" } | path join

    if not $amend or not ($objdump | path exists) {
        do $dump_obj $input | save --force $objdump
    }
    if not $amend or not ($xxd | path exists) {
        xxd $input | save --force $xxd
    }

    nvim -O $xxd $objdump

    xxd -r $xxd | save --force $output
    if $executable {
        chmod +x $output
    }
}

export alias cchex = chex --dump-obj { |bin| objdump --disassemble=main -F $bin }
