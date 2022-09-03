function! ToggleLineNumber()
  if v:version > 703
    set relativenumber!
  else
    set nonumber!
  endif
endfunction

function! ToggleThemeMode(style)
    if a:style == "dark"
        set background=dark
        AirlineTheme tomorrow
        colorscheme Tomorrow-Night
    else
        set background=light
        colorscheme Tomorrow
        AirlineTheme tomorrow
    en
endfunction
