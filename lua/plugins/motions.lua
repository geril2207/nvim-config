local map_utils = require("utils.map")
local mcmd = map_utils.cmd
local double_leader = map_utils.double_leader

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
				uppercase = false,
				style = "overlay",
			},
		},
		keys = {
			{
				"W",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				double_leader("f"),
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{
		"hadronized/hop.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				double_leader("w"),
				mcmd("HopWordAC"),
			},
			{
				double_leader("W"),
				mcmd("HopWord"),
			},
			{
				double_leader("b"),
				mcmd("HopWordBC"),
			},
		},
	},
}
