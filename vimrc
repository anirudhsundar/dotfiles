" Settings that have to be at the top of file -----------------{{{
" Never use vi compatible unless we explicitly change this in vimrc
" Commenting out as it's not needed  because of the presense of this file
"set nocompatible


" leader is space
let mapleader=" "

augroup vimrc
  autocmd!
augroup END
" }}}

" VimPlug Setup and list of Plugins ---------------{{{
" Auto download and install vim plugins using vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Syntax highlighting related plugins
"----------------------------------------------{{{

" A couple of dark themes
Plug 'joshdick/onedark.vim'
" Plug 'gosukiwi/vim-atom-dark'
" Plug 'nanotech/jellybeans.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jacoborus/tender.vim'

" Simple 256 bit color scheme
" Plug 'junegunn/seoul256.vim'

Plug 'morhetz/gruvbox'

" Molokai theme
Plug 'sickill/vim-monokai'

" Rainbow-csv
" Plug 'mechatroner/rainbow_csv'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" vim-markdown
" Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'plasticboy/vim-markdown'




" Syntax highlighting for jsonc
" Plug 'kevinoid/vim-jsonc'

if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  " Plug 'nvim-treesitter/playground'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
else
  " Enhanced syntax highlight for cpp for vim
  Plug 'octol/vim-cpp-enhanced-highlight'
endif

Plug 'cespare/vim-toml'

" Add eye-candy icons
Plug 'ryanoasis/vim-devicons'

Plug 'psf/black', { 'branch': 'stable' }

"----------------------------------------------}}}

"Programming related
"----------------------------------------------{{{
" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 70

"Vim commentary with repeat support
Plug 'tpope/vim-commentary'
" vim-commentary



" cscope_maps
" Plug 'chazy/cscope_maps'

" access cppman from vim with keywordprg 'K' command
"----------------------------------------------{{{
Plug 'gauteh/vim-cppman', { 'on': 'Cppman' }
" Add cppman support and add tmux split for cppman
command! -nargs=+ Cppman silent! call system("tmux split-window -h cppman " . expand(<q-args>))
" Use <leader>K for calling cppman as K is used by coc for popup doc
autocmd FileType cpp nnoremap <silent><buffer> <leader>K <Esc>:Cppman <cword><CR>
"----------------------------------------------}}}

" Vim surround with anything
Plug 'tpope/vim-surround'

" LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

" Detect indent
Plug 'timakro/vim-yadi'

" Dispatch makeprg asynchronously
Plug 'tpope/vim-dispatch'

" Repl and plugin development helper for vim
" Plug 'tpope/vim-scriptease'

" Repl
Plug 'metakirby5/codi.vim'

" vimwiki
"----------------------------------------------{{{
if has('nvim')
  " taskwiki
  Plug 'tools-life/taskwiki'

  Plug 'vimwiki/vimwiki'
  " vimwiki use markdown by default
  let g:vimwiki_list = [{'path': '~/my-notes/',
        \ 'syntax': 'markdown', 'ext': '.md'}]

  let g:vimwiki_markdown_link_ext = 1

  let g:taskwiki_markup_syntax = 'markdown'
endif
"----------------------------------------------}}}

" golang
"----------------------------------------------{{{
" if v:version >= 800
  " Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  " " vim-go specific settings
  " " run :GoBuild or :GoTestCompile based on the go file
  " function! s:build_go_files()
  "   let l:file = expand('%')
  "   if l:file =~# '^\f\+_test\.go$'
  "     call go#test#Test(0, 1)
  "   elseif l:file =~# '^\f\+\.go$'
  "     call go#cmd#Build(0)
  "   endif
  " endfunction

  " autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
  " autocmd FileType go nmap <leader>gr <Plug>(go-run)
  " autocmd FileType go nmap <leader>gt <Plug>(go-test)
  " autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
  " let g:go_list_type = "quickfix"
  " " let g:go_def_mode='gopls'
  " " let g:go_info_mode='gopls'
  " " disable vim-go :GoDef short cut (gd)
  " " this is handled by LanguageClient [LC]
  " let g:go_def_mapping_enabled = 0
" endif

augroup golang
  autocmd!
  autocmd BufRead *.go set autoread
  autocmd BufWritePost *.go silent !gofmt -w %
  autocmd BufWritePost *.go silent edit
augroup END

"----------------------------------------------}}}

" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python', 'on': 'Pydocstring'}
let g:pydocstring_enable_mapping = 0
let g:pydocstring_formatter = 'numpy'

"----------------------------------------------}}}

" Tmux plugins
"----------------------------------------------{{{
" Focus events work properly for vim in tmux panes
" Plug 'tmux-plugins/vim-tmux-focus-events'

" Share vim clipboard across panes
Plug 'roxma/vim-tmux-clipboard'

Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

" Meta keys only work properly on neovim
" There are no equivalent keys on vim
if has('nvim')
  nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>
endif

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

Plug 'christoomey/vim-tmux-runner'
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

noremap <leader>vs :VtrSendLinesToRunner!<cr>
nnoremap <leader>vf :VtrSendFile!<cr>
nnoremap <leader>vk :VtrKillRunner<cr>
nnoremap <leader>vo :VtrOpenRunner<cr>
nnoremap <leader>vr :VtrFocusRunner<cr>

"----------------------------------------------}}}

" Git plugins
"----------------------------------------------{{{

" Git gutter for showing updated git diffs
"----------------------------------------------{{{
Plug 'airblade/vim-gitgutter'
" Update Git Gutter signs column colors"
set updatetime=250
let g:gitgutter_max_signs = 500
" No mapping
let g:gitgutter_map_keys = 0
" Colors
let g:gitgutter_override_sign_column_highlight = 0
autocmd SourcePre,VimEnter * highlight clear signcolumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4
nnoremap <Leader><leader>g :GitGutterToggle<CR>
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
"----------------------------------------------}}}


" Vim interface for git commands using :Git, :Gsplit :Gedit
Plug 'tpope/vim-fugitive'

" commit browser
Plug 'junegunn/gv.vim', { 'on': 'GV' }

Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }

Plug 'rbong/vim-flog', {'on': 'Flog'}

Plug 'pgr0ss/vim-github-url'

"----------------------------------------------}}}

" Switching files
"----------------------------------------------{{{

" FZF
"----------------------------------------------{{{
" Fuzzy file finder for vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" FZF bindings
" 'Files'
nmap <leader>fp :FZF<CR>
" 'Git files'
nnoremap <silent> <Leader>fg :GFiles<CR>
" 'Files in current directory'
nnoremap <silent> <Leader>f. :Files <C-r>=expand("%:h")<CR>/<CR>
" 'List of open Buffers'
nnoremap <silent> <Leader>fb :Buffers<CR>
" 'Most recently opened files'
nnoremap <silent> <Leader>fm :FZFMru --multi<CR>
" 'Opened files hitory'
nnoremap <silent> <Leader>fh :History<CR>
" 'Lines in all open buffer'
nnoremap <silent> <Leader>fl :Lines<CR>
" 'Lines in current buffer'
nnoremap <silent> <Leader>fbl :BLines<CR>
command! -bang -nargs=* RgFixed call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --follow --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RgFixedCur call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --follow --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': expand('%:p:h')}), <bang>0)
command! -bang -nargs=* RgWord call fzf#vim#grep('rg --column --line-number --no-heading -w --smart-case --follow --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

function! RipGrepWithOptions(options, bang)
  let l:defaultOptions = '--column --line-number --no-heading --smart-case --follow --color "always"'
  let l:defaultOptionsList = split(l:defaultOptions)
  let l:newOptionsList = split(a:options)
  let l:allOptions = l:defaultOptionsList + l:newOptionsList
  let l:optionString = join(l:allOptions, " ")
  echom l:optionString
  call fzf#vim#grep('rg ' . l:optionString, 1, fzf#vim#with_preview(), a:bang)
endfunction

command! -bang -nargs=* RgOpt call RipGrepWithOptions(<q-args>, <bang>0)

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
inoremap <expr> <c-x><c-l> fzf#vim#complete#line()
inoremap <expr> <c-x><c-b> fzf#vim#complete#buffer_line()


" operator mapping for ripgrep
" nnoremap <leader>rg :set operatorfunc=<SID>RipGrepOperator<cr>g@
nnoremap <expr> <leader>rg RipGrepOperatorWrapper('')
nnoremap <expr> <leader>r.g RipGrepOperatorWrapper('.')
nnoremap <expr> <leader>rwg RipGrepOperatorWrapper('w')
nnoremap <expr> <leader>rig RipGrepOperatorWrapper('i')
vnoremap <leader>rg :<c-u>call RipGrepOperator(visualmode())<cr>

