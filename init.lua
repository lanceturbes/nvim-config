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
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "lewis6991/gitsigns.nvim" },
	{ "Mofiqul/vscode.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "tpope/vim-fugitive" },
})
-- PLUGIN MANAGER END

-- COLOR SCHEME START
require("vscode").load("dark")

require("lualine").setup({
	options = {
		theme = "vscode",
		icons_enabled = false,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
})
-- COLOR SCHEME END

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
		lua = { "stylua" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascriptreact = { "prettierd" },
		cs = { "csharpier" },
		vue = { "prettierd" },
		css = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
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

-- SYMBOLS START
require("ibl").setup({
	indent = { char = "|" },
})

require("gitsigns").setup()
-- SYMBOLS END
