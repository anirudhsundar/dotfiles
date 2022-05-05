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

" paste without yank, I'll never expect that
vnoremap p "_dP

" I'll never use the command-line window
nnoremap q: <nop>

" Manual toggle mappings for number and relative number
nnoremap <C-n> :set number!<CR>
nnoremap <leader><C-n> :set relativenumber!<CR>
" Restore default <CR> mapping for quickfix lists
" autocmd FileType qf nnoremap <buffer> <CR> <CR>

" Show status line with row and col separated
"set statusline=%F\ %=\col:%c\ line:%l\ %P
"inoremap <F2> <nop>
nnoremap <C-E>p :set invpaste paste?<CR>
set pastetoggle=<F2>

let s:toggleListChars = 1
function! ToggleListChars()
  if s:toggleListChars
    set listchars=tab:▸\ ,extends:❯,precedes:❮
    set showbreak=↪
    set list
    let s:toggleListChars = 0
  else
    set listchars=
    set showbreak=
    set nolist
    let s:toggleListChars = 1
  endif
endfunction

command! ToggleListChars call ToggleListChars()

" Set listchars and showbreak on file open
call ToggleListChars()

" Toggle signcolumn mapping
nnoremap <leader>sc :call ToggleSignColumn()<CR>

" Toggle signcolumn. Works only on vim>=8.0 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=yes
        let b:signcolumn_on=1
    endif
endfunction

" <leader>cm mapping for copy mode
" It removes line numbers, signcolumn, listchars and showbreak
nnoremap <leader>cm :set number!<CR>:set relativenumber!<CR>:call ToggleSignColumn()<CR>:call ToggleListChars()<CR>

" Save when losing focus
au FocusLost * :silent! wall

function SetIndentedPasting(setIndentedPastingMaps)
  let l:setIndentedPastingMaps = a:setIndentedPastingMaps
  if l:setIndentedPastingMaps
    nnoremap p ]p
    nnoremap P [p
    let l:setIndentedPastingMaps = 0
  else
    nunmap p
    nunmap P
    let l:setIndentedPastingMaps = 1
  endif
endfunction

command! -bang SetIndentedPasting call SetIndentedPasting(<bang>1)

" Switching between tab buffers
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]T :tablast<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> <leader><leader>t :tabnew

nnoremap <silent> <leader>ev :execute 'edit '.fnameescape(resolve(fnamemodify('~/.vimrc', ':p')))<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

"Bindings for buffer switching
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> <leader><C-w> :bdelete<CR>

nnoremap <silent> <leader>m :call ToggleMouse()<CR>

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
endfunc

command! BufOnly call myvim#buffers#BufOnly()

" Close all but the current buffer
" nnoremap <leader>bd :execute "%bdelete \| edit # \| bdelete #"<CR>
nnoremap <leader>bd :BufOnly<CR>

" Rebalance vim in tmux automatically
autocmd VimResized * :wincmd =

"zoom and rebalance vim pane
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>


" Move to next and previous folds
nnoremap zl zCzjzA
nnoremap zh zCzkzA

" Focus on current fold
nnoremap <leader>z zMzvzz

" Change cursor for insert and normal mode
if has('nvim')
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
        \,i-ci-ve:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
        \,sm:block-blinkwait175-blinkoff150-blinkon175
  :au VimLeave * set guicursor=a:ver25,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
else
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    au VimLeave * silent !echo -ne "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
  else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[0 q"
    au VimLeave * silent !echo -ne "\e[5 q"
  endif
endif


" quickfix list mappings
nnoremap ]q :cnext<CR>zv
nnoremap [q :cprevious<CR>zv
nnoremap <leader>qw :cclose<CR>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>

" Quit
nnoremap <Leader><C-Q> :qall!<cr>

" :Root -> Change directory to the root of the Git repository
command! Root call myvim#root#changeRoot(myvim#root#root())
" :RootCur -> change to the root of the git repo of current file
command! RootCur call myvim#root#rootcur()
" :Cdcur -> change directory to the current file head
command! Cdcur execute 'lcd' expand("%:h")

" " Jump to start and end of line using the home row keys
noremap H ^
noremap L $

" Reset the original H and L with leader versions
noremap <leader>H H
noremap <leader>L L
noremap <leader>M M

" Always use very magic mode
" nnoremap / /\v
" vnoremap / /\v

map <tab> %

" keep changelist jumps at the center of the screen
nnoremap g; g;zz
nnoremap g, g,zz

" adjust split sizes with Ctrl-arrowkeys
nnoremap <c-left> 5<c-w><
nnoremap <c-right> 5<c-w>>
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-

" Open a quickfix window for the last search results
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

nnoremap <leader>V V`]

augroup vim_specific
autocmd!
autocmd FileType vim vnoremap <leader>S y:execute @@<cr>
autocmd FileType vim nnoremap <leader>S ^vg_y:execute @@<cr>
augroup END

noremap ' `
noremap ` '
noremap <C-p> <C-^>

nnoremap vv ^vg_

" Keep visual selection when indenting
vnoremap > >gv
vnoremap < <gv

" Useful insert mode mappings
inoremap <C-E>h <C-O>^
inoremap <C-E>l <C-O>$
inoremap <C-B> <C-O><C-B>
inoremap <C-F> <C-O><C-F>

" Insert current date on <F4>
inoremap <C-E>d <C-R>=strftime('%F')<CR>
inoremap <C-E>p <C-R>=resolve(expand("%:p"))<CR>

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

if exists("*trim") " This is needed because trim() does not exist in older vim versions
  " grepprg is always set to use vimgrep as rg is always present at $HOME/.bin
  if trim(split(system('which rg'),'/')[-1]) ==# 'rg'
    set grepprg=rg\ --vimgrep
    let s:grepprg_val = 'rg'
  endif
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

function! s:clangCmdImpl(cmd)
  if &autowrite | wall | endif
  echo "Running " . a:cmd . " ..."
  let l:output = system(a:cmd)
  cexpr l:output
  cwindow
  let w:quickfix_title = a:cmd
  if v:shell_error != 0
    cc
    echo "Done!"
  endif
  let g:clang_check_last_cmd = a:cmd
endfunction

function! ClangTool(tool)
  if !empty(a:tool)
    let l:filename = expand('%')
    " if l:filename =~ '\.\(cpp\|cxx\|cc\|c\)$'
    if &filetype =~ 'cpp' || &filetype =~ 'c'
      call s:clangCmdImpl(a:tool . " " . l:filename)
    endif
  else
    echom "Tool not defined, please mention a tool name in argument like 'clang-tidy', 'clang-check', etc"
  endif
endfunction

command! -nargs=1 ClangTool call ClangTool(<q-args>)
nmap <silent> <leader><leader>cc :ClangTool 'clang-check'<CR>
nmap <silent> <leader><leader>ct :ClangTool 'clang-tidy'<CR>

cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?"
      \ ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?"
      \ ? "<CR>?<C-r>/" : "<S-Tab>"

" Make sure Vim returns to the same line when you reopen a file.
" Taken from SJL vimrc
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

"---------------------------------------------
" End of Common mappings
"------------------------------------------}}}
