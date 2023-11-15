export def "discord install" [
    --platform: string = "linux",
    --format: string = "tar.gz",
    --install-directory: path = "~/.local/share/",
    --bin-directory: path = "~/.local/bin/",
    --applications-directory: path = "~/.local/share/applications/",
]: nothing -> nothing {
    let install_directory = $install_directory | path expand
    let bin_directory = $bin_directory | path expand
    let applications_directory = $applications_directory | path expand

    let url = {
        scheme: https,
        host: discord.com,
        path: /api/download,
        params: {
            platform: $platform,
            format: $format,
        }
    } | url join
    let local = $nu.temp-path | path join "discord.tar.gz"

    print $"downloading ($url)..."
    http get $url | save --force --progress $local

    print $"extracting the archive to `($install_directory)`..."
    ^tar xf $local --directory $install_directory

    print $"creating symlink to binary in `($bin_directory)`..."
    mkdir $bin_directory
    ^ln [
        --symbolic --force
        ($install_directory | path join "Discord/Discord")
        ($bin_directory | path join "discord")
    ]

    print "installing desktop file..."
    open ($install_directory | path join "Discord/discord.desktop")
        | lines
        | str replace --regex '^Exec=.*' $"Exec=($install_directory | path join "Discord/Discord")"
        | to text
        | save --force ($applications_directory | path join "discord.desktop")
}
