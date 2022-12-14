"*
"*                  _    __ _ _
"*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
"*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
"*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
"*  |___/
"*          MAINTAINERS:
"*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
"*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
"*

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
set smartcase

set showcmd
set showmode
set showmatch

set shell=/usr/bin/nu

set noswapfile

set showbreak=+++

set splitbelow
set splitright
