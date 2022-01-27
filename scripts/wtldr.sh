# adapted from https://hiphish.github.io/blog/2020/05/31/macho-man-command-on-steroids
export FZF_DEFAULT_OPTS='
--height=100%
--layout=reverse
--prompt="TL;DR: "
--preview="echo {1} | xargs -I{S} tldr {S} 2>/dev/null"'

while getopts ":s:" opt; do
    case $opt in
        s ) SECTION=$OPTARG; shift; shift;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
        : ) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
    esac
done

help=$(
  tldr -l | \
  tr , '\n' | \
  sed "s/'//g; s/'//; s/\[//; s/\]//; s/ //g" | \
  sort | \
  fzf
)
[ -z "$help" ] && exit 0
tldr $help
