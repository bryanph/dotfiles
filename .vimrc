set nocompatible
filetype plugin indent on
syntax on
runtime macros/matchit.vim

" General config
set number " Show line numbers
set lazyredraw " Don't redraw screen during macros etc.
set showmatch " highlight matching brackets etc.
set cursorline " Horizontal cursor line set gcr=a:blinkon0 " No cursor blinking
set visualbell " No sound
let mapleader=" " " custom methods prefix
set backup " delete old backup file
set writebackup 
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/

" indentation
set autoindent
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Search
set incsearch " Find next match while typing
set hlsearch " highlight searches
set ignorecase " ignore case by default
set infercase " infer case for autocompletion
set smartcase " ...unless a capital is present, overwrite with \c, \C
nnoremap <F3> :set hlsearch!<CR>

" Substitution
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Commands
command! Writesudo execute ":w !sudo tee % > /dev/null"
" TODO: define indent command and shortcut per language
command! JsonIndent execute ":%!python -m json.tool"
" autocmd BufWritePost * call system("ctags -R") " re-index ctags

" function keys
nnoremap <f5> :!ctags -R --exclude=node_modules --exclude=bower_components --exclude=static_served --exclude=media<CR>

" Expansion
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" navigation
set hidden " automatic hide on buffer exit
set mouse=n
set suffixesadd+=.js,.jsx
" set path+=$PWD/node_modules
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" let g:netrw_liststyle=3 " default tree view
autocmd FileType netrw setl bufhidden=wipe " Fix annoying buffer bug

" Tab completion / history
set wildmenu
set wildmode=longest:list,full
set history=200
set path+=$PWD/** " Recursive :find
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Ctrl-p
" These ignores don't work with Ag
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public\/images\|log\|tmp$\|node_modules',
  \ 'file': '\.exe$\|\.so$\|\.dat|\.pyc$'
  \ }
let g:ctrlp_switch_buffer = 0 " always open a new window
let g:ctrlp_working_path_mode = 0 " change pwd during vim session
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " this breaks ignore

" sideways.vim
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

" TODO: separate file
" Mapleader bindings
nnoremap <leader>e :E<cr>
nnoremap <leader>p "+p
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>a :Ag 

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>
   
" Custom bindings
map Y "+yy
nmap S ys
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
map <C-a> 0
map <C-e> $
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" tab nav  TODO: get  to  work in terminal
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
nnoremap <C-S-Left> :tabm -1<CR>
nnoremap <C-S-Right> :tabm +1<CR>
nnoremap <leader>t :tabnew<CR>
inoremap <C-tab> <Esc>:tabnext<CR>i
inoremap <C-S-tab> <Esc>:tabprevious<CR>i

" GUI options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Vundle packages
set rtp+=~/.vim/bundle/Vundle.vim
filetype off

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'https://github.com/cohama/lexima.vim'
Plugin 'git@github.com:tpope/vim-commentary.git'
Plugin 'https://github.com/kana/vim-textobj-entire'
Plugin 'https://github.com/kana/vim-textobj-user'
Plugin 'https://github.com/tpope/vim-unimpaired'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'https://github.com/tpope/vim-vinegar.git' " netrw extension
Plugin 'https://github.com/flazz/vim-colorschemes.git' " Collection of colorschemes
Plugin 'https://github.com/bronson/vim-visual-star-search.git' " visual mode ssearch
Plugin 'https://github.com/tpope/vim-abolish.git' " Abbrevations, Substitute variants, 
Plugin 'https://github.com/tpope/vim-repeat' " Pluginin mapping repeats
Plugin 'https://github.com/nelstrom/vim-qargs' " adds :Qargs utility, populate arglist from qlist
Plugin 'https://github.com/tpope/vim-fugitive' " git wrapper
Plugin 'git://github.com/airblade/vim-gitgutter.git' " git diff in gutter
Plugin 'https://github.com/kien/ctrlp.vim' " fuzzy finder
Plugin 'https://github.com/bling/vim-airline' " status bar
Plugin 'https://github.com/kana/vim-textobj-lastpat' " textobj for search match
Plugin 'JarrodCTaylor/vim-python-test-runner' " test runner for python and django
Plugin 'https://github.com/sjl/gundo.vim.git' " graphical undo tree view
Plugin 'https://github.com/rking/ag.vim.git' " silversearcher-ag plugin
Plugin 'Valloric/YouCompleteMe' " silversearcher-ag plugin
Plugin 'ervandew/supertab' " For integration with ultisnips
Plugin 'https://github.com/tpope/vim-rsi' " readline key bindings
Plugin 'https://github.com/tpope/vim-sleuth' " automatic indent detection
Plugin 'https://github.com/AndrewRadev/sideways.vim.git' " move arguments left, right

Plugin 'SirVer/ultisnips' 
Plugin 'honza/vim-snippets'

Plugin 'KabbAmine/zeavim.vim' " integration with zeal

Plugin 'https://github.com/majutsushi/tagbar' " display tags in a window

" Syntax
Plugin 'derekwyatt/vim-scala'
Plugin 'kchmck/vim-coffee-script'

" SQL
Plugin 'https://github.com/vim-scripts/SQLUtilities'
Plugin 'https://github.com/vim-scripts/Align.git'

" JS
Plugin 'https://github.com/pangloss/vim-javascript.git' " jsx syntax
" Plugin 'https://github.com/mxw/vim-jsx' " jsx syntax
" Plugin 'jsx/jsx.vim'

Plugin 'https://github.com/bigfish/vim-nodelint' " nodelint js
" Plugin 'https://github.com/marijnh/tern_for_vim' " Tern-based javascript editing
" Plugin 'https://github.com/ramitos/jsctags' " ctags using tern

" Jade
Plugin 'git://github.com/digitaltoad/vim-jade.git' " jade syntax highlighting

call vundle#end()

filetype plugin indent on

