# adapted from https://hiphish.github.io/blog/2020/05/31/macho-man-command-on-steroids
# --preview=\"chafa $WALLPAPERS/{1}\""
# --preview=\"feh $wallpapers/{1}\""

# while getopts ":s:" opt; do
#     case $opt in
#         s ) SECTION=$OPTARG; shift; shift;;
#         \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
#         : ) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
#     esac
# done

[[ ! -v WALLPAPERS ]] && WALLPAPERS="$HOME/repos/wallpapers/wallpapers"

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--preview-window=\"down,75%\"
--preview=\"catimg $WALLPAPERS/{1} -H 100 -r 2\""

num_monitors=$(xrandr --query | grep -e "connected" | grep -v "disconnected" -c)

wallpaper1=$(
  ls "$WALLPAPERS" | \
  fzf --prompt="First monitor: "
)
[ -z "$wallpaper1" ] && exit 0
wallpaper1="$WALLPAPERS/$wallpaper1"

if [ "$num_monitors" -eq "2" ]; then
  wallpaper2=$(
    ls "$WALLPAPERS" | \
    fzf --prompt="Second monitor: "
  )
  if [[ -z "$wallpaper2" ]]; then
    wallpaper2="$wallpaper1"
  else
    wallpaper2="$WALLPAPERS/$wallpaper2"
  fi;
  feh --bg-fill "$wallpaper1" "$wallpaper2"
else
  feh --bg-fill "$wallpaper1"
fi;
