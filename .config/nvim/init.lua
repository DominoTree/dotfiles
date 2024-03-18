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
vim.g.omni_sql_no_default_maps = 1
vim.g.rustfmt_autosave = true
vim.opt.background = 'dark'
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
-- vim.opt.iskeyword:remove("_")
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 1000
vim.wo.signcolumn = 'yes'

require('lazy').setup({
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'lewis6991/gitsigns.nvim' },
	{ 'lukas-reineke/indent-blankline.nvim' },
	{ 'edkolev/tmuxline.vim' },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'rebelot/kanagawa.nvim' },
	{ 'maxmx03/solarized.nvim' },
	{ 'f-person/auto-dark-mode.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'nvim-tree/nvim-tree.lua' },
	{ 'nvim-lua/plenary.nvim' }, -- required by telescope
	{ 'nvim-telescope/telescope.nvim' },
	{ 'williamboman/mason.nvim',            run = ':MasonUpdate' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'github/copilot.vim' },
})

vim.cmd("colorscheme solarized")

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

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "tab:→ "
-- vim.opt.listchars:append "eol:↴"

require('ibl').setup()

require('auto-dark-mode').setup()

local cmp = require('cmp')
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body)   -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = true }),   -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },   -- For luasnip users.
	}, {
		{ name = 'buffer' },
	}, {
		{ name = 'path' },
	})
})

-- lspconfigs
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.cssls.setup { capabilities = capabilities }
lspconfig.html.setup { capabilities = capabilities }
lspconfig.intelephense.setup { capabilities = capabilities }
--lspconfig.jedi_language_server.setup {capabilities = capabilities}
lspconfig.jsonls.setup { capabilities = capabilities }
lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.prismals.setup { capabilities = capabilities }
lspconfig.pylsp.setup { capabilities = capabilities }
lspconfig.rust_analyzer.setup { capabilities = capabilities }
lspconfig.svelte.setup { capabilities = capabilities }
lspconfig.tailwindcss.setup { capabilities = capabilities }
lspconfig.terraformls.setup { capabilities = capabilities }
lspconfig.tsserver.setup { capabilities = capabilities }

-- install and update language servers
require('mason').setup()
require('mason-lspconfig').setup({
	automatic_installation = true,
})

require('lualine').setup({})

require('gitsigns').setup()

-- start Tmuxline
--vim.g.tmuxline_theme = "vim_statusline_1"
--vim.api.nvim_create_autocmd("VimEnter", {
--command = "Tmuxline jellybeans",
--})

require("nvim-tree").setup()


require('telescope').setup()
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-g>', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<cr>', {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function() vim.diagnostic.open_float() end
})
