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
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		priority = 100,
		dev = false,
    branch = "fix/hijack_cursor-with-update-focused",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.plugins.nvim-tree")
		end,
	},
}
