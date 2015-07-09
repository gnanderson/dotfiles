set nocompatible
filetype off
"
" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'gnanderson/EasyColour'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'spf13/piv'
Plugin 'evidens/vim-twig'
"Plugin 'ervandew/supertab'

call vundle#end()

filetype plugin indent on

set relativenumber
set showcmd
set showmode
set cursorline
set nobackup
set noswapfile

set cmdheight=1
set ts=4
set sw=4
set t_Co=256

set autoread
set encoding=utf-8 
set undolevels=500

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
" set smarttab

" Backspace on windows
set backspace=indent,eol,start

" Search options
"set incsearch ignorecase smartcase hlsearch

"set textwidth=80        " always limit the width of text to 80
set colorcolumn=80
"set wildmenu
"set wildmode=longest:full,full

" Load colour scheme after EasyColor
syntax enable
set background=dark
colorscheme graham
highlight ColorColumn ctermbg=235 

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" braces
inoremap {<CR>  {<CR>}<Esc>O

" show a dollar at the end of change field
set cpoptions+=$

" vim-go
let g:go_fmt_command = "goimports"

" Autocomplete
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
highlight   Pmenu         ctermfg=green ctermbg=235
highlight   PmenuSel      ctermfg=white ctermbg=darkgray
highlight   PmenuSbar     ctermfg=white ctermbg=darkgray

" disable annoying backup/swap files
" open splits in the *correct* place
set splitbelow
set splitright

" Show the colour group of the element under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

autocmd Filetype php setlocal ts=4 sw=4 expandtab
autocmd FileType c,cpp,java,php,go,javascript,yaml,js,css autocmd BufWritePre <buffer> :%s/\s\+$//e
