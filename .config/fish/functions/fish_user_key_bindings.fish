function fish_user_key_bindings
  # peco
  bind -M insert \cr peco_select_history # Bind for peco select history to Ctrl+R
  bind -M default \cr peco_select_history
  bind -M visual \cr peco_select_history
  bind -M insert \cf peco_change_directory # Bind for peco select history to Ctrl+R
  bind -M default \cf peco_change_directory
  bind -M visual \cf peco_change_directory
end

fzf_key_bindings
