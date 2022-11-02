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
alias bash = sl

alias disk = (
  df -h |
  sd "\\s+ " " " |
  lines |
  split column " " Filesystem Size Used Avail Use% "Mounted on" |
  skip 1
)
alias devices = (
  lsblk -lp |
  sd "\\s+ " " " |
  lines |
  split column " " NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS |
  skip 1
)