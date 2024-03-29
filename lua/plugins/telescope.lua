return {
	{
		"nvim-telescope/telescope.nvim",
		dev = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		cmd = "Telescope",
		config = function()
			require("config.plugins.telescope")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = { enabled = true, win_options = { winblend = 0, sidescrolloff = 7 } },
				select = { enabled = true },
			})
		end,
	},
}
