return {
	{
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		event = "VeryLazy",
		opts = {
			current_line_blame_opts = {
				delay = 200,
			},
		},
	},
}
