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
      $it.options | split row "," | split column "=" | rename option value
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
