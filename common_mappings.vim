"---------------------------------------------
" Common mappings
"------------------------------------------{{{

" Lexplore settings
" Open left explore on F7 key with 20% width
let g:netrw_winsize = 20
nmap <F7> :Lexplore<CR>

" super quick search and replace
nnoremap <leader><leader><Space> :%s#\<<C-r>=expand("<cword>")<CR>\>#
nnoremap <leader><leader>%       :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Use jk for going back to command mode
" My left hand will think me
inoremap jk <esc>

" I'll never use the command-line window
nnoremap q: <nop>

" Manual toggle mappings for number and relative number
nnoremap <C-m> :set number!<CR>
nnoremap <leader><C-m> :set relativenumber!<CR>

" Show status line with row and col separated
"set statusline=%F\ %=\col:%c\ line:%l\ %P
"inoremap <F2> <nop>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Switching between tab buffers
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprevious<CR>
nnoremap ]T :tablast<CR>
nnoremap [T :tabfirst<CR>
nnoremap <leader><leader>t :tabnew

nnoremap <leader>ev :execute 'edit '.fnameescape(resolve(fnamemodify('~/.vimrc', ':p')))<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Bindings for buffer switching
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]B :blast<CR>
nnoremap [B :bfirst<CR>
nnoremap <leader><C-w> :bdelete<CR>

command! BufOnly call myvim#buffers#BufOnly()

" Close all but the current buffer
" nnoremap <leader>bd :execute "%bdelete \| edit # \| bdelete #"<CR>
nnoremap <leader>bd :BufOnly<CR>


" Move to next and previous folds
nnoremap zl zCzjzA
nnoremap zh zCzkzA

" Change cursor for insert and normal mode
if has('nvim')
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
        \,i-ci-ve:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
        \,sm:block-blinkwait175-blinkoff150-blinkon175
  :au VimLeave * set guicursor=a:ver25,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[0 q"
  au VimLeave * silent !echo -ne "\e[5 q"
endif


" quickfix list mappings
nnoremap ]q :cnext<CR>zv
nnoremap [q :cprevious<CR>zv
nnoremap <leader>qw :cclose<CR>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :quit<cr>
nnoremap <Leader><C-Q> :qall!<cr>

" :Root -> Change directory to the root of the Git repository
command! Root call myvim#root#changeRoot(myvim#root#root())
" :RootCur -> change to the root of the git repo of current file
command! RootCur call myvim#root#rootcur()
" :Cdcur -> change directory to the current file head
command! Cdcur execute 'lcd' expand("%:h")

" " Jump to start and end of line using the home row keys
map H ^
map L $

" Useful insert mode mappings
inoremap <C-H> <C-O>^
inoremap <C-L> <C-O>$
inoremap <C-B> <C-O><C-U>
inoremap <C-F> <C-O><C-D>

" Insert current date on <F4>
inoremap <F4> <C-R>=strftime('%F')<CR>

augroup HighlightTrailSpace
  autocmd!
  autocmd SourcePre,VimEnter * highlight TrailSpace ctermbg=red ctermfg=yellow
  autocmd SourcePre,VimEnter * match TrailSpace /\s\+$/
augroup END

function s:ToggleTrailSpaceHighlight(setHighlight)
    if a:setHighlight
        highlight TrailSpace ctermbg=red ctermfg=yellow
        call matchadd("TrailSpace", '\s\+$')
    else
        highlight clear TrailSpace
    endif
endfunction

command! -bang TrailSpaceHighlightDisable call s:ToggleTrailSpaceHighlight(<bang>0)

" grepprg is always set to use vimgrep as rg is always present at $HOME/.bin
if trim(split(system('which rg'),'/')[-1]) ==# 'rg'
  set grepprg=rg\ --vimgrep
  let s:grepprg_val = 'rg'
endif

" GrepOperator defined from https://learnvimscriptthehardway.stevelosh.com
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    if split(&grepprg, '\v\s+')[0] ==# 'rg'
      silent execute "grep! --fixed-strings " . shellescape(@@)
    else
      silent execute "grep! -R -F " . shellescape(@@) . " ."
    endif

    copen

    let @@ = saved_unnamed_register
endfunction

nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
"---------------------------------------------
" End of Common mappings
"------------------------------------------}}}
