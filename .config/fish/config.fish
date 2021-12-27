#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __   _____      __          __                    _____                _____      __
#             _________  ____  / __(_)___ _     _/_/  / __(_)____/ /_       _/_/  _________  ____  / __(_)___ _         / __(_)____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / /_/ / ___/ __ \    _/_/   / ___/ __ \/ __ \/ /_/ / __ `/        / /_/ / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    / __/ (__  ) / / /  _/_/    / /__/ /_/ / / / / __/ / /_/ /   _    / __/ (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /_/ /_/____/_/ /_/  /_/      \___/\____/_/ /_/_/ /_/\__, /   (_)  /_/ /_/____/_/ /_/
#                                 /____/                                                              /____/
#
# Description:  TODO
# Dependencies: this is up to you.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

if status is-interactive
    fish_add_path -mP $HOME/.local/bin
    fish_add_path -mP $HOME/scripts


    source $HOME/.aliases

    # disables the caps lock key.
    xtcl.sh -d -q

# # activates virtualenvwrapper to manage python virtual environments.
# export WORKON_HOME=$HOME/.venvs
# if [[ ! -d $WORKON_HOME ]]; then mkdir -p $WORKON_HOME; fi
# source $HOME/.local/bin/virtualenvwrapper.sh
# # <<<


    set EDITOR vim
    set VISUAL vim


#   clear
#   figlet -tf slant "welcome in FISH"
#   colorscript -e elfman
#   cal -3


    starship init fish --print-full-init | source

    function on_exit --on-event fish_exit
        ponysay "Bye bye!!"
    end
end
