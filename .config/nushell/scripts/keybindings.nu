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
