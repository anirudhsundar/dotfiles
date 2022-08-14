let b:match_words= '\<if\>:\<elif\>:\<else\>'
" setlocal shiftwidth=2
" setlocal tabstop=2
" setlocal softtabstop=2
nnoremap <buffer> <leader>pdb :normal oimport pdb; pdb.set_trace()<esc>
nnoremap <buffer> <leader>ipdb :normal oimport ipdb; ipdb.set_trace()<esc>

command! -nargs=0 ISort silent! :!isort %
command! -nargs=0 Black silent! :!black %
