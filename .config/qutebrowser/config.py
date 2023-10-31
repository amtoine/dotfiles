import os
from pathlib import Path


def get_env(key, default=None):
    return os.environ[key] if key in os.environ else default


ALACRITTY = 0
ST = 1
RIO = 2

terminal = ST

CSS_COMMAND = "set content.user_stylesheets"
CSS_PATH = "~/ghq/github.com/alphapapa/solarized-everything-css/css"

DEFAULT_PAGE = "https://github.com/notifications?query=is%3Aunread"

FILEPICKER = "ranger"

config.load_autoconfig(True)

downloads_dir = get_env("XDG_DOWNLOAD_DIR", "~/downloads")
Path(downloads_dir).expanduser().mkdir(parents=True, exist_ok=True)
c.downloads.location.directory = downloads_dir

if terminal == ST:
    terminal = "st"
    flags = ["-c", "qutebrowser-filepicker", "-n", "qutebrowser-filepicker"]
elif terminal == RIO:
    terminal = "rio"
    flags = []
else:
    terminal = "alacritty"
    flags = ["--class", "qutebrowser-filepicker,qutebrowser-filepicker"]

filepicker_cmd = [terminal, *flags, "-e", FILEPICKER]

c.fileselect.folder.command = filepicker_cmd + ['--choosedir={}']
c.fileselect.handler = 'external'
c.fileselect.multiple_files.command = filepicker_cmd + ['--choosefiles={}']
c.fileselect.single_file.command = filepicker_cmd + ['--choosefile={}']

c.fonts.default_family = ["Mononoki"]

c.url.default_page = DEFAULT_PAGE
c.url.start_pages = [DEFAULT_PAGE]

config.bind(",so", "config-source")

theme_bindings = {
    ",ap": "apprentice",
    ",dr": "darculized",
    ",gr": "gruvbox",
    ",sd": "solarized-dark",
    ",sl": "solarized-light",
    ",,": "",
}
for binding, theme in theme_bindings.items():
    theme_path = f'{CSS_PATH}/{theme}/{theme}-all-sites.css' if theme else "\"\""
    config.bind(binding, f'{CSS_COMMAND} {theme_path}')

config.bind(',M', 'hint links spawn mpv --ytdl-format="bestvideo[height<=480]+bestaudio[ext=m4a]" {hint-url}')
config.bind(',P', 'hint links spawn mpv --ytdl-format="bestaudio[ext=m4a]" {hint-url} --no-video')
config.bind(',F', 'hint links spawn firefox {hint-url}')
config.bind(',Z', 'hint links spawn st -c qutebrowser-ytdl-download -e youtube-dl {hint-url}')

config.bind(',xb', 'config-cycle statusbar.show always never')
config.bind(',xt', 'config-cycle tabs.show always never')
config.bind(',xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')

config.bind(',<ESC>', 'fake-key <ESC>')
