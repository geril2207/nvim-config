return {
	{
		"geril2207/simple-winbar.nvim",
		priority = 1,
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
				},

				-- left_spacing = function()
				-- 	local textoff = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff
				-- 	local value = ""
				--
				-- 	for _ = 1, textoff - 2, 1 do
				-- 		value = value .. " "
				-- 	end
				--
				-- 	return value
				-- end,
			})
		end,
	},
	-- {
	-- 	"geril2207/winbar.nvim",
	-- 	priority = 1,
	-- 	branch = "main",
	-- 	enabled = false,
	-- 	dev = false,
	-- 	config = function()
	-- 		local colors = require("catppuccin.palettes").get_palette("mocha")
	-- 		require("winbar").setup({
	-- 			enabled = true,
	-- 			change_events = { "DirChanged", "BufEnter", "BufFilePost", "BufWritePost" },
	-- 			show_file_path = true,
	-- 			show_symbols = false,
	-- 			left_spacing = function()
	-- 				local textoff = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff
	-- 				local value = ""
	--
	-- 				for _ = 1, textoff - 2, 1 do
	-- 					value = value .. " "
	-- 				end
	--
	-- 				return value
	-- 			end,
	--
	-- 			colors = {
	-- 				path = colors.overlay0,
	-- 				file_name = colors.flamingo,
	-- 			},
	--
	-- 			icons = {
	-- 				file_icon_default = "",
	-- 				seperator = "›",
	-- 				editor_state = "●",
	-- 				lock_icon = "",
	-- 			},
	--
	-- 			exclude_filetype = {
	-- 				"help",
	-- 				"startify",
	-- 				"dashboard",
	-- 				"packer",
	-- 				"neogitstatus",
	-- 				"NvimTree",
	-- 				"Trouble",
	-- 				"alpha",
	-- 				"lir",
	-- 				"Outline",
	-- 				"spectre_panel",
	-- 				"toggleterm",
	-- 				"qf",
	-- 				"harpoon",
	-- 				"TelescopePrompt",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
