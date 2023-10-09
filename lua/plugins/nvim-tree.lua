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
		version = "*",
		commit = "d8e495b2354058276cad6dd32e3efdd1d02f4da6",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.plugins.nvim-tree")
		end,
	},
}
