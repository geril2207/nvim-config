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
	-- use("navarasu/onedark.nvim")
	"olimorris/onedarkpro.nvim",
	--Prettier
	"jose-elias-alvarez/null-ls.nvim",
	"MunifTanjim/prettier.nvim",

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

	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
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
		config = function()
			require("packages.nvim-tree")
		end,
	},
	--LSP
	"rafamadriz/friendly-snippets",
	{
		"L3MON4D3/LuaSnip",

		config = function()
			require("luasnip.loaders.from_vscode").load()
			require("luasnip").filetype_extend("typescript", { "typescriptreact", "javascript", "javascriptreact" })
			require("luasnip").filetype_extend("javascript", { "typescript", "javascriptreact" })
		end,
	}, -- Snippets plugin
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
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
-- return require("packer").startup(function(use)
-- 	use({
-- 		"stevearc/dressing.nvim",
-- 		config = function()
-- 			require("dressing").setup()
-- 		end,
-- 	})
-- 	use("wbthomason/packer.nvim")
-- 	--Themes
-- 	use("ellisonleao/gruvbox.nvim")
-- 	use({ "navarasu/onedark.nvim" })
-- 	-- use { "olimorris/onedarkpro.nvim" }
-- 	use({ "catppuccin/nvim", as = "catppuccin" })
-- 	use("folke/tokyonight.nvim")
-- 	use("EdenEast/nightfox.nvim")
-- 	use("shaunsingh/nord.nvim")
--
-- 	--Prettier
-- 	use("jose-elias-alvarez/null-ls.nvim")
-- 	use("MunifTanjim/prettier.nvim")
--
-- 	--Telescope
-- 	use({
-- 		"nvim-telescope/telescope.nvim",
-- 		tag = "0.1.0",
-- 		dependencies = { { "nvim-lua/plenary.nvim" } },
-- 	})
--
-- 	use({
-- 		"ThePrimeagen/harpoon",
-- 		dependencies = "nvim-lua/plenary.nvim",
-- 		config = function()
-- 			require("harpoon").setup({
-- 				tabline = true,
-- 				save_on_toggle = false,
-- 			})
-- 		end,
-- 	})
-- 	-- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
--
-- 	use("windwp/nvim-ts-autotag")
-- 	use("JoosepAlviste/nvim-ts-context-commentstring")
-- 	use({
-- 		"numToStr/Comment.nvim",
-- 	})
-- 	use({ "akinsho/bufferline.nvim", tag = "v2.*", dependencies = "kyazdani42/nvim-web-devicons" })
-- 	use("famiu/bufdelete.nvim")
--
-- 	use({
-- 		"phaazon/hop.nvim",
-- 		branch = "v2", -- optional but strongly recommended
-- 		commit = "caaccee",
--
-- 		config = function()
-- 			require("hop").setup()
-- 		end,
-- 	})
-- 	use({
-- 		"lewis6991/gitsigns.nvim",
-- 		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
-- 		config = function()
-- 			require("gitsigns").setup()
-- 		end,
-- 	})
-- 	use({
-- 		"kyazdani42/nvim-tree.lua",
-- 		dependencies = {
-- 			"nvim-tree/nvim-web-devicons", -- optional, for file icons
-- 		},
-- 		tag = "nightly", -- optional, updated every week. (see issue #1193)
-- 	})
-- 	--LSP
-- 	use("rafamadriz/friendly-snippets")
-- 	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
-- 	use("L3MON4D3/LuaSnip") -- Snippets plugin
-- 	use({ "williamboman/mason.nvim" })
-- 	use("neovim/nvim-lspconfig")
-- 	use("hrsh7th/cmp-nvim-lsp")
-- 	use("onsails/lspkind-nvim")
-- 	use("p00f/nvim-ts-rainbow")
-- 	use("nvim-treesitter/nvim-treesitter")
-- 	use("hrsh7th/cmp-buffer")
-- 	use("hrsh7th/nvim-cmp")
-- 	use("hrsh7th/cmp-path")
-- 	use("glepnir/lspsaga.nvim")
-- 	use({
-- 		"nvim-lualine/lualine.nvim",
-- 		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
-- 	})
-- 	use("windwp/nvim-autopairs")
-- 	use({
-- 		"Pocco81/auto-save.nvim",
-- 		config = function()
-- 			require("auto-save").setup({
-- 				enabled = true,
-- 				write_all_buffers = false,
-- 			})
-- 		end,
-- 	})
-- end)
