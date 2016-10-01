set nocompatible

"===============================================
" vim-plug
"===============================================
call plug#begin('~/.vim/plugins')
"
Plug 'romainl/flattened'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'marcweber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate' | Plug 'sro5h/snippets'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/filestyle'
Plug 'justmao945/vim-clang'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mhinz/vim-startify'
Plug 'takac/vim-hardtime'
"
call plug#end()

"===============================================
" plugin settings
"===============================================
"
" airline
"-----------------------------------------------
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_min_count=1
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
"
" nerdtree
"-----------------------------------------------
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_console_startup=0
let g:NERDTreeWinSize=30
let g:NERDTreeShowHidden=1
"
" ctrlp
"-----------------------------------------------
let g:ctrlp_show_hidden=1
let g:ctrlp_root_markers=['.git', '.vimprj', 'premake5.lua']
"
" vim-oblique
"-----------------------------------------------
let g:oblique#incsearch_highlight_all=1
"
" vim clang
"-----------------------------------------------
let g:clang_auto=0
let g:clang_cpp_options='-std=c++14'
let g:clang_cpp_completeopt='longest,menuone'
let g:clang_diagsopt = 'rightbelow:6'
let g:clang_check_syntax_auto=1
"
" hardtime
"-----------------------------------------------
let g:hardtime_default_on=0
let g:hardtime_ignore_buffer_patterns = [ "NERD.*"  ]
let g:hardtime_ignore_quickfix = 1

"===============================================
" vim settings
"===============================================
set t_Co=16
set background=dark
set encoding=utf8 " set file encoding to utf-8
set noautochdir " prevent vim from changing the pwd
set nobackup " disable auto backup
set noswapfile " disable swap files
set updatetime=250 " lower update time
" editor
colorscheme flattened_dark
set number
set relativenumber
set ruler " show line number & column
set showcmd
set nowrap
let mapleader=" "
set tw=1000 " disable highlighting of long lines
set scrolloff=1
set cursorline " highlight the cursorline
set backspace=indent,eol,start " proper deletion with backspace
set tabstop=4
set shiftwidth=4
set expandtab " use spaces instead of tabs
set hlsearch " highlight search results
set incsearch " enable incremental search
set splitbelow
set splitright
" zsh esc delay fix
set timeoutlen=1000 ttimeoutlen=0
set lazyredraw

"===============================================
" gui settings
"===============================================
if has("gui_running")
    set guioptions-=m " disable menu in vim gui
    set guioptions-=T " disable toolbar in vim gui
    set guioptions-=L " disable left scrollbar
    set guioptions-=r " disable right scrollbar
    "set lines =50 columns=120 " initial size of vim (gui)
    set lines=999 columns=999 " maximize gvim window
"else
    " this is console Vim.
    "if exists("+lines")
        "set lines=50
    "endif
    "if exists("+columns")
        "set columns=100
    "endif
endif

"===============================================
" user defined functions
"===============================================

"===============================================
" user defined mappings & operators & commands
"===============================================
"
" mappings
"-----------------------------------------------
" disable arrow keys in insert mode
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
"nnoremap - ddp
" autocomplete mapping
inoremap <C-c> <C-x><C-u>
"nnoremap <C-r> :call NERDTreeRefresh()<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
" leader mappings
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
" add & remove a semicolon to the end of the line if nonexistant
nnoremap <expr> <leader>s getline('.') =~ ';$' ? '' : "mqA;\<esc>`q"
nnoremap <expr> <leader>S getline('.') =~ ';$' ? "mq$x\<esc>`q" : ''
nnoremap <leader>u viwU
nnoremap <leader>\ :rightbelow vsplit<cr>
nnoremap <leader>\| :rightbelow split<cr>
nnoremap <leader>y :call emmet#expandAbbr(3,"")<cr>
nnoremap <silent> <leader><CR> :noh<CR>
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
nnoremap <leader>f :FileStyleFix<esc>
" more comfortable split navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
"
" operators
"-----------------------------------------------
" in next & in last (has problems with empties)
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
onoremap in< :<c-u>normal! f<vi<<cr>
onoremap il< :<c-u>normal! F>vi<<cr>
"
" commands
"-----------------------------------------------
augroup commands
    autocmd!
    au VimEnter * echo "d[ o_0 ]b"
    "au VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
    "au InsertEnter,InsertLeave * set cursorline!
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    "au BufRead *.vimprj call LoadProject() Make project plugin that sources loaded project files
augroup END

"===============================================
" vim ignore settings
"==============================================-
set wildignore+=*\\bin\\*,*\\build\\*,Makefile
