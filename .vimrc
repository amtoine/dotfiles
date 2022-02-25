"             ___
"       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
"      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
"     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
"     \__,_/____/_/ /_/           /____/
"              _
"       _   __(_)___ ___  __________
"      | | / / / __ `__ \/ ___/ ___/
"     _| |/ / / / / / / / /  / /__
"    (_)___/_/_/ /_/ /_/_/   \___/
"
" Description:  greatly inspired from:
"                     https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
" Dependencies:
" License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
" Contributors: Stevan Antoine
"
"               Table of Content:
"                 BASIC OPTIONS
"                 STYLE
"                 MORE OPTIONS
"                 WILD MENU
"                 FILE MANAGEMENT
"                 MAPPINGS
"                 PLUGINS
"                    FastFold
"                    SimpylFold
"                    YouCompleteMe
"                    vim-flake8
"                    ctrlp
"                    powerline
"                    ultisnips
"                    vim-floaterm
"                    vim=startify
"                    fzf
"                    fzf.vim
"                    vim-cmake
"                    vim-signify
"                    vim-fugitive
"                    vim-rhubarb
"                    gv.vim
"                    rainbow_parentheses.vim
"                    onedark.vim
"                    vim-airline
"                    vim-airline-themes
"                    vim-commentary
"                    vim-which-key
"                 VIMSCRIPT
"                 python support
"                 full stack support
"                 STATUS LINE
"


" BASIC OPTIONS ---------------------------------------------------------------- {{{
" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" enable type file detection. Vim will be able to try to detect the type of file in use.
filetype off
" enable plugins and load plugin for the detected file type.
filetype plugin on
" load an indent file for the detected file type.
filetype indent on
" allows vim to process unicode characters.
set encoding=utf-8
" }}}


" STYLE ---------------------------------------------------------------- {{{
" chooses a colorscheme.
colorscheme default
"colorscheme desert
"colorscheme koehler
"colorscheme darkblue
"colorscheme elflord
" colorscheme molokai
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
" make the splits to the right and below current tab.
set splitbelow
set splitright
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
" set visualbell
" enables the raindow parentheses.
au VimEnter * RainbowParentheses
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

if !isdirectory(expand("$HOME/.vim/autoload")) | call mkdir(expand("$HOME/.vim/autoload", "p")) | endif
if !isdirectory(expand("$HOME/.vim/colors")) | call mkdir(expand("$HOME/.vim/colors", "p")) | endif
if !isdirectory(expand("$HOME/.vim/plugged")) | call mkdir(expand("$HOME/.vim/plugged", "p")) | endif
" }}}


" MAPPINGS --------------------------------------------------------------- {{{
map \p ebi(<Esc>ea)<Esc>
map \c ebi{<Esc>ea}<Esc>

" Set the backslash as the leader key.
let mapleader = "\\"
" applies the changes made to .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Turn off search highlighting by pressing \\.
nnoremap <leader>\ :nohlsearch<CR>
" Press `` to jump back to the last cursor position.
nnoremap <leader>' ``
" make all splits the same size, as best as vim can do.
noremap <leader>] <c-w>=
" clears trailling spaces.
noremap <leader>t :%s/\s\+$//<cr>
" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
"nnoremap <silent> <leader>p :%w !lp<CR>
" moves lines up and dowm in every mode.
nnoremap <S-j> :m .+1<CR>
nnoremap <S-k> :m .-2<CR>
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv
" Type jk to exit insert mode quickly.
inoremap jk <Esc>
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
"au VimEnter * NERDTree
"au VimEnter * wincmd p
" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
" search visually selected text.
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" }}}


