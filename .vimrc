"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> Plugins
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Tabs and spaces
"    -> Helper functions
"    -> Plugins config
"
"    apt-get install vim-gui-common
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove vi compatibility
set nocompatible

" Autoreload .vimrc automatically when it's saved.
au! BufWritePost .vimrc source %

" Number and relative number
set number
set relativenumber

" Cursor line hightlight
set cursorline

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Always show the status line
set laststatus=2
" Everything yanking will go to the unnamed register, and vice versa.
set clipboard=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Help:
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle begin
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin List:
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'altercation/vim-colors-solarized'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'janko-m/vim-test'

call vundle#end()
filetype plugin indent on
" Vundle end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
colorscheme solarized
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs and spaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make VIM remember position in file after reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=28
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>"

" Open NerdTree by default if no file specified
" @see http://stackoverflow.com/questions/1759737/auto-open-nerdtree-in-vim
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp: Fuzzy file, buffer, mru, tag, etc finder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>f :CtrlPBuffer<cr>
"map <leader>tb :CtrlPBufTag<cr>
"map <leader>ta :CtrlPTag<cr>
" Jump to definition: <C->w means “insert word under cursor”
map <silent> <leader>g :CtrlPTag<cr><C-\>w
" Go back (it opens previous buffer)
map <silent> <leader>b :e#<cr>
let g:ctrlp_match_current_file = 1
let g:ctrlp_lazy_update = 1
"let g:ctrlp_extensions = ['tag', 'buffertag']
"let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"let g:ctrlp_use_caching = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline statusbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


" ******************************************************************************
" => Syntastic
" ******************************************************************************

" In active mode, syntastic does automatic checking whenever a buffer is saved or
" initially opened.  When set to "passive" syntastic only checks when the user
" calls |:SyntasticCheck|

" npm install -g eslint_d eslint-config-airbnb babel-eslint eslint-plugin-react
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': ['js', 'php'], }

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'


" ******************************************************************************
" => vim-jsx
" ******************************************************************************

" By default, JSX syntax highlighting and indenting will be enabled only for
" files with the .jsx extension. If you would like JSX in .js files, add
let g:jsx_ext_required = 0


" ******************************************************************************
" => gutentags apt-get install exuberant-ctags
" ******************************************************************************

" Where to store tag files
let g:gutentags_cache_dir = '~/.vim/gutentags'
" Excluding files from generating tags
let g:gutentags_ctags_exclude = [
      \ '*node_modules/',
      \ '*build/',
      \ '*.html', '*.css',
      \ '*.phar', '*.ini', '*.rst', '*.md',
      \ '*vendor/*/test*', '*vendor/*/Test*',
      \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
      \ '*var/cache*', '*var/log*']

" ******************************************************************************
" => vim-test
" ******************************************************************************
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

let test#php#phpunit#options = {
  \ 'nearest': '--config tests/phpunit.xml',
  \ 'file':    '--config tests/phpunit.xml',
  \ 'suite':    '--config tests/phpunit.xml',
  \}
