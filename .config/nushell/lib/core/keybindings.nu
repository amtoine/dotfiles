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

export def main [] {
  [
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
        cmd: "repo goto --clear"
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
    {
      name: clear_and_ls
      modifier: control
      keycode: char_l
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "clear"
      }
    }
    # credit to @fdncred
    # https://discord.com/channels/601130461678272522/614593951969574961/1063493778566037566
    # augmented by @vinlet
    # https://discord.com/channels/601130461678272522/614593951969574961/1063822677808250991
    {
      name: fuzzy_history
      modifier: control
      keycode: char_h
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "commandline (history | each { |it| $it.command } | uniq | reverse | str join (char nl) | fzf --tiebreak=chunk --layout=reverse  --multi --preview='echo {..}' --preview-window='bottom:3:wrap' --height=70% -q (commandline) | decode utf-8 | str trim)"
      }
    }
    # credit to @fdncred
    # https://discord.com/channels/601130461678272522/614593951969574961/1063493778566037566
    {
      name: fuzzy_dir
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "commandline -a (ls **/* | where type == dir | get name | to text | fzf -q (commandline) | str trim)"
      }
    }
    # credit to @vinlet
    # https://discord.com/channels/601130461678272522/614593951969574961/1063822677808250991
    {
      name: insert_file
      modifier: control
      keycode: char_y
      mode: [emacs, vi_insert]
      event: {
        send: executehostcommand
        cmd: "commandline --insert (fzf --tiebreak=chunk --layout=reverse  --multi --preview='echo {..}' --preview-window='bottom:3:wrap' --height=70% | decode utf-8 | str trim)"
      }
    }
    # from #8076
    {
      name: "fzf_history_menu_fzf_ui_session"
      modifier: alt
      keycode: char_r
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: fzf_history_menu_fzf_ui_session }
    }
  ]
}
