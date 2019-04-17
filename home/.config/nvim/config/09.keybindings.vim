" leader
let mapleader=","
nnoremap <leader>a :echo("\<leader\> works! It is set to <leader>")<CR>

" braces
inoremap {<CR>  {<CR>}<Esc>O

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Print full path
map <C-f> :echo expand("%:p")<cr>

" Terminal settings
if has('nvim')
  " Leader q to exit terminal mode. Somehow it jumps to the end, so jump to
  " the top again
  tnoremap <Leader>q <C-\><C-n>gg<cr>
  " terminfo is fuxored on mac osx
  nmap <BS> <C-W>h

  " mappings to move out from terminal to other views
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " always start terminal in insert mode
  autocmd BufWinEnter,WinEnter term://* startinsert
endif

map <silent> <leader>jd :CtrlPTag<cr><C-\>w
noremap <C-s> :Ack! -aQi <cword> <CR>

noremap <silent> K :call LanguageClient#textDocument_hover()<CR><Paste>

