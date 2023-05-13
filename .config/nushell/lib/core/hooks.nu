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

export-env {
  def "env-change pwd toolkit" [
    --directory: bool
  ] {{
    condition: (if $directory {
      {|_, after| $after | path join 'toolkit' 'mod.nu' | path exists }
    } else {
      {|_, after| $after | path join 'toolkit.nu' | path exists }
    })
    code: ([
      "print -n $'(ansi default_underline)(ansi default_bold)toolkit(ansi reset) module (ansi yellow_italic)detected(ansi reset)... '"
      $"use (if $directory { 'toolkit/' } else { 'toolkit.nu' })"
      "print $'(ansi green_bold)activated!(ansi reset)'"
    ] | str join "\n")
  }}

  let-env config = ($env.config? | default {} | merge {hooks: {
    pre_prompt: [{||}]
    pre_execution: [{||}]
    env_change: {
      PWD: [
        { code: "hide toolkit" }
        (env-change pwd toolkit)
        (env-change pwd toolkit --directory)
      ]
    }
    display_output: {||
      if (term size).columns >= 100 { table -e } else { table }
    }
  }})
}
