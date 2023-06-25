local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
	--Themes
	"ellisonleao/gruvbox.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	"folke/tokyonight.nvim",
	"olimorris/onedarkpro.nvim",

	"jose-elias-alvarez/null-ls.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "│",
				show_foldtext = false,
				context_char = "▎",
				space_char_blankline = " ",
				show_current_context = false,
				show_current_context_start = false,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"debugloop/telescope-undo.nvim",
		},
		lazy = true,
	},

	{
		"ThePrimeagen/harpoon",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("harpoon").setup({
				tabline = true,
				save_on_toggle = false,
			})
		end,
	},
	"windwp/nvim-ts-autotag",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				enable_autocmd = false,
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		commit = "caaccee",

		config = function()
			require("hop").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		priority = 1000,
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		-- config = function()
		-- 	require("packages.nvim-tree")
		-- end,
	},
	-- Snippets plugin
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	--LSP
	"ray-x/lsp_signature.nvim",
	"williamboman/mason-lspconfig.nvim",
	{ "williamboman/mason.nvim" },
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"onsails/lspkind-nvim",
	"p00f/nvim-ts-rainbow",
	"nvim-treesitter/nvim-treesitter",
	"hrsh7th/cmp-buffer",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	"glepnir/lspsaga.nvim",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"windwp/nvim-autopairs",
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = true,
				write_all_buffers = false,
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = function()
			require("fidget").setup({
				text = {
					spinner = "dots",
					done = "󰸞 ",
				},
				window = {
					blend = 0,
				},
			})
		end,
	},
})
