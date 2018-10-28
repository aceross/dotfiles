
set nocompatible              " required
filetype off                  " required
set hidden
set showtabline=0

call plug#begin('~/.vim/plugged')

"-------------------=== Code/Project navigation ===-------------
Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'majutsushi/tagbar'                  " Class/module browser
Plug 'vim-ctrlspace/vim-ctrlspace'        " Tabs/Buffers/Fuzzy/Workspaces/Bookmarks
Plug 'mileszs/ack.vim'                    " Ag/Grep
Plug 'vim-airline/vim-airline'             " Lean & mean status/tabline for vim
Plug 'vim-airline/vim-airline-themes'     " Themes for airline
Plug 'fisadev/FixedTaskList.vim'          " Pending tasks list
Plug 'MattesGroeger/vim-bookmarks'        " Bookmarks
Plug 'thaerkh/vim-indentguides'           " Visual representation of indents
Plug 'neomake/neomake'                    " Asynchronous Linting and Make Framework
Plug 'Shougo/deoplete.nvim'               " Asynchronous Completion
Plug 'roxma/nvim-yarp'                    " Deoplete Dependency #1
Plug 'roxma/vim-hug-neovim-rpc'           " Deoplete Dependency #2
Plug 'airblade/vim-gitgutter'             " Show git changes in the fringe

"-------------------=== Other ===-------------------------------
Plug 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
Plug 'flazz/vim-colorschemes'             " Colorschemes
Plug 'vimwiki/vimwiki'                    " Personal Wiki
Plug 'tpope/vim-fugitive'                 " Git Operations
Plug 'kien/rainbow_parentheses.vim'       " Rainbow Parentheses
Plug 'chriskempson/base16-vim'            " Base 16 colors
Plug 'ryanoasis/vim-devicons'             " Dev Icons

"-------------------=== Snippets support ===--------------------
Plug 'garbas/vim-snipmate'                " Snippets manager
Plug 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
Plug 'tomtom/tlib_vim'                    " dependencies #2
Plug 'honza/vim-snippets'                 " snippets repo

"-------------------=== Languages support ===-------------------
Plug 'scrooloose/nerdcommenter'           " Easy code documentation
Plug 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
Plug 'w0rp/ale'

"-------------------=== Python  ===-----------------------------
Plug 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
Plug 'hynek/vim-python-pep8-indent'
Plug 'mitsuhiko/vim-python-combined'
Plug 'mitsuhiko/vim-jinja'
Plug 'jmcantrell/vim-virtualenv'

call plug#end()         " required

filetype on
filetype plugin on
filetype plugin indent on

"===============================================================================
" General settings
"===============================================================================
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

" no need for backups as most projects are saved in git
set nobackup
set nowb
set noswapfile

" colorscheme and encodings
set encoding=utf-8
set termguicolors
let base16colorspace=256
set t_Co=256
"set guifont=mononoki\ Nerd\ Font\ 18
" set vim colorscheme
colorscheme base16-chalk
let g:airline_powerline_fonts = 0
" enable syntax highlighting
syntax enable

set pyxversion=0
let g:loaded_python_provider = 1
set shell=/bin/bash

" graphical menu of all matches of autocomplete
" first tab  - completes as much as possible
" second tab - provide a list
" third tab  - cycle through completion options
set wildmode=longest,list,full

set ruler
" terminal acceleration
set ttyfast
" 4 whitespaces for tabs visual presentation
set tabstop=4
" shift lines by 4 spaces
set shiftwidth=4                        
" set tabs for a shifttabs logic
set smarttab                            
" expand tabs into spaces
set expandtab                           
" indent when moving to the next line while writing code
set autoindent 
" shows line under the cursor's line                         
set cursorline
" shows matching part of bracket pairs (), [], {}                              
set showmatch                               
set novisualbell
set noshowmode
set showbreak=←
" more intuitive window positioning
set splitbelow
set splitright


" utf-8 by default
set enc=utf-8	                            
" backspace removes all (indents, EOLs, start) What is start?
set backspace=2
" use system clipboard
set clipboard=unnamed                       
" enable usage of additional .vimrc files from working directory
set exrc
" prohibit .vimrc files to execute shell, create files, etc...                                    
set secure

"===============================================================================
" Keybindings
"===============================================================================
" set mapleader to comma 
let mapleader=","
" reload vim config without restarting
map <leader>s :source ~/.vimrc<CR>

"===============================================================================
" Updates
"===============================================================================                                    
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pi :PlugInstall<CR>

"===============================================================================
" Git/Project Management
"===============================================================================                                    
" Git management with tpope's git-fugitive
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>

"===============================================================================
" Tabs / Buffers settings
"===============================================================================
tab sball
set switchbuf=useopen
set laststatus=2

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

nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"===============================================================================
" Neomake Settings 
"===============================================================================
call neomake#configure#automake('w')
let g:neomake_open_list = 2

"===============================================================================
"" Deoplete  Settings 
"===============================================================================
" Use deoplete.
let g:deoplete#enable_at_startup = 1

"===============================================================================
" Fringe settings
"===============================================================================
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

" constant git gutter; no resizing
set signcolumn=yes                    

"===============================================================================
" Search settings
"===============================================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

"=============================================================================
" AirLine settings
"=============================================================================
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap " :NERDTreeToggle<CR>

"=====================================================
"" NERDComment Settings 
"=====================================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"=====================================================
"" DevIcon Settings
"=====================================================
" loading the plugin 
let g:webdevicons_enable = 0

" adding the flags to NERDTree 
let g:webdevicons_enable_nerdtree = 1

" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1

" use double-width(1) or single-width(0) glyphs 
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags 
let g:webdevicons_conceal_nerdtree_brackets = 0

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1 

" change the default character when no match found
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

" set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
" disabled by default with no value
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable pattern matching glyphs on folder/directory (enabled by default with 1)
let g:DevIconsEnableFolderPatternMatching = 1

" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 0


"=====================================================
"" SnipMate settings
"=====================================================
let g:snippets_dir='~/.vim/vim-snippets/snippets'

"=====================================================
"" Rainbow Parentheses Autoload 
"=====================================================
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"=====================================================
"" Indent Guides Settings 
"=====================================================
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
"=====================================================
"" Python settings
"=====================================================

" python executables for different plugins
let g:pymode_python='python'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

let g:ale_sign_column_always = 0
let g:ale_emit_conflict_warnings = 0                                                                         
let g:airline#extensions#ale#enabled = 1
let g:pymode_rope_lookup_project = 0
let g:airline#extensions#tabline#enabled = 1

imap <F5> <Esc>:w<CR>:!clear;python %<CR>

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>
