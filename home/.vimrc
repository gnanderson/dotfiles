set nocompatible

" line numbers
set relativenumber

" cursor line
set cursorline

set cmdheight=2
set ts=4
set sw=4
set t_Co=256

set laststatus=2 " always show the statusline
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%#todo#
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%{fugitive#statusline()}     " Git branch
set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Smart tabbing / autoindenting
set undolevels=100
set autoindent
set smarttab

" Search options
"set incsearch ignorecase smartcase hlsearch

"set textwidth=80        " always limit the width of text to 80
set colorcolumn=80
set wildmenu
set wildmode=longest:full,full

" Golang
filetype plugin indent on     " required!
syntax on

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'gnanderson/EasyColour'
Bundle 'dgryski/vim-godef'
Bundle 'ervandew/supertab'
Bundle 'gnanderson/vim-golang'

" Load colour scheme after EasyColor
set background=dark
colorscheme graham
highlight ColorColumn ctermbg=235 "set this after any colour plugins if you use them (e.g. EasyColour)
" Show all vim servers
" Show all available VIM servers
nmap <silent> ,ss :echo serverlist()<CR>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

set cpoptions+=$

" Autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
highlight   Pmenu         ctermfg=green ctermbg=235
highlight   PmenuSel      ctermfg=white ctermbg=darkgray
highlight   PmenuSbar     ctermfg=white ctermbg=darkgray

" disable annoying backup/swap files
set nobackup
set noswapfile

" open splits in the *correct* place
set splitbelow
set splitright
