const VENVS_DIR = "~/.local/share/venvs/" | path expand

def ls-venvs-with-version []: [ nothing -> table<value: string, description: string> ] {
    ls $VENVS_DIR --short-names | get name | each { |it|
        let pip = $VENVS_DIR
            | path join $it "bin" "pip"
            | ^$in --version
            | parse "{v} from {rest}"
            | into record
            | get v
        let python = $VENVS_DIR | path join $it "bin" "python" | ^$in --version
        {
            value: $in,
            description: $"($python) - ($pip)",
        }
    }
}

def ls-venvs []: [ nothing -> list<string>] {
    ls $VENVS_DIR --short-names | get name
}

export def activate [venv: string@ls-venvs] {
    let activation_script = $VENVS_DIR | path join $venv "bin" "activate.nu"
    ^$nu.current-exe -e $"overlay use ($activation_script)"
}
