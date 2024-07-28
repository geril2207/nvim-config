-- Navigation with jump motions.
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			jump = { nohlsearch = true },
			prompt = {
				-- Place the prompt above the statusline.
				win_config = { row = -3 },
			},
			modes = {
				-- Enable flash when searching with ? or /
				search = { enabled = true },
			},
		},
		keys = {
			{
				"<leader>j",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
}
