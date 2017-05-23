".vimrc
" 2017 (c) Aaron Ceross
" ------------------------------------------------------------------------------

" Initialisation {{{
" ------------------------------------------------------------------------------
set nocompatible
filetype off

" set the runtime path to include Vundle and initialise
set runtimepath+=~/.vim/bundle/Vundle.vim
"}}}
" Plugins {{{
" -----------------------------------------------------------------------------
" This set up uses Vundle. To start, the Vundle repository needs to be
" cloned into ~/.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'             " Package management
Plugin 'vim-airline/vim-airline'          " Status bar
Plugin 'vim-airline/vim-airline-themes'   " Themes for vim-airline
Plugin 'nelstrom/vim-visual-star-search'  " Start a * or # search from a
                                          " visual block
Plugin 'tpope/vim-fugitive'               " Git management
Plugin 'airblade/vim-gitgutter'           " Show git changes
Plugin 'jiangmiao/auto-pairs'             " Auto-close delimiter pairs
Plugin 'luochen1990/rainbow'              " Rainbow delimiters
Plugin 'jordwalke/flatlandia'             " Flatland scheme for airline theme
Plugin 'vim-syntastic/syntastic'          " Syntax checker
Plugin 'Shougo/neocomplete'               " Autocompletion
Plugin 'Shougo/neosnippet'                " Code snippets
Plugin 'Shougo/neosnippet-snippets'       " Populate code snippets
Plugin 'scrooloose/nerdtree'              " file tree explorer
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'Rip-Rip/clang_complete'
Plugin 'reedes/vim-pencil'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

        " Language-specific packages
Plugin 'lervag/vimtex'                    " Support for Tex documents
Plugin 'jalvesaq/Nvim-R'                  " R programming support
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'
Plugin 'NLKNguyen/c-syntax.vim'
Plugin 'hdima/python-syntax'
Plugin 'nvie/vim-flake8'
Plugin 'xuhdev/vim-latex-live-preview'

call vundle#end()         " required

filetype plugin indent on " required
 " }}}
" Core Vim {{{
" ------------------------------------------------------------------------------
" Modifications for the core functioning of vim.

" File backups, history {{{
" keep 500 lines of command line history
set history=500

" no need for backups as most projects are saved in git
set nobackup
set nowb

" unnecessary on modern systems
set noswapfile
"}}}2
" Window splitting {{{

" more intuitive window positioning
set splitbelow
set splitright

"}}}2
"}}}
" Navigation {{{
" ------------------------------------------------------------------------------

set incsearch          " increamental searching
set hlsearch           " highlight candidates in a search

 " graphical menu of all matches of autocomplete
 " first tab  - completes as much as possible
 " second tab - provide a list
 " third tab  - cycle through completion options
set wildmode=longest,list,full

set foldenable         " enable folding
set foldlevelstart=10  " most folds open on start
set foldnestmax=10     " nest only 10 layers of folds
set foldmethod=indent  " fold only based on indent

let mapleader=","      " set mapleader to comma

" reload vim config without restarting
map <leader>s :source ~/.vimrc<CR>

" space opens and closes folds
nnoremap <space> za
" navigating between split buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Git {{{
" This uses tpope's git-fugitive. Not as great as magit in Emacs,
" but good enough.

nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>

"}}}2

"}}}
" UI {{{
" ------------------------------------------------------------------------------
" Settings about the interface and aesthetics of vim.

set ruler                             " show cursor position
set title                             " display file name in title bar
set textwidth=80                      " set the wrap guide
set colorcolumn=+1                    " show the wrap guide
set cursorline                        " highlight the current line
set laststatus=2                      " set up status line
set showmatch                         " highlight matching delimiter
set showcmd                           " display incomplete commands
set novisualbell                      " no blinking cursor
set cmdheight=2                       " set command window height to 2 lines
set noshowmode

syntax enable
syntax on

let g:gitgutter_sign_column_always=1  " constant git gutter; no resizing

" Toggle line numbers {{{ ------------------------------------------------------
" Toggle through different line number displays.
" This includes static display of numbers as well as relative number display.
" Relative number display is useful for navigating a file with vim commands.

nnoremap <silent><Leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if !&number && !&relativenumber
      set number
      set norelativenumber
  elseif &number && !&relativenumber
      set nonumber
      set relativenumber
  elseif !&number && &relativenumber
      set number
      set relativenumber
  elseif &number && &relativenumber
      set nonumber
      set norelativenumber
  endif
endfunction
" }}}2
" Colour scheme {{{ ------------------------------------------------------------

set termguicolors
set t_Co=256
set background=dark
colorscheme PaperColor

"}}}2
" Airline settings {{{

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='flatlandia'
let g:airline_powerline_fonts=1             " Populate the powerline symbols
let g:Powerline_symbols = 'fancy'
let g:airline#extensions#branch#enabled = 1
"}}}

let g:rainbow_active=1  " Use rainbow delimiters

" }}}
" Editing {{{
" ------------------------------------------------------------------------------
set ignorecase     " ignore letter case when searching
set smartcase      " if capitals, become case sensitive
set autoindent     " on new lines, match indent of previous line
set copyindent     " keep the indent level when copying
set softtabstop=4  " how many columns tab uses in insert mode
set expandtab      " tab in insert mode produces the set number of spaces
set shiftwidth=4   " how many columns are indented with reindent operators
set cindent        " smart indenting for c-like code

" Creat dir if it does not exist {{{

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" }}}2
" Syntastic error checking {{{

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" }}}2

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"}}}
" Language settings {{{
" -----------------------------------------------------------------------------
"  Settings for specific languages.

" C/C++ {{{
au BufRead,BufNewFile *.c,*.h set expandtab
au BufRead,BufNewFile *.c,*.h set tabstop=8
au BufRead,BufNewFile *.c,*.h set shiftwidth=8
au BufRead,BufNewFile *.c,*.h set autoindent
au         BufNewFile *.c,*.h set fileformat=unix
au BufRead,BufNewFile *.c,*.h let b:comment_leader = '/* '

" clang autocomplete for C/C++
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-3.8.so'

" }}}2
" LaTeX {{{

" view for latex previewing
let g:livepreview_previewer = 'evince'

 " } }}2
" Python {{{
"let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
" }}}2
" R {{{

" }}}2


" }}}

" vim:foldmethod=marker:foldlevel=0
