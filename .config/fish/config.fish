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
    set -o vim


    clear
    figlet -tf slant "welcome in FISH"
    colorscript -e elfman
    cal -3


    starship init fish --print-full-init | source
end
