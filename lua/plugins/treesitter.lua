return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
			{ "windwp/nvim-autopairs", opts = { disable_filetype = { "TelescopePrompt", "vim" } } },

			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			require("config.plugins.treesitter")
		end,
	},
}
