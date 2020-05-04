" Go LSP
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls'],
       \ 'groovy': ['java', '-jar', '~/src/groovy-language-server/build/libs/groovy-language-server.jar']
       \ }

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
	\ '_': ['buffer'],
	\ 'go': ['LanguageClient', 'ultisnips'],
	\ 'groovy': ['LanguageClient'],
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

