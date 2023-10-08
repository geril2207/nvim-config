return {
	{
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		config = function()
			require("gitsigns").setup({
				current_line_blame_opts = {
					delay = 200,
				},
			})
		end,
	},
}
