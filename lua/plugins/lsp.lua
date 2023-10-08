return {
	"jose-elias-alvarez/null-ls.nvim",
	"ray-x/lsp_signature.nvim",
	"williamboman/mason-lspconfig.nvim",
	{ "williamboman/mason.nvim" },
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config.lsp")
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
}
