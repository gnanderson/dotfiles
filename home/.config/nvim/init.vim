" sanity
set nocompatible
set clipboard=unnamed
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
		let g:python3_host_prog='/usr/local/bin/python3'
	endif
endif

" load in all the config
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor
