set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
"Plugin 'kien/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'lilydjwg/colorizer'
call vundle#end()            " required
filetype plugin indent on    " required

set number
syntax enable

let g:airline_powerline_fonts = 1
" let g:airline_theme='tomorrow'

filetype plugin indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


nmap <leader>i :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" folding with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap <silent> <leader>o :Files <CR>
nnoremap <silent> <leader>l :Lines <CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

" set insert mode cursor to |
let &t_SI .= "\033[6 q"
let &t_EI .= "\<Esc>[2 q"

" timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays
set timeoutlen=1000 ttimeoutlen=0
