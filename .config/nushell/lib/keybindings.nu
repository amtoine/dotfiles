export alias keybindings = [
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
    name: commands_menu
    modifier: control
    keycode: char_t
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: commands_menu }
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
    name: open_repo
    modifier: control
    keycode: char_g
    mode: [emacs, vi_insert, vi_normal]
    event: [
      {
        edit: insertString
        value: "repo"
      }
      { send: Enter }
    ]
  }
  {
    name: edit_config
    modifier: control
    keycode: char_v
    mode: [emacs, vi_insert, vi_normal]
    event: [
      {
        edit: insertString
        value: "vcfg"
      }
      { send: Enter }
    ]
  }
]
