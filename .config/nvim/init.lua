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
vim.opt.background = 'light'
vim.wo.signcolumn = 'yes'


require('lazy').setup({
  {'tanvirtin/vgit.nvim'},
  {'edkolev/tmuxline.vim'},
  {'nvim-lualine/lualine.nvim'},
  {'tjdevries/colorbuddy.nvim'}, -- required for neosolarized
  {'overcache/NeoSolarized'},
  {'ms-jpq/chadtree', branch = 'chad'},
  {'nvim-tree/nvim-web-devicons'}, -- used by chadtree
  {'nvim-lua/plenary.nvim'}, -- required by telescope
  {'nvim-telescope/telescope.nvim', tag = '0.1.1'},
  {'williamboman/mason.nvim', run = ':MasonUpdate'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'ms-jpq/coq_nvim', branch = 'coq'},
})

vim.cmd [[colorscheme NeoSolarized]]

-- lspconfigs
local lspconfig = require('lspconfig')
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.jsonls.setup {}
lspconfig.lua_ls.setup {}
lspconfig.prismals.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.svelte.setup {}
lspconfig.terraformls.setup {}
lspconfig.tsserver.setup {}

-- install and update language servers
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
})

-- coq autocompletion
vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    lsp = {
      enabled = true,
      --resolve_timeout = 2000,
    },
    tree_sitter = {
      enabled = true,
    },
    snippets = {
      enabled = false,
    },
  },
  --limits = {
    --completion_auto_timeout = 2000,
    --completion_manual_timeout = 5000,
  --}
}
local coq = require('coq')

-- workaround for COQ not autostarting for some reason
vim.api.nvim_create_autocmd("VimEnter", {
    command = "COQnow -s",
})

require('lualine').setup({
  options = {
    theme = 'solarized_light',
  },
})

require('vgit').setup()

-- start Tmuxline
--vim.g.tmuxline_theme = "vim_statusline_1"
--vim.api.nvim_create_autocmd("VimEnter", {
    --command = "Tmuxline",
--})

local chadtree_settings = {
  view = {
    window_options = {
      signcolumn = "yes",
    },
  },
  options = {
    show_hidden = true,
  },
  theme = {
    text_colour_set = "solarized_light",
  },
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

require('telescope').setup()
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-g>', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<C-e>', ':CHADopen<cr>', {})

