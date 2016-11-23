"
" Initialise & setup plugins
"

" sanity
set nocompatible
set clipboard=unnamed

" sanity
filetype off

" we may be using vim on older boxes still?
if has('nvim')
	" windowing system copy / pasta
	set cb=unnamed
	let s:editor_root=expand("~/.config/nvim")
else
	let s:editor_root=expand("~/.vim")
endif

" max osx shenanigens
if has("unix")
	let s:uname = system("uname")
	let g:python_host_prog='/usr/bin/python'
	if s:uname == "Darwin\n"
		let g:python_host_prog='/usr/local/bin/python'
	endif
endif

" try to get plug.vim if its not there
if empty(glob("~/.config/nvim/autoload/plug.vim"))
	execute '!curl -fLo --create-dirs ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" now install the plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-rooter'
Plug 'benekastah/neomake'
Plug 'craigemery/vim-autotag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab'
Plug 'evidens/vim-twig'
Plug 'fatih/vim-go'
Plug 'gnanderson/vim-monokai'
Plug 'godlygeek/tabular'
Plug 'mileszs/ack.vim'
Plug 'phpvim/phpcd.vim', { 'for': 'php' , 'do': 'composer update' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/progressbar-widget' " used for showing the index progress
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'plasticboy/vim-markdown'
call plug#end()

" sanity
filetype plugin indent on
let g:SuperTabDefaultCompletionType = "<c-n>"

" file searching behaviour improvements
let g:NERDTreeChDirMode       = 2
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_max_files = 50000
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_extensions = ['mixed', 'line', 'dir']
" use ack.vim with silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"
" Plugin configuration
"

if has('nvim')
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#ignore_sources = {}
	let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
	let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
	let g:deoplete#sources#go#align_class = 1
	" Use partial fuzzy matches like YouCompleteMe
	call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
	call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
	call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
endif


let neomake_verbose = 3
let g:neomake_go_enabled_makers = ['go', 'golint', 'govet']
"let g:neomake_open_list = 2
let g:neomake_php_enabled_makers = ['php', 'phpcs', 'phpmd']
let g:neomake_php_phpcs_args_standard = 'Symfony2'
let g:neomake_javascript_enabled_makers = ['jshint', 'jscs', 'eslint']

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', '.git/']
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1

" colours
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

" leader
let mapleader=","
nnoremap <leader>a :echo("\<leader\> works! It is set to <leader>")<CR>

" 80 char column
set colorcolumn=80
highlight ColorColumn ctermbg=235

" braces
inoremap {<CR>  {<CR>}<Esc>O

" show a dollar at the end of change field
set cpoptions+=$

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" vim-go
let g:go_fmt_command = "goimports"

" airline
let g:airline_theme= "murmur"
let g:airline_powerline_fonts = 1

" NERDTree
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeFocus<CR>
let g:NERDTreeWinSize = 50

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" resize
" if bufwinnr(1)
"   map = <C-W>>
"   map - <C-W><
" endif

" Print full path
map <C-f> :echo expand("%:p")<cr>

" Terminal settings
if has('nvim')
  " Leader q to exit terminal mode. Somehow it jumps to the end, so jump to
  " the top again
  tnoremap <Leader>q <C-\><C-n>gg<cr>

  " mappings to move out from terminal to other views
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " always start terminal in insert mode
  autocmd BufWinEnter,WinEnter term://* startinsert
endif

"PHP disable auto fold
"let g:DisableAutoPHPFolding = 1

" Syntastic
"let g:syntastic_php_checkers=['php', 'phpcs']
"let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
"let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_error_symbol = 'EE'

" Autocomplete
highlight   Pmenu         ctermfg=green ctermbg=235
highlight   PmenuSel      ctermfg=white ctermbg=darkgray
highlight   PmenuSbar     ctermfg=white ctermbg=darkgray


" disable annoying backup/swap files
" open splits in the *correct* place
set splitbelow
set splitright

" yeah - wtf
augroup lang_indents " {
	autocmd Filetype php setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype html setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype scss setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype htmldjango.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype text.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype html.twig setlocal ts=4 sts=4 sw=4 expandtab
	autocmd Filetype macro.twig setlocal ts=4 sts=4 sw=4 expandtab
augroup END " }

" automatically change to files dir
augroup behaviour " {
	"autocmd BufEnter * silent! lcd %:p:h
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


noremap <C-s> :Ack! -aQi <cword> <CR>


"PHP namespaces
"function! IPhpInsertUse()
"	call PhpInsertUse()
"	call feedkeys('a',  'n')
"endfunction
"autocmd FileType php inoremap <Leader>s <Esc>:call IPhpInsertUse()<CR>
"autocmd FileType php noremap <Leader>s :call PhpInsertUse()<CR>
