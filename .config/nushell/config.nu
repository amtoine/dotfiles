#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

# base up-to-date with Nushell version 0.67.0

use core/completions.nu *
use core/themes.nu
use core/hooks.nu *
use core/menus.nu *
use core/keybindings.nu *

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  filesize_metric: false
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: true
  rm_always_trash: false
  color_config: (themes base16) # if you want a light theme, replace `(themes dark)` to `(themes light)`
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  quick_completions: true  # set this to false to prevent auto-selecting completions when only one remains
  partial_completions: true  # set this to false to prevent partial filling of the prompt
  completion_algorithm: "prefix"  # prefix, fuzzy
  float_precision: 2
  #buffer_editor: "helix" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  edit_mode: vi # emacs, vi
  max_history_size: 10000 # Session has to be reloaded for this to take effect
  sync_history_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
  history_file_format: "plaintext" # "sqlite" or "plaintext"
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  cd_with_abbreviations: false # set to true to allow you to do things like cd s/o/f and nushell expand it to cd some/other/folder
  case_sensitive_completions: false # set to true to enable case-sensitive completions
  enable_external_completion: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
  max_external_completion_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
  # A strategy of managing table view in case of limited space.
  table_trim: {
    methodology: wrapping, # truncating
    # A strategy which will be used by 'wrapping' methodology
    wrapping_try_keep_words: true,
    # A suffix which will be used with 'truncating' methodology
    # truncating_suffix: "..."
  }
  show_banner: false # true or false to enable or disable the banner
  hooks: (hooks)
  menus: (menus)
  keybindings: (keybindings)
}


source personal/aliases.nu

use scripts/misc.nu *
use scripts/community.nu *
use applications/dotfiles.nu
use applications/vm.nu
use applications/venv.nu
use applications/job.nu
use applications/repo.nu
use applications/gf.nu
use applications/hx.nu
use applications/gh.nu
use scripts/gpg.nu

source personal/final.nu
