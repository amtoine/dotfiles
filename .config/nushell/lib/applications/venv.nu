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

use applications/prompt.nu


# TODO
def _list_venvs [] {
  ls $env.VIRTUALENVWRAPPER_HOOK_DIR |
    where type == dir |
    get name |
    str replace ([$env.VIRTUALENVWRAPPER_HOOK_DIR ""] | path join) ""
}


# TODO
export def list [] {
  _list_venvs
}


# TODO
export def new [
  name: string
] {
  let venv = ([$env.VIRTUALENVWRAPPER_HOOK_DIR $name] | path join | path expand)

  if (($venv | path dirname) != $env.VIRTUALENVWRAPPER_HOOK_DIR) {
    print -n $"venv new: (ansi red)error(ansi reset): "
    $"venv should be one directory inside ($env.VIRTUALENVWRAPPER_HOOK_DIR)"
  } else {
    if not ($venv | path exists) {
      virtualenv $venv
    } else {
      print -n $"venv new: (ansi red)error(ansi reset): "
      $"($venv) already exists"
    }
  }
}


# TODO
export def activate [] {
  let venv = (
    _list_venvs |
      prompt fzf_ask "Please choose a venv to activate: "
  )

  let bin = ($env.VIRTUALENVWRAPPER_HOOK_DIR | path join $venv "bin" "activate.nu")
  $bin | clip
  $"($venv) has been copied to the clipboard!"
  $"run `source <ctrl+shift+v>`"
}


# TODO
export def remove [] {
  let venv = (
    _list_venvs |
      prompt fzf_ask "Please choose a venv to remove: "
  )

  let path = ($env.VIRTUALENVWRAPPER_HOOK_DIR | path join $venv)

  rm --trash --interactive --recursive $path
}
