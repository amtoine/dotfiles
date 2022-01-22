
cat $1 | \
  sed 's/background/bg/; s/foreground/fg/; s/selection/sel/;  s/ \#/\&\#/' | column -t -s '&' | \
  sed 's/\([a-z_0-9]*\)/    "\1":/; s/\(#......\)/"\1",/;' | \
  sed 's/\(.*color0".*\)/\1  # grey/'   | \
  sed 's/\(.*color1".*\)/\1  # red/'    | \
  sed 's/\(.*color2".*\)/\1  # green/'  | \
  sed 's/\(.*color3".*\)/\1  # yellow/' | \
  sed 's/\(.*color4".*\)/\1  # blue/'   | \
  sed 's/\(.*color5".*\)/\1  # magenta/'| \
  sed 's/\(.*color6".*\)/\1  # cyan/'   | \
  sed 's/\(.*color7".*\)/\1  # white/'  | \
  xclip -selection c
