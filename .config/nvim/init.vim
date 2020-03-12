set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


""""""""""""""""""""""""""""""
" => plugged
""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" markdown preview plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'

" ultisnips is a snippets engine
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()


""""""""""""""""""""""""""""""
" => ale
""""""""""""""""""""""""""""""
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\       '*': [
\       ],
\       'python': [
\           'remove_trailing_lines',
\           'trim_whitespace',
\           'black',
\       ],
\       'go': ['gofmt'],
\   }

" \           'add_blank_lines_for_python_control_statements',

let g:ale_linters = {
\       'python': [
\           'flake8',
\       ],
\       'go': ['golint'],
\   }

highlight ALEError ctermfg=00
highlight ALEError ctermbg=01

""""""""""""""""""""""""""""""
" => vim-go
""""""""""""""""""""""""""""""
let g:go_version_warning = 0

""""""""""""""""""""""""""""""
" => ultisnips
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<shift-tab>"

""""""""""""""""""""""""""""""
" => key maps
""""""""""""""""""""""""""""""

" map keys for navigating Ale highlights
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" map keys for vim-go
" automatically defined:
" ]] goes to next function declaration
" [[ goes to previous function declaration
nmap <silent> gr <Plug>(go-rename)
nmap <silent> ga <Plug>(go-alternate-edit)
nmap <silent> gi <Plug>(go-iferr)

""""""""""""""""""""""""""""""
" => settings
""""""""""""""""""""""""""""""
" show line number and relative line numbers
set number
set relativenumber
" but not for text files
autocmd Filetype text setlocal nonumber norelativenumber

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4

" searching
" highlight search results
set hlsearch
" search incrementally as I type
set incsearch

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