" PLUGINS ---------------------------------------------------------------- {{{
" start the vim-plug plugging to install and manage the plugins.
call plug#begin('~/.vim/plugged')
  " all the plugins.
  Plug 'dense-analysis/ale'                                      " https://github.com/dense-analysis/ale 
  Plug 'preservim/nerdtree'                                      " https://github.com/preservim/nerdtree 
  Plug 'Konfekt/FastFold'                                        " https://github.com/Konfekt/FastFold 
  Plug 'tmhedberg/SimpylFold'                                    " https://github.com/tmhedberg/SimpylFold 
  Plug 'vim-scripts/indentpython.vim'                            " https://github.com/vim-scripts/indentpython.vim 
  Plug 'Valloric/YouCompleteMe'                                  " https://github.com/ycm-core/YouCompleteMe 
  Plug 'vim-syntastic/syntastic'                                 " https://github.com/vim-syntastic/syntastic 
  Plug 'nvie/vim-flake8'                                         " https://github.com/nvie/vim-flake8 
  Plug 'kien/ctrlp.vim'                                          " https://github.com/kien/ctrlp.vim 
  Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}  " https://github.com/powerline/powerline 
  " Plug 'Lokaltog/vim-powerline'                                  " https://github.com/Lokaltog/vim-powerline 
  " Plug 'SirVer/ultisnips'                                        " https://github.com/SirVer/ultisnips 
  " Plug 'honza/vim-snippets'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'voldikss/vim-floaterm'                                   " https://github.com/voldikss/vim-floaterm 
  Plug 'mhinz/vim-startify'                                      " https://github.com/mhinz/vim-startify 
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }            " https://github.com/junegunn/fzf 
  Plug 'junegunn/fzf.vim'                                        " https://github.com/junegunn/fzf.vim 
  Plug 'cdelledonne/vim-cmake'                                   " https://github.com/cdelledonne/vim-cmake 
  " Plug 'antoinemadec/FixCursorHold.nvim'
if has('nvim') || has('patch-8.0.902')                           " https://github.com/mhinz/vim-signify 
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
  Plug 'tpope/vim-fugitive'                                      " https://github.com/tpope/vim-fugitive 
  Plug 'tpope/vim-rhubarb'                                       " https://github.com/tpope/vim-rhubarb 
  Plug 'junegunn/gv.vim'                                         " https://github.com/junegunn/gv.vim 
  " Plug 'norcalli/nvim-colorizer.lua'
  Plug 'junegunn/rainbow_parentheses.vim'                        " https://github.com/junegunn/rainbow_parentheses.vim 
  Plug 'joshdick/onedark.vim'                                    " https://github.com/joshdick/onedark.vim 
  " Plug 'vim-airline/vim-airline'                                 " https://github.com/vim-airline/vim-airline 
  " Plug 'vim-airline/vim-airline-themes'                          " https://github.com/vim-airline/vim-airline-themes 
  Plug 'tpope/vim-commentary'                                    " https://github.com/tpope/vim-commentary 
  Plug 'liuchengxu/vim-which-key'                                " https://github.com/liuchengxu/vim-which-key 
  " Plug 'jeffkreeftmeijer/vim-numbertoggle'                       " https://github.com/jeffkreeftmeijer/vim-numbertoggle 
" A Vim Plugin for Lively Previewing LaTeX PDF Output
  " Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }         " https://github.com/xuhdev/vim-latex-live-preview 
"
"  " Sagemath
  " Plug 'petRUShka/vim-sage'
call plug#end()

" FastFold config -- https://github.com/Konfekt/FastFold ----------------- {{{
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook               = 1
let g:fastfold_fold_command_suffixes  =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']"
let g:markdown_folding                = 1
let g:tex_fold_enabled                = 1
let g:vimsyn_folding                  = 'af'
let g:xml_syntax_folding              = 1
let g:javaScript_fold                 = 1
let g:sh_fold_enabled                 = 7
let g:ruby_fold                       = 1
let g:perl_fold                       = 1
let g:perl_fold_blocks                = 1
let g:r_syntax_folding                = 1
let g:rust_fold                       = 1
let g:php_folding                     = 1
" }}}

