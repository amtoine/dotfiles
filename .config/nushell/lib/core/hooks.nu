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

export def main [] { help hooks }

# define the hooks for GOATs
export def set [] {
  {
    pre_prompt: [{||}]
    pre_execution: [{||}]
    env_change: {
      PWD: [
        { code: "hide toolkit" }
        {
          condition: {|_, after| $after | path join 'toolkit' 'mod.nu' | path exists }
          code: "
            print -n $'(ansi default_underline)(ansi default_bold)toolkit(ansi reset) module (ansi yellow_italic)detected(ansi reset)... '
            use toolkit/
            print $'(ansi green_bold)activated!(ansi reset)'
          "
        }
        {
          condition: {|_, after| $after | path join 'toolkit.nu' | path exists }
          code: "
            print -n $'(ansi default_underline)(ansi default_bold)toolkit(ansi reset) module (ansi yellow_italic)detected(ansi reset)... '
            use toolkit.nu
            print $'(ansi green_bold)activated!(ansi reset)'
          "
        }
      ]
    }
    display_output: {||
      if (term size).columns >= 100 { table -e } else { table }
    }
  }
}
