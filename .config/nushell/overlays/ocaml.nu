export alias opam = nix run nixpkgs#opam --

export-env {
    opam env
        | lines
        | parse "{name}='{value}'; export {rest}"
        | reject rest
        | transpose --header-row
        | into record
        | load-env
}
