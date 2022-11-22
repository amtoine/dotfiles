# git
alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
alias lg = ^lazygit

# exit the shell
alias :q = exit
alias q = exit

# be more verbose
alias cp = cp --verbose
alias rm = rm --verbose
alias mv = mv --verbose

# misc
alias cb = ^cbonsai --infinite --live --base=1 --wait=2 --time=10

alias sl = sl -aw -20

alias disk = (
  df -h |
  str replace "Mounted on" "Mountpoint" |
  detect columns |
  rename filesystem size used avail used% mountpoint |
  into filesize size used avail |
  upsert used% {|it| 100 * (1 - $it.avail / $it.size)}
)
alias devices = (
  lsblk -lp |
  str replace --all ":" " " |
  detect columns |
  rename name major minor RM size RO type mountpoints |
  into filesize size
)

alias vuln = (
  ls /sys/devices/system/cpu/vulnerabilities
  | each {|it|
    {
      name: ($it.name | path basename),
      migitation: (open $it.name | str trim)
    }
  }
)