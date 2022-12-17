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
    if ((do -i {^ls $venv} | complete | get exit_code) != 0) {
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

  rm --interactive --recursive $path
}
