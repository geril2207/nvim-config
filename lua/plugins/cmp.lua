return {
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		config = function()
			require("config.plugins.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind-nvim",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					{
						"L3MON4D3/LuaSnip",
						dependencies = {
							"rafamadriz/friendly-snippets",
						},
						config = function()
							require("config.plugins.luasnip")
						end,
					},
				},
			},
		},
	},
}
