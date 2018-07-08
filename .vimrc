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

" vsplit puts the new buffer on the right of the current buffer
set splitright

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Plugin List:
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
"Plug 'takac/vim-hardtime'
"vim-markdown:  tabular is required
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'

Plug 'StanAngeloff/php.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'roxma/ncm-phpactor'
Plug 'kristijanhusak/deoplete-phpactor'

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

call plug#end()



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

" Autorefresh on buffer write
" autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp: Fuzzy file, buffer, mru, tag, etc finder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>f :CtrlPBuffer<cr>
"map <leader>tb :CtrlPBufTag<cr>
"map <leader>ta :CtrlPTag<cr>
" Jump to definition: <C->w means “insert word under cursor”
"map <silent> <leader>g :CtrlPTag<cr><C-\>w
" Go back (it opens previous buffer)
map <silent> <leader>b :e#<cr>
let g:ctrlp_match_current_file = 1
let g:ctrlp_lazy_update = 1
let g:ctrlp_extensions = ['tag', 'buffertag']
"let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"let g:ctrlp_use_caching = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline statusbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'relativepath', 'modified'] ],
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
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'


" ******************************************************************************
" => vim-jsx
" ******************************************************************************

" By default, JSX syntax highlighting and indenting will be enabled only for
" files with the .jsx extension. If you would like JSX in .js files, add
let g:jsx_ext_required = 0

" ******************************************************************************
" => vim-test
" ******************************************************************************
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let test#php#phpunit#options = {
  \ 'nearest': '--config phpunit.xml',
  \ 'file':    '--config phpunit.xml',
  \ 'suite':    '--config phpunit.xml',
  \}

" ******************************************************************************
" => vim-markdown
" ******************************************************************************
" Disable folding
let g:vim_markdown_folding_disabled = 1

" vim-instant-markdown
" [sudo] npm -g install instant-markdown-d
" If you're on Linux, ensure the following packages are installed:
" xdg-utils
" curl

" ******************************************************************************
" => deoplete
" ******************************************************************************

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
let g:neosnippet#enable_completed_snippet = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ******************************************************************************
" => neosnippet
" ******************************************************************************
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"C-k to select-and-expand a snippet from the deoplete popup
" (Use C-n and C-p to select it). C-k can also be used to jump to the next field in the snippet.
" Tab to select the next field to fill in the snippet.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
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

" ******************************************************************************
" => phpactor
" ******************************************************************************
autocmd FileType php setlocal omnifunc=phpactor#Complete

nmap <Leader>pu :call phpactor#UseAdd()<CR>
nmap <Leader>pmm :call phpactor#ContextMenu()<CR>
nmap <Leader>pnn :call phpactor#Navigate()<CR>
nmap <Leader>po :call phpactor#GotoDefinition()<CR>
nmap <Leader>ptt :call phpactor#Transform()<CR>
nmap <Leader>pcc :call phpactor#ClassNew()<CR>
nmap <silent><Leader>pee :call phpactor#ExtractExpression(v:false)<CR>
vmap <silent><Leader>pee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
vmap <silent><Leader>pem :<C-U>call phpactor#ExtractMethod()<CR>

let g:phpactorOmniError = v:true
