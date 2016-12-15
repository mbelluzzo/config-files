" -----------------------------------
" Sections:
" => General
" => Files and backups
" => Moving around, tabs and buffers
" => VIM user interface
" => Tags, Folding and more
" -----------------------------------

" ----------
" => General
" ----------
set history=512
" set autoread

set hid

set ignorecase
set incsearch

set encoding=utf8

set spell spelllang=en_us

set expandtab
set nosmarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set cino=(0

set lbr

set autoindent
set smartindent

set ffs=unix,dos,mac

set path=./../**,**,/usr/include/**1

filetype on
filetype plugin on
filetype indent on

" --------------------------
" => Files, backups and undo
" --------------------------
set nobackup
set nowb
set noswapfile

" -------------------------------------------
" => Moving around, tabs, windows and buffers
" -------------------------------------------
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" ---------------------
" => VIM user interface
" ---------------------
syntax enable
colorscheme desert
set background=dark
set ruler

if has("gui_running")
   set guifont=Monospace\ 10

   hi ColorColumn guibg=grey15
   set colorcolumn=81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160
endif

set showmatch
set mat=2

set wildmenu
set wildignore=*.o,*~,*.pyc

" --------------------------
" => Tags, Folding and more
" --------------------------

set tags=./tags;$HOME,tags;$HOME,$HOME/projects/tags

hi! link Folded TabLineSel

if has("gui_running")
   set foldcolumn=1
endif

set fillchars=""
set foldlevel=5
set foldmethod=syntax
set foldtext=MyFoldText()
function! MyFoldText()
   let line = getline(v:foldstart)
   let start = strpart(line, 0, matchend(line, '/\*\|{'))
   let end = matchstr(getline(v:foldend), '\*/\|}')
   return start . "..." . end
endfunction
