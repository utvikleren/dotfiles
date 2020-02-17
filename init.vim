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
