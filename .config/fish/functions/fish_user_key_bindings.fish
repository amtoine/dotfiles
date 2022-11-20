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
