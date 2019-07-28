set nocompatible

" Plugins
" --------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'rstacruz/vim-opinion'                 " TODO: Remove this and add what I want from it
Plug 'tpope/vim-fugitive'                   " Git utilities
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fuzzy file finder
Plug 'junegunn/fzf.vim'                     "fuzzy file finder

Plug 'tpope/vim-commentary'                 "gc for commenting code blocks
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'

" In Probationary period
Plug 'jiangmiao/auto-pairs'                     " Auto close parenthesis
Plug 'tpope/vim-endwise'                        " Auto ruby methods with ends
Plug 'tpope/vim-dispatch'

" Not needed when using coc
" Plug 'w0rp/ale'                             "asyncronous linting
" Plug 'mhinz/vim-signify'

" Language specific
Plug 'tpope/vim-rails'

" Theming and colours
" Plug 'cocopon/iceberg.vim'
" Plug 'tyrannicaltoucan/vim-quantum'
" Plug 'patstockwell/vim-monokai-tasty'
Plug 'joshdick/onedark.vim'

" 16 colour themes for terminal colours
" Plug 'chriskempson/base16-vim'
" Plug 'noahfrederick/vim-noctu'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File browsing
Plug 'scrooloose/nerdtree'

" File types
Plug 'sheerun/vim-polyglot'                 "autoloading of syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

let mapleader=';'
set updatetime=100

set smartcase                " Smarter searchin based on case if we search with case
set clipboard+=unnamed       " Yank to the system clipboard. 'unnamed' works in neovim _and_ MacVim. Makes nvim very slow to start :(
set undofile                 " Use undo files for persistent undo

" Prefer rg > ag > ack
if executable('rg')
  let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" EasyEsacpe
" --------------------------------------------------------------------
inoremap jk <Esc>
cnoremap jk <C-c>

" Consitently exit insert mode https://www.gregorykapfhammer.com/writing/tool/vim/2017/06/30/Consistently-Leaving-Neovim/ but added fzf exit
inoremap <ESC> <C-\><C-n>
tnoremap <expr> jk (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>"

" Autocomplete and COC
" --------------------------------------------------------------------
autocmd FileType typescript,javascript,typescript.tsx map <buffer> <silent> <C-]> <Plug>(coc-definition)
autocmd FileType typescript,javascript,typescript.tsx map <buffer> <silent> <C-[> <Plug>(coc-references)
autocmd FileType typescript,javascript,typescript.tsx map <buffer> <silent> <leader>r <Plug>(coc-rename)

"PROBATIONARY
map <silent> <Leader>x <Plug>(coc-codeaction-selected)
nnoremap <silent> K :call CocAction('doHover')<CR>
" autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" map <silent> <Leader>z <Plug>(coc-codelens-action)

" Create :Prettier command to format file
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

map <silent> <Leader>e :CocList diagnostics<cr>
map <silent> <Leader>l :CocList<CR>

" Use vim style navigation of autocomplete options
inoremap <expr><C-j> pumvisible() ? "\<c-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<c-p>" : "\<C-k>"

" VSCode style tab select to tab between snippet sections
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

let g:coc_snippet_next = '<tab>'

" Ale autoformatting and linting.  Can use coc insteead with coc-prettier and
" coc-eslint
" ---------------------------------------------------------------------
" Run prettier before saving
" let g:ale_linters = {
"   \ 'javascript': ['eslint'],
" \}
"
" let g:ale_fixers = {
"   \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"   \ 'javascript': ['prettier'],
" \}
" let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 0

"" NERDTree
" ---------------------------------------------------------------------
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=40
let g:NERDTreeRespectWildIgnore = 1

function! ToggleNerdTree()
  if @% !=# '' && (!exists('g:NERDTree') || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
    :NERDTreeFind
  else
    :NERDTreeToggle
  endif
endfunction

" Start NERDTree when opening a directory
autocmd StdinReadPre * let s:std_in=1

" Quit vim if only NERDtree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <silent> <Leader>n :call ToggleNerdTree()<CR>

" Fuzzy File Finding
" ----------------------------------------------------------------------
map <silent> <Leader>f :Files<CR>
" Allow tab to be used to select file
tnoremap <expr> <tab> (&filetype == "fzf") ? "<cr>" : "<tab>"

" Use a floating window to display fzf
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()
 let height = &lines - 3
 let width = float2nr(&columns - (&columns * 2 / 10))
 let col = float2nr((&columns - width) / 2)

 let opts = {
       \ 'relative': 'editor',
       \ 'row': height * 0.3,
       \ 'col': col + 30,
       \ 'width': width * 2 / 3,
       \ 'height': height / 2
       \ }

 let buf = nvim_create_buf(v:false, v:true)
 let win = nvim_open_win(buf, v:true, opts)

 call setwinvar(win, '&winhl', 'Normal:Pmenu')

 setlocal
       \ buftype=nofile
       \ nobuflisted
       \ bufhidden=hide
       \ nonumber
       \ norelativenumber
       \ signcolumn=no
endfunction

" Quick cycling between windows
" ---------------------------------------------------------------------
map <c-h> <C-w>h
map <c-j> <C-w>j
map <c-k> <C-w>k
map <c-l> <C-w>l

" Appearance
" ---------------------------------------------------------------------
syntax enable

" Use 16 color colorscheme and remove termguicolors to use colors from terminal
" colorscheme base16
" colorscheme noctu

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
else
  set t_Co=256
endif

" colorscheme vim-monokai-tasty

" colorscheme quantum
" let g:quantum_black=1

" colorscheme iceberg

colorscheme onedark
let g:onedark_termcolors=16

" let g:lightline = { 'colorscheme': 'iceberg',
" let g:lightline = { 'colorscheme': 'quantum',
" let g:lightline = { 'colorscheme': 'monokai_tasty',
let g:lightline = { 'colorscheme': 'onedark',
      \  'active': {
      \    'left': [ [ 'mode', 'paste' ],
      \              [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \  },
      \  'component_function': {
      \    'cocstatus': 'coc#status'
      \  },
      \}

" Always show line numbers
set number

" Font Stuff
set linespace=2
" TODO:  Set nice font either here or in Gvimrc

" Always enter insert mode when switching to a terminal
autocmd BufWinEnter,WinEnter,TermOpen term://* startinsert
tnoremap <expr> <C-h> (&filetype == "fzf") ? "<C-h>" : "<C-\><C-n><C-w>h"
tnoremap <expr> <C-j> (&filetype == "fzf") ? "<C-j>" : "<C-\><C-n><C-w>j"
tnoremap <expr> <C-k> (&filetype == "fzf") ? "<C-k>" : "<C-\><C-n><C-w>k"
tnoremap <expr> <C-l> (&filetype == "fzf") ? "<C-l>" : "<C-\><C-n><C-w>l"
