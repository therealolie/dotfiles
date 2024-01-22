set nocompatible
set backspace=indent,eol,start
set history=50
set ruler
set number
set relativenumber
" set foldmethod=syntax
highlight Folded ctermfg=12
highlight Folded ctermbg=0
highlight Comment ctermfg=12
highlight Pmenu ctermbg=8
set tabstop=4
set shiftwidth=4

let mapleader = "\<C-e>"
nnoremap <leader>e :vsplit $MYVIMRC<cr>
nnoremap <leader>s :w<cr>:source $MYVIMRC<cr>
nnoremap <leader>f $%A //}}}<esc>6h%A //{{{<esc>$za


