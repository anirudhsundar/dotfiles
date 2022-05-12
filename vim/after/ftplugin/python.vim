let b:match_words= '\<if\>:\<elif\>:\<else\>'
" setlocal shiftwidth=2
" setlocal tabstop=2
" setlocal softtabstop=2
nnoremap <buffer> <leader>pdb :normal oimport pdb; pdb.set_trace()<esc>
