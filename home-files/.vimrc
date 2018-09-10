
if $TERM == "xterm-256color"
  set t_Co=256
endif

set nu
syntax on
set tabstop=2

"color darcula
"color molokai
color monokai
color iceberg

set shiftwidth=2
set expandtab

set smarttab
set smartindent

set incsearch
set hlsearch

set nowrap

execute pathogen#infect()
filetype plugin indent on


set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

"set autowriteall=on
"set autowrite


"map <F5> :w \|!cake rebuild<CR> 
""imap <F5> <ESC>:w \|!cake rebuild<CR>

"switching buffers. ! to switch beween unsaved buffers
nmap <C-N> :bn!<CR>
"nmap <C-P> :bp!<CR>i

" folding
set foldmethod=manual
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

"0 if you want to enable it later via :RainbowToggle"
let g:rainbow_active = 0 


let g:slime_target = "tmux"

"set mouse support on ubuntu
set mouse=a

"allows swith between unsaved buffers 
set hidden


set ignorecase

"GUI
set guifont=DejaVu\ Sans\ Mono\ 16
set guioptions-=T


"Omnicompletion. http://vim.wikia.com/wiki/Omni_completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete


"vim airline tab line
let g:airline#extensions#tabline#enabled = 1


"CtrlP install
set runtimepath^=~/.vim/bundle/ctrlp.vim



"Deoplete
"let g:deoplete#enable_at_startup = 1

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'chr4/nginx.vim'
Plug 'vim-airline/vim-airline'
Plug 'jlanzarotta/bufexplorer'
"Plug 'thiagoalessio/rainbow_levels.vim'
"Plug 'amdt/vim-niji'

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif


call plug#end()
