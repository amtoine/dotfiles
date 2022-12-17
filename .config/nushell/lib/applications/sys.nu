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

# TODO: documentation
export def disk [] {
  df -h |
  str replace "Mounted on" "Mountpoint" |
  detect columns |
  rename filesystem size used avail used% mountpoint |
  into filesize size used avail |
  upsert used% {|it| 100 * (1 - $it.avail / $it.size)}
}


# TODO: documentation
export def devices [] {
  lsblk -lp |
  str replace --all ":" " " |
  detect columns |
  rename name major minor RM size RO type mountpoints |
  into filesize size
}


# TODO: documentation
# credit to terminally_online#9473
# https://discord.com/channels/601130461678272522/615253963645911060/1044604359213858816
export def vuln [] {
  ls /sys/devices/system/cpu/vulnerabilities
  | each {|it|
    {
      name: ($it.name | path basename),
      migitation: (open $it.name | str trim)
    }
  }
}


# TODO: documentation
# credit to terminally_online#9473
# https://discord.com/channels/601130461678272522/615253963645911060/1044604359213858816
export def ext4 [] {
  ls /sys/fs/ext4/features/  | each {|it|
    {
      name: ($it.name | path basename),
      supported: (open -r $it.name | str trim | $in == "supported" )
    }
  }
}


# TODO: documentation
# credit to terminally_online#9473
# https://discord.com/channels/601130461678272522/615253963645911060/1044604359213858816
export def uptime [] {
  open -r /proc/uptime
  | str trim
  | split row ' '
  | get 0
  | $in + "sec"
  | into duration 
}


# TODO: documentation
# credit to terminally_online#9473
# https://discord.com/channels/601130461678272522/615253963645911060/1044604359213858816
# updated in
# https://discord.com/channels/601130461678272522/615253963645911060/1045037215484498041
export def mounts [
  --parse (-p)
] {
  let mounts = (
    open -r /proc/mounts
    | from csv -s " " --noheaders
    | rename device mountpoint filesystem options
    | drop column 2
  )
  if ($parse) {
    $mounts
    | update options {|it|
      $it.options
      | split row ","
      | split column "="
      | if ($in | columns | any $it == column2) {
        transpose -i -r -d
      } else {
        get column1
      }
    }
  } else {
    $mounts
  }
}


# TODO: documentation
# credit to terminally_online#9473
# https://discord.com/channels/601130461678272522/615253963645911060/1044604359213858816
export def users [] {
  open -r /etc/passwd
  | from csv -s ':' --noheaders
  | rename username password userid groupid comment home shell
  | reject password 
}


# TODO: documentation
# credit to terminally_online#9473
# https://discord.com/channels/601130461678272522/615253963645911060/1044604359213858816
export def os [] {
  open -r /etc/os-release
  | from csv -s "=" --noheaders
  | rename key value
}
