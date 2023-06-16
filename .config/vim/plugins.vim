call plug#begin()
    Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all' }
    " Plug 'wellle/context.vim'
    " Plug 'dense-analysis/ale'
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
let g:fzf_action = {'ctrl-q': function('s:build_quickfix_list'), 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit'}

let g:airline_theme='one'
