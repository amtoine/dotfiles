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
    event: {
      send: executehostcommand,
      cmd: $"source ($nu.env-path); source ($nu.config-path)"
    }
  }
  {
    name: open_repo
    modifier: control
    keycode: char_g
    mode: [emacs, vi_insert, vi_normal]
    event: {
      send: executehostcommand
      cmd: "repo goto"
    }
  }
  {
    name: edit_config
    modifier: control
    keycode: char_v
    mode: [emacs, vi_insert, vi_normal]
    event: {
      send: executehostcommand
      cmd: "dotfiles edit"
    }
  }
]
