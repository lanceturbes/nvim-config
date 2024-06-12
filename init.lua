-- LAZYVIM BOOTSTRAP START
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- LAZYVIM BOOTSTRAP END

-- USER SETTINGS START
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.wo.relativenumber = true
vim.g.mapleader = " "
-- USER SETTINGS END

-- PLUGIN MANAGER START
require("lazy").setup({
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "stevearc/conform.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "vscode",
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "|" },
		},
	},
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"Mofiqul/vscode.nvim",
		init = function()
			require("vscode").load("dark")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "tpope/vim-fugitive" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			map("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
			map("n", "<leader>q", "<Cmd>BufferClose<CR>", opts)
		end,
		opts = {},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = {
				float = {
					enable = true,
				},
			},
		},
		init = function()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			map("n", "<leader>e", "<Cmd>NvimTreeOpen<CR>", opts)
		end,
	},
})
-- PLUGIN MANAGER END

-- LANGUAGE SERVER START
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})
-- LANGUAGE SERVER END

-- FORMAT ON SAVE START
require("conform").setup({
	formatters_by_ft = {
		cs = { "csharpier" },
		css = { "prettierd" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		lua = { "stylua" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		vue = { "prettierd" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
-- FORMAT ON SAVE END

-- FUZZY FINDER START
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
-- FUZZY FINDER END
