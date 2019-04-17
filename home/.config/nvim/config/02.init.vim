" colours & interface
syntax enable
set background=dark
colorscheme monokai

set number
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
set undolevels=1000

set laststatus=2 " always show the statusline
set statusline=   " clear the statusline for when vimrc is reloaded

" Smart tabbing / autoindenting
" set smarttab
set autoindent
set smartindent

" Backspace on windows
set backspace=indent,eol,start

" Search options
"set incsearch ignorecase smartcase hlsearch

" see what we're tabbing through
set wildmenu
set wildmode=list:longest,full

" 80 char column
set colorcolumn=80
highlight ColorColumn ctermbg=235

" show a dollar at the end of change field
set cpoptions+=$

" open splits in the *correct* place
set splitbelow
set splitright

" Autocomplete
highlight   Pmenu         ctermfg=green ctermbg=235
highlight   PmenuSel      ctermfg=white ctermbg=darkgray
highlight   PmenuSbar     ctermfg=white ctermbg=darkgray

" yeah - wtf
augroup lang_indents " {
	autocmd Filetype php setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd Filetype json setlocal ts=2 sts=2 sw=2 expandtab
	autocmd Filetype html setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype scss setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype htmldjango.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype text.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype html.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype macro.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype mustache setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype html.mustache setlocal ts=4 sts=4 sw=4 expandtab
augroup END " }

" cleanup - always
augroup clean " {
	autocmd BufWritePre * :%s/\s\+$//e
augroup END " }

" autocomplete
augroup autocomplete " {
	autocmd BufWritePost * Neomake
	autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
augroup END " }

" reload after editing config
augroup reload_vimrc " {
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

