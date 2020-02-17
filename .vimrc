filetype plugin indent on

" Settings

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
" set expandtab
" set term=xterm  " commented for nvim error...`

" searching
" highlight search results
set hlsearch
" search incrementally as I type
set incsearch

" show absolute line number on the current line 
" and relative line numbers elsewhere
" set number relativenumber

" enable autocomplete
set omnifunc=syntaxcomplete#Complete


" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" enable code folding based on indenting, but not when opening a file
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" disable modelines
set nomodeline

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" go support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Initialize plugin system
call plug#end()


let g:go_version_warning = 0
