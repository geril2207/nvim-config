return {
	{ "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" },
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config.plugins.lsp")
		end,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			{
				"j-hui/fidget.nvim",
				event = "VeryLazy",
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
			"ray-x/lsp_signature.nvim",
		},
	},
}
