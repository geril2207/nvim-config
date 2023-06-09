return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	--Themes
	use("ellisonleao/gruvbox.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("folke/tokyonight.nvim")
	-- use("navarasu/onedark.nvim")
	use "olimorris/onedarkpro.nvim"
	--Prettier
	use("jose-elias-alvarez/null-ls.nvim")
	use("MunifTanjim/prettier.nvim")


	use "lukas-reineke/indent-blankline.nvim"

	--Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"ThePrimeagen/harpoon",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("harpoon").setup({
				tabline = true,
				save_on_toggle = false,
			})
		end,
	})
	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				enable_autocmd = false,
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	})
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		commit = "caaccee",

		config = function()
			require("hop").setup()
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})
	--LSP
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").load()
			require("luasnip").filetype_extend("typescript", { "typescriptreact", "javascript", "javascriptreact" })
			require("luasnip").filetype_extend("javascript", { "typescript", "javascriptreact" })
		end,
	}) -- Snippets plugin
	use({ "williamboman/mason.nvim" })
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("onsails/lspkind-nvim")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-path")
	use("glepnir/lspsaga.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use("windwp/nvim-autopairs")
	use({
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = true,
				write_all_buffers = false,
			})
		end,
	})
	use({
		"j-hui/fidget.nvim",
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
	})
end)
