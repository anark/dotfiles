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
Plug 'sheerun/vim-polyglot'                 "autoloading of syntax highlighting
Plug 'tpope/vim-commentary'                 "gc for commenting code blocks
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
" Not needed when using coc
" Plug 'w0rp/ale'                             "asyncronous linting
" Plug 'mhinz/vim-signify'

" formatting
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Theming
Plug 'cocopon/iceberg.vim'
Plug 'jeffkreeftmeijer/vim-dim'

" Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" File browsing
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }

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

" Autocomplete
" --------------------------------------------------------------------
" Enable autocomplete on startup
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Prettier
" ---------------------------------------------------------------------
" Run prettier before saving
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

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
let g:lightline = { 'colorscheme': 'iceberg' }

" Always show line numbers
set number

" Font Stuff
set guifont=Monaco:h13
set linespace=2
