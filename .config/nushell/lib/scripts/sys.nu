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
export def vuln [] {
  ls /sys/devices/system/cpu/vulnerabilities
  | each {|it|
    {
      name: ($it.name | path basename),
      migitation: (open $it.name | str trim)
    }
  }
}
