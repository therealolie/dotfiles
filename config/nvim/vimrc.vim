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

nnoremap <c-e>e :vsplit $MYVIMRC<cr>
nnoremap <c-e>s :w<cr>:source $MYVIMRC<cr>
" nnoremap <c-e>f A //{<c-v>{{<esc>Bhh% <esc>Bhh%A //}<c-v>}}

nnoremap <c-e>f $%A //}}}<esc>6h%A //{{{<esc>$za


