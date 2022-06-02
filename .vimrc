" Prevent adding newline to end of file
set nofixendofline

syntax enable			" enable syntax processing
set background=dark
colorscheme elflord

set tabstop=4			" number of spaces rendered per tab
set softtabstop=4		" number of spaces per tab when editing
set expandtab			" turn tabs into spaces
set autoindent          " automatically indent new line to match above

set number			" show line numbers
set showcmd			" show command in bottom bar
set cursorline			" high current line

set wildmenu			" visual autocomplete for command menu

set showmatch			" highlight matching [{()}]

set incsearch			" search as characters are entered
set hlsearch			" highlight search matches

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
Plug 'easymotion/vim-easymotion'
call plug#end()
