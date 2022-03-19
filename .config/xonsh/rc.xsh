# XONSH WEBCONFIG START
$PROMPT = '{BOLD_GREEN}{cwd_base}{RESET} ) '
$XONSH_COLOR_STYLE = 'dracula'
xontrib load bashisms coreutils fzf-widgets z
# XONSH WEBCONFIG END

OMX = 0
# set where oh-my-xonsh lives
if not 'OMX_HOME' in ${...}:
    $OMX_HOME = p"~/.config/xonsh/oh-my-xonsh"

# clone omx if needed
if not pf"{$OMX_HOME}".exists():
    git clone --depth=1 https://github.com/oh-my-xonsh/oh-my-xonsh $OMX_HOME

if OMX:
  # source oh-my-xonsh to give you the `omx` object
  source $OMX_HOME/oh-my-xonsh.xsh

  # choose your plugins
  omx.plugins = [
      'autocmd',
      'brew',
      'clipboard',
      'common_aliases',
      'copydir',
      'dash',
      'git',
      'gitignore',
      'golang',
      'iwd',
      'macos',
      'manpage_coloring',
      'shrink_path',
      'up',
  ]

  # configure your plugins
  # omx.config["plugins.git.skip_aliases"] = True
  
  # initialize oh-my-xonsh
  omx.init()
