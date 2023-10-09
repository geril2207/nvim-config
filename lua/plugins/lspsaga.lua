return {
	{
		"nvimdev/lspsaga.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.lspsaga")
		end,
	},
}
