local nvim_tree_group = vim.api.nvim_create_augroup("NvimTreeeCLGroup", { clear = true })
local colors = require("onedarkpro").get_palette("mocha")

local tree_utils = require("config.plugins.nvim-tree.utils")

local nvim_tree_cursor_line_fg = colors.peach

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "NvimTree*",
	callback = function()
		if not tree_utils.is_float then
			vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { fg = nvim_tree_cursor_line_fg, bg = colors.surface0 })
		end
	end,
	group = nvim_tree_group,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "NvimTree*",
	callback = function()
		if not tree_utils.is_float then
			vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { fg = nvim_tree_cursor_line_fg, bg = colors.none })
		end
	end,
	group = nvim_tree_group,
})
