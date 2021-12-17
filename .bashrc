#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#          _               _
#         | |             | |
#         | |__   __ _ ___| |__  _ __ ___
#         | '_ \ / _` / __| '_ \| '__/ __|
#      _  | |_) | (_| \__ \ | | | | | (__
#     (_) |_.__/ \__,_|___/_| |_|_|  \___|
#
# Description:  ~/.bashrc: executed by bash(1) for non-login shells.
#               see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
#               for examples
# Dependencies: cal, xtcl.sh, _shortwd.sh & _parse_git_info.sh at https://github.com/a2n-s/dotfiles/tree/main/scripts 
#               colorscript at https://gitlab.com/dwt1/shell-color-scripts, starship
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine
#
#               Table of Content:
#                 head of .bashrc.
#                 Alias definitions.
#                 completion.
#                 path.
#                 misc.
#                 neofetch based on date.
#                 prompt.


# >>> head of .bashrc.
# uncomment to  specify running bash files on startup.
#echo ".bashrc"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# <<<

# >>> Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
# <<<

# >>> completion.
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	echo "share completion";
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	echo "completion";
    . /etc/bash_completion
  fi
fi
# <<<

# >>> path.
export PATH=$PATH:$HOME/scripts:$HOME/.local/bin
# <<<


# >>> misc.
# disables the caps lock key.
xtcl.sh -d -q

# changes the editor in the terminal, to edit long commands.
export EDITOR='vim'
export VISUAL='vim'
set -o vi

# activates virtualenvwrapper to manage python virtual environments.
export WORKON_HOME=$HOME/.venvs
if [[ ! -d $WORKON_HOME ]]; then mkdir -p $WORKON_HOME; fi
source $HOME/.local/bin/virtualenvwrapper.sh
# <<<

# >>> neofetch based on date.
#if [[ -f ~/.config/neofetch/.neofetchrc ]]; then
#	. ~/.config/neofetch/.neofetchrc;
#else
#	neofetch;
#fi
# <<<

# figlet -tf slant "welcome in BASH"
# colorscript -e elfman
# cal -3
fortune -c | cowthink -f $(find /usr/share/cows -type f | shuf -n 1)

# >>> prompt.
# export PS1="\033[01;32m\u@\h\[\033[00m:\[\033[01;34m\$($HOME/scripts/_shortwd.sh 3)\[\033[33m\$($HOME/scripts/_parse_git_info.sh)\[\033[00m\n$ "
# PS1="\$?:[\u@\h \W]\$ "
rightprompt()
{
    printf "%*s" $COLUMNS "right prompt"
}

# PS1='\[$(tput sc; rightprompt; tput rc)\]left prompt > '
eval "$(starship init bash)"
# <<<