function! RipGrepOperatorWrapper(cur)
  let s:ripgrepCur = a:cur
  set operatorfunc=RipGrepOperator
  return 'g@'
endfunction

function! RipGrepOperator(type)
  let type = a:type
  let saved_unnamed_register = @@

  if type ==# 'v'
      normal! `<v`>y
  elseif type ==# 'char'
      normal! `[v`]y
  else
      return
  endif

  if exists("s:ripgrepCur") && s:ripgrepCur == '.'
    silent execute "RgFixedCur " . @@
  elseif exists("s:ripgrepCur") && s:ripgrepCur == 'w'
    silent execute "RgWord " . @@
  elseif exists("s:ripgrepCur") && s:ripgrepCur == 'i'
    silent execute "RgOpt --no-ignore-vcs -- " . @@
  else
    silent execute "RgFixed " . @@
  endif

  let @@ = saved_unnamed_register

endfunction

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

function! RipgrepFzf(query, fullscreen, fixed)
  let command_fmt = 'rg --column --line-number ' . a:fixed . ' --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0, '')
command! -nargs=* -bang RGFixed call RipgrepFzf(<q-args>, <bang>0, '--fixed-strings')
command! -nargs=* -bang RGWord call RipgrepFzf(<q-args>, <bang>0, '-w')

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bdelete' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

nnoremap <silent> <Leader>fc :BD<CR>

" Most Recently Used files search using fzf
Plug 'pbogut/fzf-mru.vim'

"----------------------------------------------}}}

" vim-startify
"----------------------------------------------{{{
"
" Vim start screen
Plug 'mhinz/vim-startify'
" change to vcs root when file is directly opened
let g:startify_change_to_vcs_root = 1

