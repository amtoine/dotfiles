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

# Example Nushell Loginshell Config File
# - has to be as login.nu in the default config directory
# - will be sourced after config.nu and env.nu in case of nushell started as login shell

# just as an example for overwriting of an environment variable of env.nu
let-env PROMPT_INDICATOR = { "(LS)〉" }

# Similar to env-path and config-path there is a variable containing the path to login.nu
echo $nu.loginshell-path