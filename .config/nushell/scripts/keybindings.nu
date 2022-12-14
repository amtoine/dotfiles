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

export alias keybindings = [
  {
    name: completion_menu
    modifier: none
    keycode: tab
    mode: emacs # Options: emacs vi_normal vi_insert
    event: {
      until: [
        { send: menu name: completion_menu }
        { send: menunext }
      ]
    }
  }
  {
    name: completion_previous
    modifier: shift
    keycode: backtab
    mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
    event: { send: menuprevious }
  }
  {
    name: history_menu
    modifier: control
    keycode: char_x
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        { send: menu name: history_menu }
        { send: menupagenext }
      ]
    }
  }
  {
    name: history_previous
    modifier: control
    keycode: char_z
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        { send: menupageprevious }
        { edit: undo }
      ]
    }
  }
  # Keybindings used to trigger the user defined menus
  {
    name: commands_menu
    modifier: control
    keycode: char_t
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: commands_menu }
  }
  {
    name: vars_menu
    modifier: control
    keycode: char_y
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: vars_menu }
  }
  {
    name: commands_with_description
    modifier: control
    keycode: char_u
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: commands_with_description }
  }
  {
    name: reload_config
    modifier: control
    keycode: char_r
    mode: [ emacs vi_insert vi_normal ]
    event: [
      { edit: clear }
      {
        edit: insertString
        value: $"source ($nu.env-path); source ($nu.config-path)"
      }
      { send: Enter }
    ]
  }
  {
    name: yank
    modifier: control
    keycode: char_y
    mode: emacs
    event: {
      until: [
        {edit: pastecutbufferafter}
      ]
    }
  }
  {
    name: unix-line-discard
    modifier: control
    keycode: char_u
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        {edit: cutfromlinestart}
      ]
    }
  }
  {
    name: kill-line
    modifier: control
    keycode: char_k
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        {edit: cuttolineend}
      ]
    }
  }
]
