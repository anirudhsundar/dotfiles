" Settings that have to be at the top of file -----------------{{{
" Never use vi compatible unless we explicitly change this in vimrc
" Commenting out as it's not needed  because of the presense of this file
"set nocompatible


" leader is space
let mapleader=" " 
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

" A couple of dark themes
Plug 'joshdick/onedark.vim'
Plug 'gosukiwi/vim-atom-dark'

" cool plugin that removes hlsearch after search is done
" <C-l> clears the hlsearch and that's preferrable
"Plug 'romainl/vim-cool'

" Enhanced syntax highlight for cpp
Plug 'octol/vim-cpp-enhanced-highlight'

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Simple 256 bit color scheme
Plug 'junegunn/seoul256.vim'

" A tree explorer plugin for vim
Plug 'preservim/nerdtree'

" Fuzzy file finder for vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Most Recently Used files search using fzf
Plug 'pbogut/fzf-mru.vim'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'

" Easy commenting
"Plug 'scrooloose/nerdcommenter'

"Vim commentary with repeat support
"Plug 'tpope/vim-commentary'

" tcomment
Plug 'tomtom/tcomment_vim'

" cscope_maps
Plug 'chazy/cscope_maps'

" Focus events work properly for vim in tmux panes
Plug 'tmux-plugins/vim-tmux-focus-events'

" Share vim clipboard across panes
Plug 'roxma/vim-tmux-clipboard'

" access cppman from vim with keywordprg 'K' command
Plug 'gauteh/vim-cppman'

" Git gutter for showing updated git diffs
Plug 'airblade/vim-gitgutter'

" Vim interface for git commands using :Git, :Gsplit :Gedit
Plug 'tpope/vim-fugitive'

" Add nice graph visualization to git log --graph view
Plug 'rbong/vim-flog'

" Vim surround with anything
Plug 'tpope/vim-surround'

" Repeat with '.' in plugins
Plug 'tpope/vim-repeat'

" Better incremental search
Plug 'haya14busa/incsearch.vim'

" incsearch with easymotion
Plug 'haya14busa/incsearch-easymotion.vim'

" Better statusline
"Plug 'itchyny/lightline.vim'

" Airline statusline when powerline fonts are available
Plug 'vim-airline/vim-airline'

" Vim start screen
Plug 'mhinz/vim-startify'

" Vim undo history
Plug 'simnalamburt/vim-mundo'

" Useful unix commands from vim
Plug 'tpope/vim-eunuch'

" Auto detect buffer options
"Plug 'tpope/vim-sleuth'

" Nice completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax highlighting for jsonc
Plug 'kevinoid/vim-jsonc'

" Visual search
Plug 'nelstrom/vim-visual-star-search'

" Molokai theme
Plug 'sickill/vim-monokai'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Snippets
Plug 'honza/vim-snippets'

" vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" vimwiki
Plug 'vimwiki/vimwiki'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set runtimepath+=~/.vim/.misc_vim
" }}}


" Plugings specific settings--------------------------------{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add cppman support and add tmux split for cppman
command! -nargs=+ Cppman silent! call system("tmux split-window -h cppman " . expand(<q-args>))

" Use <leader>K for calling cppman as K is used by coc for popup doc
autocmd FileType cpp nnoremap <silent><buffer> <leader>K <Esc>:Cppman <cword><CR>

nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 70

nmap <F7> :NERDTreeToggle<CR>

" FZF bindings
nmap <leader><leader>p :FZF<CR>
nnoremap <silent> <Leader>. :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>m :FZFMru<CR>
nnoremap <silent> <Leader>fm :History<CR>
nnoremap <silent> <Leader><Leader>l :Lines<CR>
" Unable to use <leader><leader>b as its mapped to easymotion
nnoremap <silent> <Leader><Leader>c :BLines<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


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

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" incsearch-easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

nnoremap <leader><leader>u :MundoToggle<CR>

" Easymotion higlight colors
hi link EasyMotionTarget2First Statement
hi link EasyMotionTarget2Second Statement

"""""""""""""""""""""""""""""""""""""""""""""""""
" vim-startify
"""""""""""""""""""""""""""""""""""""""""""""""""
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

