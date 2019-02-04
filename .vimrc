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

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Language packages
Plug 'sheerun/vim-polyglot'

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
au FileType python,java,c,cpp setlocal ts=4 sw=4 sts=4

au FileType make setlocal noexpandtab sw=4 sts=0 ts=4
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

" Searching
" nnoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" map <leader><space> :let @/=''<cr> " clear search

" Formatting
" map <leader>q gqip

" Color scheme (terminal)
" set t_Co=256
" set background=dark
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors and uncomment:
" colorscheme solarized

"" Plugin configs and more

" For powerline python compatibility
let g:powerline_pycmd="py3"

" Airline plugin configuration
let g:airline_powerline_fonts=1
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1

" Minimalist theme configuration
set t_Co=256
" colorscheme minimalist
colorscheme gruvbox

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

