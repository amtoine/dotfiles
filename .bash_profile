#           __               __                           _____ __
#          / /_  ____ ______/ /_        ____  _________  / __(_) /__
#         / __ \/ __ `/ ___/ __ \      / __ \/ ___/ __ \/ /_/ / / _ \
#      _ / /_/ / /_/ (__  ) / / /     / /_/ / /  / /_/ / __/ / /  __/
#     (_)_.___/\__,_/____/_/ /_/_____/ .___/_/   \____/_/ /_/_/\___/
#                             /_____/_/
# full config can be found at: https://github.com/a2n-s/dotfiles


echo ".bash_profile"
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(fgconsole 2> /dev/null) == 1 ]] && exec startx -- vt1
