set nocompatible

" Plugins
" --------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'rstacruz/vim-opinion'
Plug 'tpope/vim-fugitive'                   " Git utilities
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fuzzy file finder
Plug 'junegunn/fzf.vim'                     "fuzzy file finder
" Plug 'Shougo/denite.nvim'
" Plug 'neoclide/coc-denite'

Plug 'tpope/vim-commentary'                 "gc for commenting code blocks
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
" Not needed when using coc
" Plug 'w0rp/ale'                             "asyncronous linting
" Plug 'mhinz/vim-signify'

" Language specific 
Plug 'tpope/vim-rails'

" Theming
Plug 'cocopon/iceberg.vim'
Plug 'jeffkreeftmeijer/vim-dim'

" Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" File browsing
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }

" File types
Plug 'sheerun/vim-polyglot'                 "autoloading of syntax highlighting
Plug 'peitalin/vim-jsx-typescript'          " currently needed to for filetype for tsx to typescript.tsx/typescript react so I don't get 10000 error.  I'm sure theres a better way to do this

call plug#end()

let mapleader=';'
set updatetime=100

set smartcase                " Smarter searchin based on case if we search with case
set clipboard+=unnamed       " Yank to the system clipboard. 'unnamed' works in neovim _and_ MacVim
set undofile                 " Use undo files for persistent undo

" Ag for grepping (https://github.com/ggreer/the_silver_searcher)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" EasyEsacpe
" --------------------------------------------------------------------
inoremap jk <Esc>
cnoremap jk <C-c>

if has("nvim")
  inoremap <ESC> <C-\><C-n>
  " tnoremap jk <C-\><C-n>
  tnoremap <expr> jk (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>"
endif

" Autocomplete and COC
" --------------------------------------------------------------------
autocmd FileType typescript,javascript map <buffer> <silent> <C-]> <Plug>(coc-definition)
autocmd FileType typescript,javascript map <buffer> <silent> <leader>r <Plug>(coc-rename)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

map <silent> <Leader>e :CocList diagnostics<cr>
map <silent> <Leader>l :CocList<CR>

" Use vim style navigation of autocomplete options
inoremap <expr><C-j> pumvisible() ? "\<c-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<c-p>" : "\<C-k>"

" VSCode style tab select to tab between snippet sections
inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
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

" NERDTree
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
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTreeToggle' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Quit vim if only NERDtree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <silent> <Leader>n :call ToggleNerdTree()<CR>

" Fuzzy File Finding
" ----------------------------------------------------------------------
map <silent> <Leader>f :Files<CR>
let g:fzf_layout = { 'down': '~20%' }

" Quick cycling between windows
" ---------------------------------------------------------------------
map <c-h> <C-w>h
map <c-j> <C-w>j
map <c-k> <C-w>k
map <c-l> <C-w>l

" Appearance
" ---------------------------------------------------------------------
syntax enable

" Use dim colorscheme and remove termguicolors to use colors from terminal
" colorscheme dim

set termguicolors background=dark
colorscheme iceberg
let g:lightline = { 'colorscheme': 'iceberg',
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
set guifont=Monaco:h13
set linespace=2
