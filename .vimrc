set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.fzf
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'pearofducks/ansible-vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-python/python-syntax'
Plug 'tpope/vim-fugitive'
"Plug 'jaxbot/semantic-highlight.vim'
call plug#end()

filetype plugin indent on    " required

set number
syntax on

" setup theme
let g:onedark_termcolors=256
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
colorscheme onedark
set background=dark
" fix theme backgroud color
highlight Normal ctermbg=black

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" unvisible characters
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
set mouse=a

" .robot syntax
au BufNewFile,BufRead *.robot setlocal filetype=robot

" .py folding indent
au BufNewFile,BufRead *.py setlocal foldmethod=indent
let g:python_highlight_all = 1

" .yaml syntax
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/syntax/yaml.vim
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible

" one click NerdTree
let g:NERDTreeMouseMode = 3

au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
