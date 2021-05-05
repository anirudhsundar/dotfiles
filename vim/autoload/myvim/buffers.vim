function myvim#buffers#BufOnly()
    let l:currentLine = line(".")
    execute "%bdelete \| edit # \| bdelete #"
    execute l:currentLine
    if foldlevel(l:currentLine) != 0
        execute "foldopen \| :norm z."
    endif
endfunction
