set nocompatible
filetype off

if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif
if has("unix")
    let s:uname = system("uname")
    let g:python_host_prog='/usr/bin/python'
    if s:uname == "Darwin\n"
        let g:python_host_prog='/usr/local/bin/python'
    endif
endif

" Vundle
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/Vundle.vim/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    " silent execute "! mkdir -p ~/." . s:editor_path_name . "/bundle"
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/VundleVim/Vundle.vim.git " . s:editor_root . "/bundle/Vundle.vim"
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim/'
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'gnanderson/vim-monokai'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'spf13/piv'
Plugin 'evidens/vim-twig'
Plugin 'bling/vim-airline'
if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
call vundle#end()

filetype plugin indent on

" colours
syntax enable
set background=dark
colorscheme monokai

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
set undolevels=1000

set laststatus=2 " always show the statusline
set statusline=   " clear the statusline for when vimrc is reloaded

" Smart tabbing / autoindenting
" set smarttab

" Backspace on windows
set backspace=indent,eol,start

" Search options
"set incsearch ignorecase smartcase hlsearch

"set wildmenu
"set wildmode=longest:full,full

" 80 char column
set colorcolumn=80
highlight ColorColumn ctermbg=235

" braces
inoremap {<CR>  {<CR>}<Esc>O

" show a dollar at the end of change field
set cpoptions+=$

" vim-go
let g:go_fmt_command = "goimports"

" airline
let g:airline_theme= "murmur"

"PHP disable auto fold
let g:DisableAutoPHPFolding = 1

" Autocomplete
highlight   Pmenu         ctermfg=green ctermbg=235
highlight   PmenuSel      ctermfg=white ctermbg=darkgray
highlight   PmenuSbar     ctermfg=white ctermbg=darkgray

" disable annoying backup/swap files
" open splits in the *correct* place
set splitbelow
set splitright

autocmd Filetype php setlocal ts=4 sw=4 expandtab
autocmd Filetype html setlocal ts=4 sw=4 expandtab
autocmd Filetype twig setlocal ts=4 sw=4 expandtab
autocmd BufWritePre * :%s/\s\+$//e
"autocmd FileType c,cpp,java,php,go,javascript,yaml,js,css,vim,vimrc autocmd BufWritePre <buffer> :%s/\s\+$//e
