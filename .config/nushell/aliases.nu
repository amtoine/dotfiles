alias cfg = ^git --git-dir $env.DOTFILES_GIT_DIR --work-tree $env.DOTFILES_WORKTREE
alias "cfg edit" = dotfiles edit

alias vim = ^nvim
alias vi = ^nvim -u NONE
alias :G = ^git
alias :q = exit

alias ll = ls --all --long
def lsg [] {
    ls --all | each {|it|
        $it.name | if $it.type == dir { append "/" } else {} | str join
    }
    | grid --color --separator " | "
}

alias te = table --expand
alias ex = nu_plugin_explore ($env.explore_config? | default {})

alias news = ^nushell-news.nu --force
alias passmenu = ^passme.nu -l 10 -bw 5 -fn "mononoki Nerd Font-20" --notify
alias bye = ^logout.nu --lock "slock"
alias gghn = do { ^gh-notifications.nu --notify --max-notifications 5 | ignore }

# related to https://github.com/nushell/nushell/pull/10097
alias "core cp" = cp
alias cp = ucp

alias sl = ^sl -aw -20

alias try-nu = cargo run -- -e "$env.PROMPT_COMMAND_RIGHT = 'CARGO RUN'"
