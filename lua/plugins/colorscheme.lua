return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			-- require("config.plugins.catppuccin")
		end,
		enabled = false,
	},
	{
		"geril2207/onedarkpro.nvim",
		dev = true,
		lazy = false,
		priority = 1001,
		config = function()
			require("onedarkpro").setup({
				transparent = true,
				highlight_overrides = function(colors)
					return {
						-- Normal = { bg = colors.background0 },
					}
				end,
			})
			vim.cmd("colorscheme onedarkpro")
		end,
	},
}
