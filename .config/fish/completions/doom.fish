# a header could go here
set -l commands help install sync env upgrade build purge ci doctor info version compile clean run

complete -c doom -f

complete -c doom -n "not __fish_seen_subcommand_from $commands" \
    -a "help install sync env upgrade build purge ci doctor info version compile clean run"

complete -c doom -n "not __fish_seen_subcommand_from $commands" -a help    -d "Describe a command or list them all."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a install -d "Installs and sets up Doom Emacs for the first time."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a sync    -d "Synchronize your config with Doom Emacs."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a env     -d "Creates or regenerates your envvars file."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a upgrade -d "Updates Doom and packages."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a build   -d "Byte-compiles & symlinks installed packages."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a purge   -d "Deletes orphaned packages & repos, and compacts them."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a ci      -d "TODO"
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a doctor  -d "Diagnoses common issues on your system."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a info    -d "Output system info in markdown for bug reports."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a version -d "Show version information for Doom & Emacs."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a compile -d "Byte-compiles your config or selected modules."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a clean   -d "Delete all *.elc files."
complete -c doom -n "not __fish_seen_subcommand_from $commands" -a run     -d "Run Doom Emacs from bin/doom's parent directory."

complete -c doom -s h -l help     -d "Same as help command"
complete -c doom -s y -l yes      -d "Auto-accept all confirmation prompts"
complete -c doom -s d -l debug    -d "Enables on verbose output"
complete -c doom -s l -l load     -d "FILE Load an elisp FILE before executing any commands"
complete -c doom      -l doomdir  -d "DIR Use the private module at DIR (e.g. ~/.doom.d)"
complete -c doom      -l localdir -d "DIR Use DIR as your local storage directory"
complete -c doom -s C -l nocolor  -d "Disable colored output"
