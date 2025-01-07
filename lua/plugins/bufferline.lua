return {
	{
		"crispgm/nvim-tabline",
		opts = {
			show_modify = false,
		},
	},
	{
		"geril2207/simple-winbar.nvim",
		priority = 1,
		enabled = true,
		dev = false,
		config = function()
			require("simple-winbar").setup({
				show_path = false,
				exclude_filetypes = {
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
					"TelescopePrompt",
					"fzf",
					"",
				},
				left_spacing = " ",
			})
		end,
	},
}
