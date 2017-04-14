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
Plugin 'jordwalke/flatlandia'             " Flatland mod
Plugin 'ayu-theme/ayu-vim'
Plugin 'vim-syntastic/syntastic'          " Syntax checker
Plugin 'Shougo/neocomplete'               " Autocompletion
Plugin 'Shougo/neosnippet'                " Code snippets
Plugin 'Shougo/neosnippet-snippets'       " Populate code snippets
Plugin 'scrooloose/nerdtree'              " file tree explorer
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bcicen/vim-vice'
Plugin 'chriskempson/base16-vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'Rip-Rip/clang_complete'

        " Language-specific packages
Plugin 'lervag/vimtex'                    " Support for Tex documents
Plugin 'jalvesaq/Nvim-R'                  " R programming support
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'
Plugin 'NLKNguyen/c-syntax.vim'
Plugin 'hdima/python-syntax'
Plugin 'nvie/vim-flake8'

call vundle#end()         " required

filetype plugin indent on " required
 " }}}

" Core Vim {{{
" ------------------------------------------------------------------------------

set history=500        " keep 500 lines of command line history

" no need for backups as most projects are saved in git
set nobackup
set nowb
" unnecessary on modern systems
set noswapfile

" more intuitive window positioning
set splitbelow
set splitright

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
" silver searcher
nnoremap <leader>a :Ag
" navigating between split buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"}}}

" UI {{{
" ------------------------------------------------------------------------------

set ruler                                   " show cursor position
set title                                   " display file name in title bar
set textwidth=80                            " set the wrap guide
set colorcolumn=+1                          " show the wrap guide
set cursorline                              " highlight the current line
set laststatus=2                            " set up status line
set showmatch                               " highlight matching delimiter
set showcmd                                 " display incomplete commands
set noshowmode
set novisualbell                            " no blinking cursor
syntax enable
syntax on

let g:gitgutter_sign_column_always=1        " constant git gutter; no resizing

" Colour scheme
set termguicolors
set t_Co=256
set background=dark
colorscheme PaperColor

" airline settings
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='flatlandia'
let g:airline_powerline_fonts=1             " Populate the powerline symbols

let g:rainbow_active=1                      " Use rainbow delimiters

 " }}}

" Editing {{{
" ------------------------------------------------------------------------------
set ignorecase    " ignore letter case when searching
set smartcase     " if capitals, become case sensitive
set autoindent    " on new lines, match indent of previous line
set copyindent    " keep the indent level when copying
set softtabstop=4
set expandtab
set shiftwidth=4
set cindent       " smart indenting for c-like code

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-3.8.so'

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"}}}

" Language settings {{{
" -----------------------------------------------------------------------------

" clang autocomplete for C/C++
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-4.0.so'

" python
"let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" }}}

" vim:foldmethod=marker:foldlevel=0
