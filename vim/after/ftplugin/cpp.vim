setlocal iskeyword=@,48-57,_,192-255,~
if !has('nvim')
  set foldmethod=syntax
endif
let s:notend = '\%(\<else\s\+\)\@<!'
let b:match_words= '\<if\>:\<else\>,' . s:notend . '\<if\>:\<else\s\+if\>'
set matchpairs+=<:>
