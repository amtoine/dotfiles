set number
set relativenumber
syntax on

set nowrap
set tabstop=4 shiftwidth=4 expandtab
set list

set wildmenu
set wildmode=list:longest

set clipboard=unnamedplus

colorscheme slate

highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

set cursorline
set cursorcolumn
set scrolloff=10

set hlsearch
set incsearch
set ignorecase
set smartcase

set showcmd
set showmode
set showmatch

set shell=/usr/bin/nu
