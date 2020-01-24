"" My vimrc, partly adapted from https://gist.github.com/simonista/8703722


" Don't try to be vi compatible
set nocompatible

" Automatically install vim plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MVIMRC
endif

" Helps some plugins load correctly, turned on below
filetype off

"" Plugins (managed by vim plug)
call plug#begin('~/.vim/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" GitGutter
Plug 'airblade/vim-gitgutter'

" Minimalist theme
Plug 'dikiaap/minimalist'

" Go utilities
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Language packages
Plug 'sheerun/vim-polyglot'

" Syntastic
Plug 'vim-syntastic/syntastic'

call plug#end()
"" End Plugins

"" General Settings
" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader - ","

" Securiy
" Set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2 " spaces per tab when expandtab
set shiftwidth=2 " actual spaces per tab
set softtabstop=2 " spaces per tab for <BACK>, etc
set expandtab " change tab to spaces
set noshiftround " just keep this

"" File specific whitespace rules
au FileType python,java,c,cpp,erlang,cuda setlocal ts=4 sw=4 sts=4

au FileType make,go setlocal noexpandtab sw=4 sts=0 ts=4

au Filetype ocaml nnoremap <buffer> <localLeader>l :MerlinLocate<CR>
"" End file specific whitespace rules

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:>
" runtime! macros/matchit.vim

" Enable mouse support
set mouse=a

" Move up/down editor lines
" nnoremap j gj
" nnoremap k gk

" Allow hidden buffers
" set hidden

" Rendering
" set ttyfast

" Update time (affects gitgutter)
set updatetime=100

" Status bar
set laststatus=2

" Last line
set noshowmode
set noshowcmd

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

"" Plugin configs and more

" For powerline python compatibility
let g:powerline_pycmd="py3"

" Airline plugin configuration
let g:airline_powerline_fonts=1
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1

" Theme configuration
set t_Co=256
colorscheme gruvbox

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Polygot and vim-go conflict:
let g:polygot_disabled = ['go']

" vim-go additions
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

