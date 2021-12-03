call plug#begin()
        Plug 'tpope/vim-rhubarb'
        Plug 'tpope/vim-fugitive'
        Plug 'skywind3000/asyncrun.vim'
        Plug 'sheerun/vim-polyglot'
        Plug 'neovim/nvim-lspconfig'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'leafOfTree/vim-svelte-plugin'

        Plug 'lewis6991/gitsigns.nvim'
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'ntpeters/vim-better-whitespace'
        Plug 'editorconfig/editorconfig-vim'

        Plug 'lifepillar/vim-solarized8'
        Plug 'scrooloose/nerdtree'
        Plug 'Xuyuanp/nerdtree-git-plugin'

        "patched fonts at https://www.nerdfonts.com
        Plug 'ryanoasis/vim-devicons'
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "required by devicons when used with nerdtree
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'edkolev/tmuxline.vim'

        Plug 'nvim-lua/popup.nvim' "required by telescope
        Plug 'nvim-lua/plenary.nvim' "required by telescope
        Plug 'nvim-telescope/telescope.nvim'
call plug#end()

set termguicolors
set mouse=a
"set expandtab
"set autoindent
set relativenumber
set cursorline
set ff=unix

"filetype plugin indent on

let mapleader = "\<Space>"

nnoremap <C-e> <Cmd>NERDTreeToggle<CR>
nnoremap <C-p> <Cmd>Telescope find_files<CR>
nnoremap <C-g> <Cmd>Telescope live_grep<CR>

"get over using this lol
nnoremap <leader>gg <Cmd>Telescope live_grep<CR>

nnoremap <C-`> <Cmd>bo 20new term://zsh<CR><Cmd>startinsert<CR>
tnoremap <C-`> <Cmd>close!<CR>

nnoremap <leader>gs <Cmd>Git<CR>
nnoremap <leader>ga <Cmd>Git add @%<CR>
nnoremap <leader>gA <Cmd>Git add .<CR>
nnoremap <leader>gf <Cmd>Git fetch<CR>
nnoremap <leader>gy <Cmd>Git push<CR>
nnoremap <leader>gb <Cmd>GBrowse<CR>
nnoremap <leader>gd <Cmd>Gvdiffsplit<CR>

set background=dark
colorscheme solarized8

let g:airline_powerline_fonts=1
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

autocmd BufWritePre *.tf lua vim.lsp.buf.formatting()

":so $MYVIMRC
":e $MYVIMRC

lua <<EOF
require('gitsigns').setup()
require'lspconfig'.rls.setup{}
require'lspconfig'.terraformls.setup{}
EOF

