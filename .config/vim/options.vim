set number
set relativenumber
syntax on
set nowrap
set hlsearch
set tabstop=4 shiftwidth=4 expandtab
set list
set incsearch
set wildmenu
set clipboard=unnamedplus

colorscheme slate

highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/
