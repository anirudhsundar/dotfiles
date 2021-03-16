let s:longlines_on = 0
function! myvim#longlines#LongLinesToggle(threshold)
  if s:longlines_on
    set colorcolumn=
    cclose
    let s:longlines_on = 0
  else
    if empty(a:threshold)
      if &textwidth == 0
        let l:threshold = &textwidth
      else
        let l:threshold = 80
      endif
    else
      let l:threshold = str2nr(a:threshold)
    endif
    let l:spaces = repeat(" ", &ts)
    let l:line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", l:spaces, "g"))')
    let l:long_line_lens = filter(copy(l:line_lens), 'v:val > l:threshold')
    let l:indices = map(copy(l:long_line_lens), 'index(l:line_lens, v:val)')
    let l:long_lines = map(l:indices, '{"filename": expand("%"), "lnum": v:val+1, "text": "Line length: ".l:long_line_lens[v:key]}')
    call setqflist(l:long_lines)
    let &colorcolumn=l:threshold
    copen
    wincmd W
    let s:longlines_on = 1
  endif
endfunction

function! myvim#longlines#RemoveLongLines()
  set colorcolumn=
  cclose
endfunction

