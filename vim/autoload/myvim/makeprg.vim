function! myvim#makeprg#setMakePrg()
  let l:rootvar = myvim#root#root()
  echom l:rootvar.'/setmakeprg.vim'
  if filereadable(l:rootvar.'/setmakeprg.vim')
    execute 'source '.l:rootvar.'/setmakeprg.vim'
  endif
endfunction

