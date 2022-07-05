set nofixendofline      " Prevent adding newline to end of file

syntax enable			" enable syntax processing
colorscheme default
set background=dark
highlight clear SignColumn  " make gutter transparent

set expandtab			" turn tabs into spaces
" set smarttab
set shiftwidth=4
set tabstop=4			" number of spaces rendered per tab
set softtabstop=4		" number of spaces per tab when editing
set autoindent          " automatically indent new line to match above
set smartindent
set wrap

" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
autocmd FileType html set textwidth=0
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Python (tab width 4 chr, wrap at 79th char)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set textwidth=79
autocmd FileType python set omnifunc=pythoncomplete#Complete

" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
autocmd FileType css set textwidth=79
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" JavaScript (tab width 4 chr, wrap at 79th)
autocmd FileType javascript set sw=4
autocmd FileType javascript set ts=4
autocmd FileType javascript set sts=4
autocmd FileType javascript set textwidth=79
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

set backspace=indent,eol,start  " backspace always works

set updatetime=750      " general update speed

set number			" show line numbers
set showcmd			" show command in bottom bar
set cursorline			" high current line

set wildmenu			" visual autocomplete for command menu

set showmatch			" highlight matching [{()}]

set incsearch			" search as characters are entered
set hlsearch			" highlight search matches

set splitbelow          " new h split pane below
set splitright          " new v split pane right

let mapleader=" "       " change leader key to spacebar

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" remap jk to replace Escape
inoremap jk <Esc>

" auto indent and close after brace / paren / bracket
inoremap {<cr> {<cr>}<c-o>O<tab>
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O<tab>

" turn off search highlight with /<space>
nnoremap <leader><space> :noh<CR>

" shortcuts to edit vimrc and reload vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" fzf remap
nnoremap <C-t> :Files<CR>

" enable file backup
set backup
if !isdirectory($HOME."/.vim/backups")
    silent! execute "!mkdir ~/.vim/backups"
endif
set backupdir=~/.vim/backups

"auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
" Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" plugin options
let g:airline#extensions#tabline#enabled = 1

let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
let g:ale_python_flake8_options = '--max-line-length=100'    " line length = 100

let g:sneak#label = 1   " easymotion-like sneak functionality

nnoremap <C-n> :NERDTree<CR>  " open NERDTree
