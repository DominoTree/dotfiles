call plug#begin()
        Plug 'tpope/vim-rhubarb'
        Plug 'tpope/vim-fugitive'
        Plug 'skywind3000/asyncrun.vim'

        Plug 'sheerun/vim-polyglot'
        Plug 'pantharshit00/vim-prisma'

        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        Plug 'lewis6991/gitsigns.nvim'
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'ntpeters/vim-better-whitespace'
        Plug 'editorconfig/editorconfig-vim'

        Plug 'neovim/nvim-lspconfig'
        Plug 'jose-elias-alvarez/null-ls.nvim'
        Plug 'MunifTanjim/prettier.nvim'

        Plug 'lifepillar/vim-solarized8'
        Plug 'scrooloose/nerdtree'
        Plug 'Xuyuanp/nerdtree-git-plugin'

        "patched fonts at https://www.nerdfonts.com
        Plug 'ryanoasis/vim-devicons'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'edkolev/tmuxline.vim'

        Plug 'nvim-lua/popup.nvim' "required by telescope
        Plug 'nvim-lua/plenary.nvim' "required by telescope
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'phaazon/hop.nvim'
call plug#end()

let g:coc_global_extensions = [ 'coc-css', 'coc-eslint', 'coc-html', 'coc-jedi', 'coc-json', 'coc-prettier', 'coc-prisma', 'coc-rust-analyzer', 'coc-svelte', '@yaegassy/coc-tailwindcss3', 'coc-toml', 'coc-tsserver', 'coc-yaml' ]
set termguicolors
set mouse=a
"set expandtab
"set autoindent
set number
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
nnoremap <leader>ga <Cmd>Git add %<CR>
nnoremap <leader>gc :Git commit -m ""<Left>
nnoremap <leader>GA <Cmd>Git add .<CR>
nnoremap <leader>gf <Cmd>Git fetch<CR>
nnoremap <leader>gy <Cmd>Git push<CR>
nnoremap <leader>gb <Cmd>GBrowse<CR>
nnoremap <leader>gd <Cmd>Gvdiffsplit<CR>

nnoremap <leader>bl <Cmd>set background=light<CR>
nnoremap <leader>bd <Cmd>set background=dark<CR>

set background=dark
colorscheme solarized8

let NERDTreeShowHidden=1
let g:airline_powerline_fonts=1
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
"let g:strip_only_modified_lines=1
let g:rustfmt_autosave=1
let g:vim_svelte_plugin_load_full_syntax = 1
let g:vim_svelte_plugin_use_typescript = 1

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

autocmd BufWritePre *.tf lua vim.lsp.buf.formatting()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

":so $MYVIMRC
":e $MYVIMRC

lua <<EOF
require('gitsigns').setup()
require('hop').setup()

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

EOF
