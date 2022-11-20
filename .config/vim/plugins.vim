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

call plug#begin()
    Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all' }
    Plug 'wellle/context.vim'
    Plug 'dense-analysis/ale'
    Plug 'preservim/nerdtree'
    Plug 'rakr/vim-one'
    Plug 'chrisbra/Colorizer'
call plug#end()

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_layout = { 'down': '40%' }
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:airline_theme='one'
