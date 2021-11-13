"              _
"       _   __(_)___ ___  __________
"      | | / / / __ `__ \/ ___/ ___/
"     _| |/ / / / / / / / /  / /__
"    (_)___/_/_/ /_/ /_/_/   \___/
" full config can be found at: https://github.com/a2n-s/dotfiles
"
" greatly inspired from:
"      https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/

" BASIC OPTIONS ---------------------------------------------------------------- {{{
" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" enable plugins and load plugin for the detected file type.
filetype plugin on
" load an indent file for the detected file type.
filetype indent on
" }}}


" STYLE ---------------------------------------------------------------- {{{
" chooses a colorscheme.
"colorscheme default
"colorscheme desert
"colorscheme koehler
"colorscheme darkblue
"colorscheme elflord
colorscheme molokai
" turn syntax highlighting on.
syntax on
" makes line numbers visible.
set number
" makes line breaks visible.
set list
" highlight cursor line underneath the cursor horizontally.
set cursorline
" highlight cursor line underneath the cursor vertically.
set cursorcolumn
" }}}


" MORE OPTIONS ---------------------------------------------------------------- {{{
" Set shift width to 4 spaces.
set shiftwidth=4
" Set tab width to 2 columns.
set tabstop=2
" Use space characters instead of tabs.
set expandtab
" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap
" While searching though a file incrementally highlight matching characters as you type.
set incsearch
" Ignore capital letters during search.
set ignorecase
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase
" Show partial command you type in the last line of the screen.
set showcmd
" Show the mode you are on the last line.
set showmode
" Show matching words during a search.
set showmatch
" Use highlighting when doing a search.
set hlsearch
" Set the commands to save in history default number is 20.
set history=1000
" }}}


" WILD MENU ---------------------------------------------------------------- {{{
" Enable auto completion menu after pressing TAB.
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" }}}


" FILE MANAGEMENT ---------------------------------------------------------------- {{{
" changes the locations of the swaps, backup and undo tree files.
let &directory = expand('~/.vim/swap//')
set backup
let &backupdir = expand('~/.vim/backup//')
set undofile
let &undodir = expand('~/.vim/undo//')

" create the directories if they do not exist.
if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif
" }}}


" PLUGINS ---------------------------------------------------------------- {{{
" start the vim-plug plugging to install and manage the plugins.
call plug#begin('~/.vim/plugged')
  " all the plugins.
  Plug 'dense-analysis/ale'    " https://github.com/dense-analysis/ale
  Plug 'preservim/nerdtree'    " https://github.com/preservim/nerdtree
call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{
map \p ebi(<Esc>ea)<Esc>
map \c ebi{<Esc>ea}<Esc>

" Set the backslash as the leader key.
let mapleader = "\\"
" applies the changes made to .vimrc
:nnoremap <leader>sv :source $MYVIMRC<cr>
" Turn off search highlighting by pressing \\.
nnoremap <leader>\ :nohlsearch<CR>
" Press \\ to jump back to the last cursor position.
nnoremap <leader>' ``
" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
"nnoremap <silent> <leader>p :%w !lp<CR>
" Type jj to exit insert mode quickly.
inoremap jj <Esc>
" Press the space bar to type the : character in command mode.
nnoremap <space> :
" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>
" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz
" Yank from cursor to the end of line.
nnoremap Y y$
" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
"nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>
" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><
" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>
" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{
" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END
" If GUI version of Vim is running set these options.
if has('gui_running')
    " Set the background tone.
    set background=dark
    " Set the color scheme.
    colorscheme molokai
    " Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
    set guifont=Monospace\ Regular\ 12
    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T
    " Hide the the left-side scroll bar.
    set guioptions-=L
    " Hide the the right-side scroll bar.
    set guioptions-=r
    " Hide the the menu bar.
    set guioptions-=m
    " Hide the the bottom scroll bar.
    set guioptions-=b
    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>
endif

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=
" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" Show the status on the last line.
set laststatus=2"
" }}}
 

"let g:xml_syntax_folding = 1
"set foldmethod=syntax

