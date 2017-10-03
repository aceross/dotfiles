".vimrc
" 2017 (c) Aaron Ceross
" ------------------------------------------------------------------------------

" Initialisation {{{
" ------------------------------------------------------------------------------

set nocompatible
filetype off
let g:skip_defaults_vim = 1

" set the runtime path to include Vundle and initialise
set runtimepath+=~/.vim/bundle/Vundle.vim

" Plugins {{{
" -----------------------------------------------------------------------------
" This set up uses Vundle. To start, the Vundle repository needs to be
" cloned into ~/.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'             " Package management
Plugin 'nelstrom/vim-visual-star-search'  " Start a * or # search from a
                                          " visual block
Plugin 'tpope/vim-fugitive'               " Git management
Plugin 'airblade/vim-gitgutter'           " Show git changes
Plugin 'jiangmiao/auto-pairs'             " Auto-close delimiter pairs
Plugin 'luochen1990/rainbow'              " Rainbow delimiters
Plugin 'vim-syntastic/syntastic'          " Syntax checker
Plugin 'Shougo/neocomplete'               " Autocompletion
Plugin 'Shougo/neosnippet'                " Code snippets
Plugin 'Shougo/neosnippet-snippets'       " Populate code snippets
Plugin 'scrooloose/nerdtree'              " file tree explorer
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'godlygeek/tabular'

" UI packages
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" colour schemes
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'morhetz/gruvbox'
Plugin 'dracula/vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'jacoborus/tender.vim'
Plugin 'chase/focuspoint-vim'
Plugin 'JarrodCTaylor/spartan'

 " language-specific packages
Plugin 'plasticboy/vim-markdown'
Plugin 'lervag/vimtex'                    " Support for Tex documents
Plugin 'jalvesaq/Nvim-R'                  " R programming support
Plugin 'vim-pandoc/vim-pandoc'
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
" ------------------------------------------------------------------------------

" keep 500 lines of command line history
set history=500

" no need for backups as most projects are saved in git
set nobackup
set nowb

" unnecessary on modern systems
set noswapfile

"}}}2
" Window splitting {{{
" ------------------------------------------------------------------------------
" more intuitive window positioning

set splitbelow
set splitright

"}}}2
"}}}
" Navigation {{{
" ------------------------------------------------------------------------------

set backspace=2        " make backspace behave normally

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

" Plugin management {{{
" ------------------------------------------------------------------------------
"
nnoremap <Leader>pu :PluginUpdate<CR>
nnoremap <Leader>pi :PluginInstall<CR>

" }}}2
" CtrlP {{{
" ------------------------------------------------------------------------------
"  Fuzzy searching in a project folder.

map <leader>p :CtrlP()<CR>
noremap <leader>b<space> :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = '\v[\/]dist$'

" }}}2
" NERDTree and buffer shorcuts {{{
" ------------------------------------------------------------------------------
" Management of buffers and file tree.

" show/hide NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" navigating between split buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" next buffer
nmap <leader>p :bp<CR>
" previous buffer
nmap <leader>n :bn<CR>
" close buffer
nmap <leader>q :bd<CR>

" }}}2
" Git {{{
" ------------------------------------------------------------------------------
" This uses tpope's git-fugitive. Not as great as magit in Emacs,
" but good enough.

nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>

"}}}2
"}}}
" User Interface {{{
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
set noshowmode

set showbreak=←

syntax enable
syntax on

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

colorscheme jellybeans

" Airline settings {{{
" ------------------------------------------------------------------------------

" }}}

" Misc {{{
" ------------------------------------------------------------------------------
" Other settings that don't quite fall into the other categories.

let g:rainbow_active=1                " use rainbow delimiters
set signcolumn=yes                    " constant git gutter; no resizing

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

" format text to stay within the line wrap
"set formatoptions+=a

" Commenting {{{
" ------------------------------------------------------------------------------
" Useful settings for commenting programmes with NERD commenter
" <https://github.com/scrooloose/nerdcommenter>

" add a space after delimiter
let g:NERDSpaceDelims = 1

" enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"  }}}2
" Syntastic error checking {{{
" ------------------------------------------------------------------------------

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Auto-completion {{{
" ------------------------------------------------------------------------------

" disable AutoComplPop
let g:acp_enableAtStartup = 0
" use neocomplete
let g:neocomplete#enable_at_startup = 1
" use smartcase
let g:neocomplete#enable_smart_case = 1
" set minimum syntax keyword length
let g:neocomplete#sources#syntax#min_keyword_length = 3

" define dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
\     'default' : '',
\     'vimshell' : $HOME.'/.vimshell_hist',
\     'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

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

"}}}2
" Snippets {{{
" ------------------------------------------------------------------------------
" Control how snippets operate within vim.

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

" }}}2
" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
"}}}
" Language settings {{{
" ------------------------------------------------------------------------------
"  Settings for specific languages.

" C/C++ {{{
" ------------------------------------------------------------------------------

au BufRead,BufNewFile *.c,*.h set expandtab
au BufRead,BufNewFile *.c,*.h set tabstop=8
au BufRead,BufNewFile *.c,*.h set shiftwidth=8
au BufRead,BufNewFile *.c,*.h set autoindent
au         BufNewFile *.c,*.h set fileformat=unix
au BufRead,BufNewFile *.c,*.h let b:comment_leader = '/* '

" clang autocomplete for C/C++
let g:clang_library_path='/usr/lib/llvm-4.0/lib/'
"let g:clang_library_path='/usr/lib64/libclang.so'

" }}}2

" LaTeX {{{
" ------------------------------------------------------------------------------

let g:tex_flavor = "latex"

" view for latex previewing
let g:livepreview_previewer = 'evince'

 " } }}2
"
"R {{{
" ------------------------------------------------------------------------------
" make R interact within vim
"
" For this to work, open tmux, and then the R file within vim. Starting an R
" session will open the REPL in a vertical split pane. Otherwise, the R session
" will open in a separate terminal.

" start the R REPL in a vertical split
let R_tmux_split = 1
let vimrplugin_vsplit = 1

let R_start_libs = "base,stats,graphics,grDevices,utils,methods"

" for knitr
let vimplugin_pdfviewer = "evince"
let R_pdfviewer = "evince"

" open the PDF upon compilation
let R_openpdf = 1

let vimrplugin_latexmk = 1
autocmd BufRead,BufNewFile *.Rnw set ft=rnoweb
autocmd BufRead,BufNewFile *.rnw set ft=rnoweb

" highlight chunk header as R
let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1

" the pandoc syntax concealment is confusing
let pandoc#syntax#conceal#use = 0

" }}}2
" Python {{{
" ------------------------------------------------------------------------------

au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

" further highlighting in Python programs
let python_highlight_all=1

" }}}2
" Markdown {{{
" ------------------------------------------------------------------------------

" set the spell check in markdown files
au BufRead *.md setlocal spell spelllang=en_gb
au BufRead *.markdown setlocal spell spelllang=en_gb

"}}}2
" }}}

" vim:foldmethod=marker:foldlevel=0
