" try to get plug.vim if its not there
if empty(glob("~/.config/nvim/autoload/plug.vim"))
	execute '!curl -fLo --create-dirs ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')
" editor feature plugins
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-rooter'
Plug 'benekastah/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'gnanderson/vim-monokai'
Plug 'godlygeek/tabular'
Plug 'mileszs/ack.vim'
"Plug 'phpvim/phpcd.vim', { 'for': 'php' , 'do': 'composer update' }
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/progressbar-widget' " used for showing the index progress
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'christoomey/vim-tmux-navigator'
Plug 'xolox/vim-session'
Plug 'tommcdo/vim-exchange'
" language server / autocomplete plugins
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'kristijanhusak/deoplete-phpactor'
" Go related plugins
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}
" PHP related plugins
Plug 'evidens/vim-twig'
Plug 'phpstan/vim-phpstan'
Plug 'stephpy/vim-php-cs-fixer'
"Plug 'arnaud-lb/vim-php-namespace'
Plug 'sniphpets/sniphpets'
Plug 'sniphpets/sniphpets-common'
Plug 'sniphpets/sniphpets-phpunit'
Plug 'sniphpets/sniphpets-symfony'
Plug 'mustache/vim-mustache-handlebars'
" dependency for deoplete
Plug 'ludovicchabant/vim-gutentags'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
call plug#end()

" sanity
filetype plugin indent on

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" sessions
let g:session_autoload = 'no'

" PHP namespaces
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>pnu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pnu :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>pne <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pne :call PhpExpandClass()<CR>
let g:php_namespace_sort_after_insert=1

" airline
let g:airline_theme= "murmur"
let g:airline_powerline_fonts = 1

"vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'

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

" UltiSnips
" Disable built-in <C-x><C-k> to be able to go backward
inoremap <C-x><C-k> <NOP>
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:ultisnips_php_scalar_types = 1

" deoplete-go
"if has('nvim')
"	let g:deoplete#auto_completion_start_length = 1
"	let g:deoplete#enable_at_startup = 1
"	let g:deoplete#sources = {}
"	let g:deoplete#sources._ = ['tag', 'ultisnips', 'member', 'go', 'phpcd']
"	" go language completion
"	let g:deoplete#sources#go#pointer = 1
"	let g:deoplete#sources#go#gocode_binary = '~/go/bin/gocode'
"	let g:deoplete#sources#go#align_class = 1
"	let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
"	"let g:deoplete#ignore_sources = {}
"	"let g:deoplete#ignore_sources.php = {}
"	"let g:deoplete#ignore_sources.php = ['omni', 'buffer', 'file', 'member']
"	let g:deoplete#sources.php = {}
"	let g:deoplete#sources.php = ['tag', 'ultisnips', 'phpcd']
"	" Use partial fuzzy matches like YouCompleteMe
"	"call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
"	"call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
"	"call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
"endif

" neomake
let neomake_verbose = 3
let g:neomake_go_enabled_makers = ['go', 'golint', 'go vet']
"let g:neomake_open_list = 2
let g:neomake_php_enabled_makers = ['php', 'phpcs', 'phpmd']
let g:neomake_php_phpcs_args_standard = '~/Sites/shop-gant/cs-ruleset.xml'
let g:neomake_javascript_enabled_makers = ['jscs', 'eslint']

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', '.git/']
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1

" NERDTree
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeFocus<CR>
let g:NERDTreeWinSize = 50

" gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = [ '*.css', '*.html', '*.js', '*.json', '*.xml',
			\ '*.xsd', '*.xsl', '*.yaml', '*.yml', '*.sh', '*.mk',
			\ '*.phar', '*.ini', '*.rst', '*.md', 'Makefile',
			\ 'README', '*vendor/*/test*', '*vendor/*/Test*',
			\ '*vendor/*/fixture*', '*vendor/*/Fixture*',
			\ '*infrastructure/**', '*vagrant/*', '*build/*',
			\ '*var/cache*', '*var/log*', '*node_modules/*']
