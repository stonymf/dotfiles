set nofixendofline      " Prevent adding newline to end of file

syntax enable			" enable syntax processing
colorscheme default
set background=dark
highlight clear SignColumn  " make gutter transparent

set tabstop=4			" number of spaces rendered per tab
set softtabstop=4		" number of spaces per tab when editing
set shiftwidth=4
set expandtab			" turn tabs into spaces
set autoindent          " automatically indent new line to match above

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

let g:ale_python_flake8_options = '--max-line-length=100'    " line length = 100

let g:sneak#label = 1   " easymotion-like sneak functionality

nnoremap <C-n> :NERDTree<CR>  " open NERDTree
