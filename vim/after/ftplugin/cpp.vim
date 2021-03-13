setlocal iskeyword=@,48-57,_,192-255,~
set foldmethod=syntax
let s:notend = '\%(\<else\s\+\)\@<!'
let b:match_words= '\<if\>:\<else\>,' . s:notend . '\<if\>:\<else\s\+if\>'
