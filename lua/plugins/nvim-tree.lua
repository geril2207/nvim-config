return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {
			override = {
				["gql"] = {
					icon = "󰡷",
					color = "#e535ab",
					cterm_color = "199",
					name = "GQL",
				},
				["graphql"] = {
					icon = "󰡷",
					color = "#e535ab",
					cterm_color = "199",
					name = "GQL",
				},
				["ts"] = {
					icon = "",
					color = "#519aba",
					name = "TS",
				},
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		priority = 100,
		lazy = false,
		dev = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.nvim-tree")
		end,
	},
}
