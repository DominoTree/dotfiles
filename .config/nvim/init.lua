local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
-- vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.wo.signcolumn = 'yes'


require('lazy').setup({
  {'nvim-treesitter/nvim-treesitter'},
  {'lewis6991/gitsigns.nvim'},
  {'edkolev/tmuxline.vim'},
  {'nvim-lualine/lualine.nvim'},
  {'feline-nvim/feline.nvim'},
  {'catppuccin/nvim', name = 'catppuccin'},
  {'tjdevries/colorbuddy.nvim'}, -- required for neosolarized
  {'rebelot/kanagawa.nvim'},
  {'overcache/NeoSolarized'},
  {'nvim-tree/nvim-web-devicons'},
  {'nvim-tree/nvim-tree.lua'},
  {'nvim-lua/plenary.nvim'}, -- required by telescope
  {'nvim-telescope/telescope.nvim', tag = '0.1.1'},
  {'williamboman/mason.nvim', run = ':MasonUpdate'},
  {'williamboman/mason-lspconfig.nvim'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {'saadparwaiz1/cmp_luasnip'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
})

vim.g.neosolarized_italic = 1

vim.cmd("colorscheme kanagawa")

-- tree-sitter
require('nvim-treesitter.configs').setup({
  auto_install = true,
  ensure_installed = {
    "arduino",
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "gomod",
    "gosum",
    "go",
    "html",
    "http",
    "ini",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "prisma",
    "proto",
    "python",
    "regex",
    "rust",
    "scss",
    "sql",
    "svelte",
    "terraform",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
  },
})

local cmp = require('cmp')
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      }, {
      { name = 'buffer' },
    })
})

-- lspconfigs
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.cssls.setup {capabilities = capabilities}
lspconfig.html.setup {capabilities = capabilities}
lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.lua_ls.setup {capabilities = capabilities}
lspconfig.prismals.setup {capabilities = capabilities}
lspconfig.rust_analyzer.setup {capabilities = capabilities}
lspconfig.svelte.setup {capabilities = capabilities}
lspconfig.terraformls.setup {capabilities = capabilities}
lspconfig.tsserver.setup {capabilities = capabilities}

-- install and update language servers
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
})

-- require('feline').setup()
-- require('feline').winbar.setup()

require('lualine').setup({})
--   options = {
--     theme = 'solarized_dark',
--   },
-- })

require('gitsigns').setup()

-- start Tmuxline
--vim.g.tmuxline_theme = "vim_statusline_1"
--vim.api.nvim_create_autocmd("VimEnter", {
    --command = "Tmuxline",
--})

require("nvim-tree").setup()

require('telescope').setup()
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-g>', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<cr>', {})

