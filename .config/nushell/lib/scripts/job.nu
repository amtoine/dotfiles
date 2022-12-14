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

# credit to @WindSoilder
# https://discord.com/channels/601130461678272522/615253963645911060/1022883266962927758
#
# spawn task to run in the background
#
# please note that the it spawned a fresh nushell to execute the given command
# So it doesn't inherit current scope's variables, custom commands, alias definition, except env variables which value can convert to string.
#
# e.g:
# spawn { echo 3 }
export def spawn [
    command: block   # the command to spawn
] {
    let config_path = $nu.config-path
    let env_path = $nu.env-path
    let source_code = (view-source $command | str trim -l -c '{' | str trim -r -c '}')
    let job_id = (pueue add -p $"nu --config \"($config_path)\" --env-config \"($env_path)\" -c '($source_code)'")
    {"job_id": $job_id}
}

# TODO
export def log [
    id: int   # id to fetch log
] {
    pueue log $id -f --json
    | from json
    | transpose -i info
    | flatten --all
    | flatten --all
    | flatten status
}

# get job running status
export def status [] {
    pueue status --json
    | from json
    | get tasks
    | transpose -i status
    | flatten
    | flatten status
}

# kill specific job
export def kill [id: int] {
    pueue kill $id
}

# clean job log
export def clean [] {
    pueue clean
}
