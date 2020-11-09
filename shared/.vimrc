set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'gcmt/taboo.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'nvie/vim-flake8'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'mileszs/ack.vim'

" Plugin 'lervag/vimtex'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"################################## VIMRC CONFIG BELOW ########

" some generic config
set nomodeline

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set tabstop=4

" set tab button to insert 4 spaces
set softtabstop=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" smartcase for case insensitive matching
set smartcase

" avoid ycm spawning a window with suggestions
set completeopt-=preview

colorscheme koehler

" enable tab info saving into current session (for Taboo names)
set sessionoptions+=tabpages,globals

" summon nerdtree when opening vim
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"python with virtualenv support
if has('python')
    command! -nargs=1 Python python <args>
elseif has('python3')
    command! -nargs=1 Python python3 <args>
else
    echo 'Error: Requires Vim compiled with +python or +python3'
    finish
endif

fu! DetectVirtualenv()
Python << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate).read(), dict(__file__=activate))
EOF
endfun

"=================AUTOCOMMANDS==================

"" Call everytime we open a Markdown file
au BufNewFile,BufFilePre,BufRead *.md 
    \ set filetype=markdown

au BufNewFile *.md 0r ~/Projects/bufix-wiki/docs/template.md

"" Call everytime we open a python file
au BufNewFile,BufRead *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ expandtab
    \ fileformat=unix    
    \ foldmethod=indent
    \ foldlevel=99
    \ | let python_highlight_all = 1
    \ | call DetectVirtualenv()

au BufNewFile,BufRead *.xml set
    \ tabstop=2
    \ softtabstop=2
    \ shitftwidth=2
 
au BufNewFile,BufRead *.html set
    \ tabstop=2
    \ softtabstop=2
    \ shitftwidth=2
    \ shiftwidth=2

au BufNewFile,BufRead *.js set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4

" stuff to avoid make complaining about indentation
autocmd FileType make set
    \ noexpandtab 
    \ shiftwidth=8 
    \ softtabstop=0

" Close Nerdtree on quitting Vim
autocmd VimLeave * tabdo NERDTreeClose

" set tagbar to recognize go tags
au BufNewFile,BufRead *.go
    \let g:tagbar_type_go = {
	    \ 'ctagstype' : 'go',
	    \ 'kinds'     : [
	    	\ 'p:package',
	    	\ 'i:imports:1',
	    	\ 'c:constants',
	    	\ 'v:variables',
	    	\ 't:types',
	    	\ 'n:interfaces',
	    	\ 'w:fields',
	    	\ 'e:embedded',
	    	\ 'm:methods',
	    	\ 'r:constructor',
	    	\ 'f:functions'
	    \ ],
	    \ 'sro' : '.',
	    \ 'kind2scope' : {
	    	\ 't' : 'ctype',
	    	\ 'n' : 'ntype'
	    \ },
	    \ 'scope2kind' : {
	    	\ 'ctype' : 't',
	    	\ 'ntype' : 'n'
	    \ },
	    \ 'ctagsbin'  : 'gotags',
	    \ 'ctagsargs' : '-sort -silent'
        \ }


"============REMAPPING============
"
nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <space> za

set t_Co=256

let g:ycm_python_interpreter_path = '.env/bin/python3'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
