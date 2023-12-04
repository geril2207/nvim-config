return {
	{
		"crispgm/nvim-tabline",
		opts = {
			modify_indicator = "",
		},
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		priority = 100,
		enabled = false,
		config = function()
			local bufferline = require("bufferline")

			bufferline.setup({
				options = {
					mode = "tabs",
					style_preset = bufferline.style_preset.no_italic,
					max_name_length = 30,

					show_buffer_close_icons = false,
					always_show_bufferline = false,
					modified_icon = "",
					show_close_icon = false,
				},
			})
		end,
	},
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		enabled = false,
		config = function()
			require("incline").setup({
				hide = {
					only_win = true,
					focused_win = true,
					cursorline = "focused_win",
				},
				window = { margin = { vertical = 1, horizontal = 0 } },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
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
				},
				-- disable = function()
				-- 	return #vim.api.nvim_list_tabpages() ~= 1
				-- end,

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
