#          _               _
#         | |             | |
#         | |__   __ _ ___| |__  _ __ ___
#         | '_ \ / _` / __| '_ \| '__/ __|
#      _  | |_) | (_| \__ \ | | | | | (__
#     (_) |_.__/ \__,_|___/_| |_|_|  \___|
#
# full config can be found at: https://github.com/a2n-s/dotfiles


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# >>> head of .bashrc.
# uncomment to  specify running bash files on startup.
#echo ".bashrc"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# <<<

# >>> the '**' pattern.
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
# <<<

# >>> less command.
# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# <<<

# >>> chroot.
# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi
# <<<

# >>> fancy prompt.
# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac
# <<<

# >>> colored prompt.
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt

#force_color_prompt=yes
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt
# <<<

# >>> xterm terminals prompt.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac
# <<<

# >>> Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

# >>> prompt.
export PS1="\033[01;32m\u@\h\[\033[00m:\[\033[01;34m\$(_shortwd)\[\033[33m\$(_parse_git_info)\[\033[00m\n$ "
# <<<

# >>> misc.
# disables the caps lock key.
xtcl -d -q


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
if [[ -f ~/.config/neofetch/.neofetchrc ]]; then
	. ~/.config/neofetch/.neofetchrc;
else
	neofetch;
fi
# <<<


cal -3
