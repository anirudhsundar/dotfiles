function! myvim#root#root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echom 'Not in git repo'
  else
    return root
  endif
endfunction

function! myvim#root#changeRoot(rootDir)
  execute 'lcd' a:rootDir
  echo 'Changed directory to: '.a:rootDir
endfunction

function! myvim#root#rootcur()
  execute 'lcd' expand("%:h")
  call myvim#root#changeRoot(myvim#root#root())
endfunction

