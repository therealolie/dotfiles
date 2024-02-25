set nocompatible
set backspace=indent,eol,start
set history=50
set ruler
set number
set relativenumber
highlight Folded ctermfg=12
highlight Folded ctermbg=0
highlight Comment ctermfg=12
highlight Pmenu ctermbg=8
set tabstop=8
set shiftwidth=8
set modelineexpr
set foldmethod=syntax
set foldnestmax=1
set noexpandtab

let mapleader = "\<C-e>"
nnoremap <leader>e :vsplit $MYVIMRC<cr>
nnoremap <leader>s :w<cr>:source $MYVIMRC<cr>
nnoremap <leader>f $%A //}}}<esc>6h%A //{{{<esc>$za

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
