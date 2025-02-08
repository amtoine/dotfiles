PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"
    PS1=""

    local RESET='\[\e[0m\]'

    local RED='\[\e[0;31m\]'
    local GREEN='\[\e[0;32m\]'

    if [ $EXIT != 0 ]; then
        color="${RED}"
    else
        color="${GREEN}"
    fi

    PS1+="${RESET}${color}#${RESET} "
}
