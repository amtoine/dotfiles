def main [--graphical_server (-g): string] {
    const GRAPHICAL_SERVERS = ["x11", "wayland"]

    if $graphical_server == null {
        error make --unspanned {msg: "`rio install` requires a *graphical server*"}
    }

    if not ($graphical_server in $GRAPHICAL_SERVERS) {
        let span = metadata $graphical_server | get span
        error make {
            msg: $"(ansi red_bold)invalid_graphical_server(ansi reset)"
            label: {
                text: $"according to <https://raphamorim.io/rio/install/#build-from-the-source>, the possible graphical servers are ($GRAPHICAL_SERVERS | str join ', ') when building from source"
                start: $span.start
                end: $span.end
            }
        }
    }

    cargo build --release --no-default-features --features $graphical_server
    cp target/release/rio ($env.CARGO_HOME | default ($nu.home-path | path join ".cargo") | path join "bin" "rio")
}
