DMFONT="mononoki Nerd Font"

pass_entry=$(
  find ~/.password-store/ -type f -not -path "*/.git*" | \
  sed "s|$HOME\/\.password-store||; s/\.gpg//" | \
  fzf
)
[ -z "$pass_entry" ] && exit 0

EDITOR="nvim" pass edit "$pass_entry"