" start listing from current directory as MRU files are accessible from
" fzf-mru
let g:startify_lists = [
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
          "\ { 'type': 'files',     'header': ['   Files']            }

" basic bookmarks template, not really used right now
let g:startify_bookmarks = [
            \ { 'z': '~/.zshrc' },
            \ ]
"----------------------------------------------}}}
" A tree explorer plugin for vim
" Try out Lexplore
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" nmap <F7> :NERDTreeToggle<CR>

" Plug 'voldikss/vim-floaterm'
" Plug 'ptzz/lf.vim'
" let g:lf_map_keys = 0

Plug 'thezeroalpha/vim-lf'

"----------------------------------------------}}}

" Misc plugins
"----------------------------------------------{{{
" Repeat with '.' in plugins
Plug 'tpope/vim-repeat'

" Better incremental search
Plug 'haya14busa/incsearch.vim'
" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Airline statusline when powerline fonts are available
"----------------------------------------------{{{
Plug 'vim-airline/vim-airline'
" Lightline or Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_extensions = ['tabline', 'hunks', 'branch', 'coc']
if !has('nvim')
  let g:airline_extensions = g:airline_extensions + ['searchcount']
endif
" Enable tabline if needed
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0

" --INSERT-- is unncessary because of airline
set noshowmode
"----------------------------------------------}}}


" Visual search
Plug 'nelstrom/vim-visual-star-search'

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  let g:undotree_WindowLayout = 2
  nnoremap <leader>U :UndotreeToggle<CR>

Plug 'junegunn/vim-peekaboo'

Plug 'vim-scripts/VisIncr'

Plug 'vim-utils/vim-man'

Plug 'gyim/vim-boxdraw'

Plug 'chrisbra/unicode.vim'

Plug 'tpope/vim-eunuch'

Plug 'wellle/targets.vim'

nmap <Leader>rro  <Plug>ReplaceWithRegisterOperator
nmap <Leader>rrl <Plug>ReplaceWithRegisterLine
xmap <Leader>rrv  <Plug>ReplaceWithRegisterVisual
Plug 'vim-scripts/ReplaceWithRegister'

Plug 'lfv89/vim-interestingwords'

Plug 'sjl/clam.vim'

Plug 'mtth/scratch.vim'

"----------------------------------------------}}}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set runtimepath+=~/.vim/.misc_vim
" }}}


" Plugin specific config to be set after plug#end----------------------{{{
" Treesitter_config --------------------{{{

if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
 highlight = {
   enable = true,
 },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
 incremental_selection = {
   enable = true,
   keymaps = {
     init_selection = "<leader>tn",
     node_incremental = "<leader>tl",
     scope_incremental = "<leader>tsl",
     node_decremental = "<leader>th",
   },
 },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
 indent = {
   enable = false
 }
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
if &filetype !=# 'vim'
 set foldlevelstart=99
endif
lua <<EOF
require'nvim-treesitter.configs'.setup {
 textobjects = {
   select = {
     enable = true,
     keymaps = {
       -- You can use the capture groups defined in textobjects.scm
       ["af"] = "@function.outer",
       ["if"] = "@function.inner",
       ["ac"] = "@class.outer",
       ["ic"] = "@class.inner",
       ["iF"] = "@conditional.inner",
       ["aF"] = "@conditional.outer",

       -- Or you can define your own textobjects like this
       -- ["iF"] = {
       --   python = "(function_definition) @function",
       --   cpp = "(function_definition) @function",
       --   c = "(function_definition) @function",
       --   java = "(method_declaration) @function",
       -- },
     },
   },
 },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
 textobjects = {
   swap = {
     enable = true,
     swap_next = {
       ["<leader>ta"] = "@parameter.inner",
     },
     swap_previous = {
       ["<leader>tA"] = "@parameter.inner",
     },
   },
 },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
 textobjects = {
   move = {
     enable = true,
     set_jumps = true, -- whether to set jumps in the jumplist
     goto_next_start = {
       ["]m"] = "@function.outer",
       ["]]"] = "@class.outer",
     },
     goto_next_end = {
       ["]M"] = "@function.outer",
       ["]["] = "@class.outer",
     },
     goto_previous_start = {
       ["[m"] = "@function.outer",
       ["[["] = "@class.outer",
     },
     goto_previous_end = {
       ["[M"] = "@function.outer",
       ["[]"] = "@class.outer",
     },
   },
 },
}
EOF
endif
" --------------------------------------------------}}}

" Try to auto detect and use the indentation of a file when opened.
autocmd BufRead * DetectIndent

" --------------------------------------------------}}}

" My personal defaults for vim --------------------------{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto toggle between relative and absolute number on focus
"augroup numbertoggle
  "autocmd!
  "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

"-------------------------------------------------
" This sets most of my options
"----------------------------------------------{{{

"use relativenumber and absolute number by default
set number
set relativenumber

" Don't move cursor to start of line on Ctrl-B/F
set nostartofline

" Never use tab chars, always use space
set expandtab

" Otherwise use file type specific indentation. E.g. tabs for Makefiles
" and 4 spaces for Python. This is optional.
filetype plugin indent on

" Set a fallback here in case detection fails and there is no file type
" plugin available. You can also omit this, then Vim defaults to tabs.
"
" This is my ususal indentation config for most files
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

" Always search with ignorecase (will manually turn off when needed)
set ignorecase smartcase
set incsearch

" Set cursorline only on current window
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Always enable hlsearch
set hlsearch

" Don't redraw while executing macros
set lazyredraw

" Disable swap files
set noswapfile

" No backup (use Git instead)
set nobackup

" Prevents automatic write backup
set nowritebackup

" Autoread a file when it is changed from the outside
set autoread

" Set default foldmethod as indent and start with no folds
if &filetype !=# 'vim' && !has('nvim')
  set foldlevelstart=99
  set foldmethod=indent
endif

" Semi-persistent undo
if has('persistent_undo')
  if !has('nvim-0.5')
    set undodir=/tmp
    set undofile
  else
    set undodir=/tmp/nvim
    set undofile
  endif
endif

"-------------------------------------------------
" End of options
"----------------------------------------------}}}

"---------------------------------------------
" Common mappings
source $HOME/.common_mappings.vim

" Vim presentation mode for vpm filetype
autocmd! BufNewFile,BufRead *.vpm call SetVimPresentationMode()

function SetVimPresentationMode()
  nnoremap <buffer> <silent> <Right> :n<CR>
  nnoremap <buffer> <silent> <Left> :N<CR>
  set syntax=markdown
  set filetype=markdown
  set textwidth=80
  set shortmess+=F

  if exists(":Goyo")
    if !exists('#goyo')
      nnoremap <buffer> <silent> <leader>G :Goyo 60%x75%+20%<CR>
      nnoremap <buffer> <silent> <leader>g :Goyo!<CR>
      Goyo 60%x75%+20%
    endif
  endif
endfunction

autocmd FileType markdown set conceallevel=2
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

nnoremap <leader><leader>n :set number!<cr>:set relativenumber!<cr>:call ToggleSignColumn()<CR>

" Always show my comment in grey
autocmd SourcePre,VimEnter * highlight Comment ctermfg=DarkGrey
autocmd FileType c,cpp,cs,java,tablegen setlocal commentstring=//\ %s
autocmd FileType ll setlocal commentstring=;\ %s

autocmd FileType cpp call myvim#makeprg#setMakePrg()

"return a list containing the lengths of the long lines in this buffer
command! -nargs=? LongLinesToggle call myvim#longlines#LongLinesToggle(<q-args>)
nnoremap <leader><leader>l :LongLinesToggle<CR>

let s:tmux_version = split(system("tmux -V"))

if $TMUX != '' && !has('nvim')
  if len(s:tmux_version) == 2
    if str2float(s:tmux_version[1]) > 3.0
      colorscheme onedark
    else
      colorscheme desert
    endif
  endif
else
  colorscheme onedark
endif

let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

" }}}



" Useful mappings taken from Others --------------------------------{{{
" Taken from
"      https://github.com/JJGO/dotfiles/blob/master/vim/.vimrc
" (Thanks to JJGO for that)
" and modified a little
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <C-j/k> to move code lines/blocks up & down
nnoremap <silent> <C-k>    :<C-U>exec "exec 'norm m`' \| move -" . (1+v:count1)<CR>``
nnoremap <silent> <C-j>  :<C-U>exec "exec 'norm m`' \| move +" . (0+v:count1)<CR>``

" inoremap <silent> <C-k>    <C-O>m`<C-O>:move -2<CR><C-O>``
" inoremap <silent> <C-j>  <C-O>m`<C-O>:move +1<CR><C-O>``

vnoremap <silent> <C-k>    :<C-U>exec "'<,'>move '<-" . (1+v:count1)<CR>gv
vnoremap <silent> <C-j>  :<C-U>exec "'<,'>move '>+" . (0+v:count1)<CR>gv

" " pair expansion on the cheap
" inoremap (<CR> (<CR>)<Esc>O
" inoremap (;    (<CR>);<Esc>O
" inoremap (,    (<CR>),<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;    {<CR>};<Esc>O
inoremap {,    {<CR>},<Esc>O
" inoremap [<CR> [<CR>]<Esc>O
" inoremap [;    [<CR>];<Esc>O
" inoremap [,    [<CR>],<Esc>O

" Taken from
" https://www.reddit.com/r/vim/comments/mg8ov7/fuzzily_searching_man_pages_using_fzfvim/gsrvqpv?utm_source=share&utm_medium=web2x&context=3
command! -nargs=? Apropos call fzf#run(fzf#wrap({'source': 'man -k -s 1 '.shellescape(<q-args>).' | cut -d " " -f 1', 'sink': 'tab Vman', 'options': ['--preview', 'MANPAGER=cat MANWIDTH='.(&columns/2-4).' man {}']}))

" Lose Bad Habits
" http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove newbie crutches in Insert Mode
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>
"inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Taken from junegunn's vimrc on github

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------

function! Chomp()
  let saved_unnamed_register = @@
  execute '%s/\s\+$//'." \| normal! ``"
  let @@ = saved_unnamed_register
endfunction

command! Chomp call Chomp()

" ----------------------------------------------------------------------------
" Help in new tabs
" ----------------------------------------------------------------------------
function! s:helptab()
  if &buftype == 'help'
    wincmd T
  endif
endfunction
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt call s:helptab()
augroup END

" }}}


" coc.nvim configurations -------------------------{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Global extensions list
let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-jedi', 'coc-go']

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
  "" Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
"else
if v:version >= 800
  set signcolumn=yes
endif
"endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]g <Plug>(coc-diagnostic-next-error)
nmap <silent> [G <Plug>(coc-diagnostic-prev)
nmap <silent> ]G <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>crn <Plug>(coc-rename)

" coc-clangd specific
nnoremap <leader>cfh :CocCommand clangd.switchSourceHeader<cr>

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Formatting selected code.
xmap <leader>cgq  <Plug>(coc-format-selected)
nmap <leader>cgq  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>cqf  <Plug>(coc-fix-current)
" }}}






" Local vimrc settings to override this config -------------------{{{
if filereadable(expand("~/.local_vimrc"))
  source $HOME/.local_vimrc
endif

" }}}



