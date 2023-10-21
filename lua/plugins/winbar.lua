return {
	{
		"geril2207/winbar.nvim",
		priority = 1,
		config = function()
			local colors = require("catppuccin.palettes").get_palette("mocha")
			require("winbar").setup({
				enabled = true,
				show_file_path = true,
				show_symbols = false,

				colors = {
					path = colors.overlay0,
					file_name = colors.flamingo,
				},

				icons = {
					file_icon_default = "",
					seperator = "›",
					editor_state = "●",
					lock_icon = "",
				},

				exclude_filetype = {
					"help",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"alpha",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"qf",
					"harpoon",
				},
			})
		end,
	},
}
