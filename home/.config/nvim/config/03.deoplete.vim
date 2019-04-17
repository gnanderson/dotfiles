let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
	\ '_': ['buffer'],
	\ 'php': ['phpactor', 'ultisnips'],
	\ 'go': ['LanguageClient', 'ultisnips'],
	\})

call deoplete#custom#option('disabled_syntaxes', {
	\ '_': ['Comment', 'String'],
	\})

call deoplete#custom#option('matchers', {
	\ '_': ['matcher_full_fuzzy'],
	\})

call deoplete#custom#option('converters', {
	\ '_': ['converter_remove_paren'],
	\})

" Go LSP
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
