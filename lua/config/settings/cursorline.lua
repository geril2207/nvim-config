local opt = vim.opt

-- opt.cursorline = vim.fn.has("gui_running") == 1 and vim.g.fvim_loaded ~= 1

opt.cursorline = true -- Highlight the current line
opt.cursorlineopt = "number"
local cursor_line_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
-- local set_cursorline = function(event, value, pattern)
-- 	vim.api.nvim_create_autocmd(event, {
-- 		group = group,
-- 		pattern = pattern,
-- 		callback = function()
-- 			vim.opt_local.cursorline = value
-- 		end,
-- 	})
-- end
-- set_cursorline("WinLeave", false)
-- set_cursorline("WinEnter", true)

-- local set_cursorlineopt = function(event, value, pattern)
-- 	vim.api.nvim_create_autocmd(event, {
-- 		group = group,
-- 		pattern = pattern,
-- 		callback = function()
-- 			vim.opt_local.cursorlineopt = value
-- 		end,
-- 	})
-- end

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = cursor_line_group,
-- 	pattern = "NvimTree",
--   callback = function ()
--     vim.api.nvim_create_autocmd("WinEnter", )
--   end
-- })
--
-- vim.api.nvim_create_autocmd("WinLeave", {
-- 	group = cursor_line_group,
-- 	pattern = "Filetype NvimTree",
-- 	callback = function()
-- 		vim.opt_local.cursorlineopt = "number"
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("WinEnter", {
-- 	group = cursor_line_group,
-- 	pattern = "Filetype NvimTree",
-- 	callback = function()
-- 		print(vim.opt_local.cursorlineopt)
-- 		vim.opt_local.cursorlineopt = "both"
-- 	end,
-- })

-- set_cursorlineopt("WinLeave", false)
-- set_cursorlineopt("WinEnter", true)
