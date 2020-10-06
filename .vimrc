set cursorcolumn
set cursorline
set hlsearch
set mouse=a
set nocompatible
set number
set relativenumber
set term=xterm
"set termguicolors
set ttymouse=xterm2

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'

Plug 'sheerun/vim-polyglot'

Plug 'ycm-core/YouCompleteMe'

call plug#end()

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

set background=dark
let g:solarized_term_italics = 1
colorscheme solarized8_flat

let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 1

map <C-p> :FZF<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