" vimwiki use markdown by default
let g:vimwiki_list = [{'path': '~/my-notes/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Lightline or Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable tabline if needed
let g:airline#extensions#tabline#enabled = 1

" --INSERT-- is unncessary because of lightline
set noshowmode

" lightline theme
"let g:lightline = {
      "\ 'colorscheme': 'wombat',
      "\ 'active': {
      "\   'left': [ [ 'mode', 'paste' ],
      "\             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      "\ },
      "\ 'component_function': {
      "\   'cocstatus': 'coc#status',
      "\   'currentfunction': 'CocCurrentFunction'
      "\ },
      "\ }

" vim-go specific settings
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>gr <Plug>(go-run)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
let g:go_list_type = "quickfix"

" }}}

" My personal defaults for vim --------------------------{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto toggle between relative and absolute number on focus
"augroup numbertoggle
  "autocmd!
  "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

"use relativenumber and absolute number by default
set number
set relativenumber

" Manual toggle mappings for number and relative number
nnoremap <C-m> :set number!<CR>
nnoremap <leader><C-m> :set relativenumber!<CR>


" Never use tab chars, always use space
set expandtab

" This is my ususal indentation config for most files
" Doesn't work on python files as filetype plugin for python
" is loaded after vimrc
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

" Always search with ignorecase (will manually turn off when needed)
set ignorecase
set incsearch

" Use jk for going back to command mode
" My left hand will think me
inoremap jk <esc>
" Get used to jk for esc
"inoremap <esc> <nop>

" I'll never use the command-line window
nnoremap q: <nop>

" Show status line with row and col separated
"set statusline=%F\ %=\col:%c\ line:%l\ %P
"inoremap <F2> <nop>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Toggle signcolumn mapping
nnoremap <leader>s :call ToggleSignColumn()<CR>

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

" Always show my comment in grey
autocmd SourcePre,VimEnter * highlight Comment ctermfg=DarkGrey

" Switching between tab buffers
nnoremap <leader>L :tabnext<CR>
nnoremap <leader>H :tabprevious<CR>
nnoremap <leader>J :tablast<CR>
nnoremap <leader>T :tabnew<CR>
nnoremap <leader><leader>t :tabnew 
nnoremap <leader><C-w> :tabc<CR>

nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Bindings for buffer switching
" Commented out in favor of using the fzf :Buffers mapping
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>j :blast<CR>
nnoremap <leader>k :bfirst<CR>
nnoremap <leader>w :bdelete<CR>

" Set vimscript foldmethod to marker
"augroup filetype_vim
    "autocmd!
    "autocmd FileType vim setlocal foldmethod=marker
"augroup END

nnoremap ) dt)
nnoremap ] dt]

"augroup vimrc_cpp
  "autocmd!
  "autocmd FileType cpp set iskeyword+=:,<,>,[,],!
"augroup END

" Ctrl-d deletes current line in insert mode
"inoremap <c-d> <esc>ddi

" Ctrl-u changes the current word to uppercase in both insert and normal mode
"inoremap <C-u> <esc>viwUi

" Wrap current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel

"Wrap selected text
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>
vnoremap <leader>( <esc>`<i(<esc>`>la)<esc>
vnoremap <leader>[ <esc>`<i[<esc>`>la]<esc>
vnoremap <leader>{ <esc>`<i{<esc>`>la}<esc>

" Move to next and previous folds
nnoremap zl zCzjzA
nnoremap zh zCzkzA

" Set cursorline always
set cursorline

" Change cursor for insert and normal mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[0 q"

au VimLeave * silent !echo -ne "\e[5 q"

" Always enable hlsearch
set hls

" Set default foldmethod as indent and start with no folds
set foldlevelstart=99
set foldmethod=indent


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
      nnoremap <buffer> <silent> G :Goyo 60%x75%+20%<CR>
      nnoremap <buffer> <silent> g :Goyo!<CR>
      Goyo 60%x75%+20%
    endif
  endif
endfunction

autocmd FileType markdown set conceallevel=2

" quckfix list mappings
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprevious<CR>
nnoremap <leader>qw :cclose<CR>


" }}}



" Useful mappings taken from Others --------------------------------{{{
" Taken from
"      https://github.com/JJGO/dotfiles/blob/master/vim/.vimrc
" (Thanks to JJGO for that)
" and modified a little
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " Jump to start and end of line using the home row keys
map H ^
map L $

" (Shift)Tab (de)indents code
vnoremap <Tab> >
vnoremap <S-Tab> <

" Capital JK move code lines/blocks up & down
" TODO improve functionality
nnoremap <C-k> :move-2<CR>==
nnoremap <C-j> :move+<CR>==
xnoremap <C-k> :move-2<CR>gv=gv
xnoremap <C-j> :move'>+<CR>gv=gv

" super quick search and replace taken from github.com/romainl/minivimrc
nnoremap <leader><leader><Space> :'{,'}s#\<<C-r>=expand("<cword>")<CR>\>#
nnoremap <leader><leader>%       :%s#\<<C-r>=expand("<cword>")<CR>\>#

" pair expansion on the cheap
inoremap (<CR> (<CR>)<Esc>O
inoremap (;    (<CR>);<Esc>O
inoremap (,    (<CR>),<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;    {<CR>};<Esc>O
inoremap {,    {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [;    [<CR>];<Esc>O
inoremap [,    [<CR>],<Esc>O


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
" }}}



" coc.nvim configurations -------------------------{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Global extensions list
let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-jedi']

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
inoremap <silent><expr> <c-space> coc#refresh()

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
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
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

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <leader><leader>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <leader><leader>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <leader><leader>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <leader><leader>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <leader><leader>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <leader><leader>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <leader><leader>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <leader><leader>p  :<C-u>CocListResume<CR>

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
" }}}


let tmux_version = split(system("tmux -V"))

if $TMUX != ''
  if len(tmux_version) == 2
    if str2float(tmux_version[1]) > 3.0
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





" Local vimrc settings to override this config -------------------{{{
if filereadable(expand("~/.local_vimrc"))
  source $HOME/.local_vimrc
endif

" }}}



