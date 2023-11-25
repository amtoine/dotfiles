# install a Nerd font
#
# this command will
# 1. download the font archive
# 2. extract all the files to the font directory
# 3. refresh the font cache of the system
#
# # Examples
#     install the [FiraCode](https://www.programmingfonts.org/#firacode) font
#     > font install FiraCode
#
#     install the [Mononoki](https://www.programmingfonts.org/#mononoki) in `$env.XDG_STATE_HOME`
#     > font install --font-dir ($env.XDG_STATE_HOME | path join "fonts") Mononoki
#
#     if you have a bunch of fonts, one name per line, in a file called `fonts.txt`
#     > open fonts.txt | lines | each { |font| font install $font}
def "font install" [
    font: string,  # the font to install, see the [list of fonts](https://www.nerdfonts.com/font-downloads)
    --version: string = "3.0.2",  # the version of the font
    --font-dir: path = ($nu.home-path | path join ".fonts")  # where to download the font
]: nothing -> nothing {
    const NERD_FONTS_DOWNLOAD_BASE = "https://github.com/ryanoasis/nerd-fonts/releases/download"

    let local_font_archive = $nu.temp-path | path join $"($font).zip"

    print $"(ansi cyan)DOWNLOADING '($font)' VERSION ($version) TO `($local_font_archive)`(ansi reset)"
    http get $"($NERD_FONTS_DOWNLOAD_BASE)/v($version)/($font).zip"
        | save --force $local_font_archive

    print $"(ansi cyan)EXTRACTING FONT FILES to `($font_dir)`(ansi reset)"
    ^unzip $local_font_archive -d $font_dir

    print $"(ansi cyan)UPDATING FONT CACHE(ansi reset)"
    ^sudo fc-cache -f -v $font_dir
}
