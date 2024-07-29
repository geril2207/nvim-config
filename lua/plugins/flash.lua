-- Navigation with jump motions.
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			jump = { nohlsearch = true },
			modes = {
				-- Enable flash when searching with ? or /
				search = { enabled = false },
				char = { enabled = false },
			},
			label = {

				style = "overlay",
			},
		},
		keys = {
			{
				"<leader>W",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
}
