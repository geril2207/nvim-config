local api = vim.api

local colors = require("catppuccin.palettes").get_palette("mocha")
local nvim_tree_cursor_line_fg = colors.peach

local tree_utils = require("config.plugins.nvim-tree.utils")

local function toggle_tree_focus()
	if vim.bo.filetype == "NvimTree" then
		vim.opt_local.guicursor:append("n:Cursor/lCursor")
		if not tree_utils.is_float then
			api.nvim_set_hl(0, "NvimTreeCursorLine", { fg = nvim_tree_cursor_line_fg, bg = colors.surface0 })
		end
	else
		vim.opt_local.guicursor:remove("n:Cursor/lCursor")
		if not tree_utils.is_float then
			api.nvim_set_hl(0, "NvimTreeCursorLine", { fg = nvim_tree_cursor_line_fg, bg = colors.none })
		end
	end
end

api.nvim_create_autocmd({ "BufEnter" }, {
	callback = toggle_tree_focus,
})

api.nvim_create_autocmd({ "Filetype" }, {
	pattern = "lazy",
	callback = toggle_tree_focus,
})
