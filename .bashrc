#           __               __
#          / /_  ____ ______/ /_  __________
#         / __ \/ __ `/ ___/ __ \/ ___/ ___/
#      _ / /_/ / /_/ (__  ) / / / /  / /__
#     (_)_.___/\__,_/____/_/ /_/_/   \___/
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
export PATH=$PATH:/home/ants/scripts
# <<<

# >>> prompt.
# gives a short directory in prompt, not to fill the entire line when inside nested directories.
shortwd() {
    max_num_dirs=7
    newPWD="${PWD/#$HOME/~}"
    num_dirs=$(echo -n $newPWD | awk -F '/' '{print NF}')
    if [ $num_dirs -gt $max_num_dirs ]; then
        newPWD="~$(echo -n $newPWD | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')"
    else
        newPWD=$(echo $newPWD | sed -e "s|$HOME|~|g")
    fi
    echo -n $newPWD
}

# gives information about the current git repository.
parse_git_info() {
	git branch 1> /dev/null 2> /dev/null
	if [ $? -eq 0 ]; then 
		branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
		tbc=$(git status 2> /dev/null | awk '/^Changes to be committed/,/^$/' | grep -e $'^\t' | wc -l)
		nsfc=$(git status 2> /dev/null | awk '/^Changes not staged for commit/,/^$/' | grep -e $'^\t' | wc -l)
		uf=$(git status 2> /dev/null | awk '/^Untracked files/,/^$/' | grep -e $'^\t' | wc -l)
		sl=$(git stash list 2> /dev/null | wc -l)
		repo=$(git remote -v 2> /dev/null | grep -e "origin.*fetch"  | rev | cut -d'/' -f1 | rev | sed "s/ (fetch)//g; s/ (push)//g; s/\.git$//")
		echo -e "\e[39m(\e[36m$repo\e[96m@\e[36m$branch\e[39m:\e[92m$tbc\e[39m,\e[93m$nsfc\e[39m,\e[91m$uf\e[39m,\e[95m$sl\e[39m)"
	fi
}

# final prompt in the terminal.
export PS1="\033[01;32m\u@\h\[\033[00m:\[\033[01;34m\$(shortwd)\[\033[33m\$(parse_git_info)\[\033[00m\n$ "
# <<<

# >>> misc.
# disables the caps lock key.
xtcl -d -q

# some tool funtions.
function countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
   echo -n "COUNTDOWN OVER!!"
   while [ true ]; do
	   echo -ne "\a";
	   sleep 0.1
	   echo -ne "\a";
	   sleep 0.1
	   echo -ne "\a";
	   sleep 0.5
	 done
}
function stopwatch(){
  date1=`date +%s`;
   while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
}

# changes the editor in the terminal, to edit long commands.
export EDITOR='vim'
export VISUAL='vim'
set -o vi
# <<<

# >>> neofetch based on date.
# an example of neofetchrc file.
#DATE=$(date +"%m%d" | sed "s/^0\+//")
#if [ $DATE -ge 1024 -a $DATE -le 1107 ]; then
#	neofetch --ascii ~/.config/neofetch/ascii/halloween.art --ascii_colors 1 9
#elif [ $DATE -ge 215 -o $DATE -le 105 ]; then
#	neofetch --ascii ~/.config/neofetch/ascii/christmas.art --ascii_colors 7 7
#else
#	neofetch;
#fi

if [[ -f ~/.config/neofetch/neofetchrc ]]; then
	. ~/.config/neofetch/neofetchrc;
else
	neofetch;
fi
# <<<


cal -3
