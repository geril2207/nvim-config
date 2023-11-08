local api = vim.api

local colors = require("catppuccin.palettes").get_palette("mocha")
local nvim_tree_cursor_line_fg = colors.peach

local tree_utils = require("config.plugins.nvim-tree.utils")

api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
	pattern = "NvimTree*",
	callback = function()
		if not tree_utils.is_float then
			api.nvim_set_hl(0, "NvimTreeCursorLine", { fg = nvim_tree_cursor_line_fg, bg = colors.surface0 })
		end
	end,
})

api.nvim_create_autocmd("BufLeave", {
	pattern = "NvimTree*",
	callback = function()
		if not tree_utils.is_float then
			api.nvim_set_hl(0, "NvimTreeCursorLine", { fg = nvim_tree_cursor_line_fg, bg = colors.none })
		end
	end,
})