" SimpylFold config -- https://github.com/tmhedberg/SimpylFold ----------------- {{{
let g:SimpylFold_docstring_preview = 0 "0
let g:SimpylFold_fold_docstring    = 1 "1
let b:SimpylFold_fold_docstring    = 1 "1
let g:SimpylFold_fold_import       = 1 "1
let b:SimpylFold_fold_import       = 1 "1
let g:SimpylFold_fold_blank        = 0 "0
let b:SimpylFold_fold_blank        = 0 "0
" }}}

" YouCompleteMe config -- https://github.com/ycm-core/YouCompleteMe ----------------- {{{
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

"" syntastic config -- https://github.com/vim-syntastic/syntastic ----------------- {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 0
let g:syntastic_check_on_wq              = 0
"" }}}

" vim-flake8 config -- https://github.com/nvie/vim-flake8 ----------------- {{{
" }}}

" ctrlp config -- https://github.com/kien/ctrlp.vim ----------------- {{{
" Change the default mapping and the default command to invoke CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" unless a starting directory is specified, CtrlP will set its local working directory according to this variable
let g:ctrlp_working_path_mode = 'ra'
" }}}

" powerline config -- https://github.com/powerline/powerline ----------------- {{{
" }}}

" ultisnips config -- https://github.com/SirVer/ultisnips ----------------- {{{
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>""
" }}}

" vim-floaterm config -- https://github.com/voldikss/vim-floaterm ----------------- {{{
let g:floaterm_wintype   = 'vsplit'
let g:floaterm_autoclose = 2
let g:floaterm_keymap_new    = '<F8>'
let g:floaterm_keymap_prev   = '<F9>'
let g:floaterm_keymap_next   = '<F10>'
let g:floaterm_keymap_toggle = '<F12>'
" }}}

" vim=startify config -- https://github.com/mhinz/vim-startify ----------------- {{{
" }}}

" fzf config -- https://github.com/junegunn/fzf ----------------- {{{
" }}}

" fzf.vim config -- https://github.com/junegunn/fzf.vim ----------------- {{{
" }}}

" vim-cmake config -- https://github.com/cdelledonne/vim-cmake ----------------- {{{
set updatetime=100
" }}}

" vim-signify config -- https://github.com/mhinz/vim-signify ----------------- {{{
" }}}

" vim-fugitive config -- https://github.com/tpope/vim-fugitive ----------------- {{{
" }}}

" vim-rhubarb config -- https://github.com/tpope/vim-rhubarb ----------------- {{{
" }}}

" gv.vim config -- https://github.com/junegunn/gv.vim ----------------- {{{
" }}}

" rainbow_parentheses.vim config -- https://github.com/junegunn/rainbow_parentheses.vim ----------------- {{{
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
" List of colors that you do not want. ANSI code or #RRGGBB
let g:rainbow#blacklist = [233, 234]
" }}}

" onedark.vim config -- https://github.com/joshdick/onedark.vim  --------------------------- {{{
" }}}

" vim-airline config -- https://github.com/vim-airline/vim-airline  --------------------------- {{{
" }}}

" vim-airline-themes config -- https://github.com/vim-airline/vim-airline-themes  --------------------------- {{{
let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 1
" }}}

" vim-commentary config -- https://github.com/tpope/vim-commentary  --------------------------- {{{
" }}}

" vim-which-key config -- https://github.com/liuchengxu/vim-which-key  --------------------------- {{{
" }}}

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{
" Enable the marker method of folding.
"augroup filetype_vim
"    autocmd!
"    autocmd FileType vim setlocal foldmethod=marker
"augroup END
"" If the current file type is HTML, set indentation to 2 spaces.
"autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
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

" python support. ---------------------------------------------- {{{
"au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
#  execfile(activate_this, dict(__file__=activate_this))
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF
let python_highlight_all=1
syntax on
" }}}
" full stack support. ---------------------------------------------- {{{
"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2
" }}}
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

set ttymouse=sgr
