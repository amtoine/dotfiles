# git
alias cfg = ^git --git-dir ($env.HOME | path join ".dotfiles") --work-tree $env.HOME
alias lg = ^lazygit

# exit the shell
alias ":q" = exit
alias "q" = exit

# be more verbose
alias cp = cp --verbose
alias rm = rm --verbose
alias mv = mv --verbose

# misc
alias cb = ^cbonsai --infinite --live --base=1 --wait=2 --time=10

# credit to @azzamsa
# https://discord.com/channels/601130461678272522/988303282931912704/1026019048254873651
def-env br_cmd [] {
  let cmd_file = (^mktemp | str trim);
  ^broot --outcmd $cmd_file;
  let-env cmd = ((open $cmd_file) | str trim);
  ^rm $cmd_file;
}
alias br = (br_cmd | cd ($env.cmd | str replace "cd" "" | str trim))
