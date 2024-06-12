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
vim.opt.colorcolumn = { 80, 120 }
vim.opt.showmode = false
vim.opt.scrolloff = 8
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
				-- theme = "vscode",
				theme = "rose-pine",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
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
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	init = function()
	-- 		require("vscode").load("dark")
	-- 	end,
	-- },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			styles = {
				italic = false,
				transparency = true,
			},
		},
		init = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					"obj",
					"bin",
				},
			},
		},
	},
	{ "tpope/vim-fugitive" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
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
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
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

-- MAPPINGS START
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<S-h>", "<Cmd>bNext<CR>", opts)
vim.keymap.set("n", "<S-l>", "<Cmd>bprevious<CR>", opts)
vim.keymap.set("n", "<leader>q", "<Cmd>bd<CR>", opts)
vim.keymap.set("n", "<leader>e", "<Cmd>Ex<CR>", opts)
-- MAPPINGS END
